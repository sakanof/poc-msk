data "template_file" "user_data" {
  template = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y telnet
    sudo yum install -y java-17-amazon-corretto.x86_64

    cd /opt

    wget https://downloads.apache.org/kafka/3.9.0/kafka_2.13-3.9.0.tgz
    tar -xzf kafka_2.13-3.9.0.tgz
    ln -s kafka_2.13-3.9.0 kafka
    rm -f kafka_2.13-3.9.0.tgz
    wget https://github.com/aws/aws-msk-iam-auth/releases/download/v2.2.0/aws-msk-iam-auth-2.2.0-all.jar -P /opt/kafka/libs

    sudo yum install -y docker  # For Amazon Linux
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo usermod -aG docker $USER

    sudo curl -L https://github.com/docker/compose/releases/download/v2.2.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

    cat <<EOT > /opt/docker-compose-redpanda-console.yml
    version: '3.7'
    services:
      akhq:
        image: tchiotludo/akhq
        container_name: akhq
        ports:
          - "8080:8080"
        environment:
          AKHQ_CONFIGURATION: |
            akhq:
              connections:
                aws-msk-cluster:
                  properties:
                    bootstrap.servers: "${var.bootstrap_server}"
                    security.protocol: SASL_SSL
                    sasl.mechanism: AWS_MSK_IAM
                    sasl.jaas.config: software.amazon.msk.auth.iam.IAMLoginModule required;
                    sasl.client.callback.handler.class: software.amazon.msk.auth.iam.IAMClientCallbackHandler
          AWS_REGION: "${var.aws_region}"
        volumes:
          - ./secrets:/etc/kafka/secrets
        network_mode: "host"
    EOT

    cat <<EOT > /opt/docker-compose-redpanda-console.yml
    version: '3.7'
    services:
      redpanda-console:
        image: docker.redpanda.com/redpandadata/console:latest
        container_name: redpanda-console
        restart: always
        ports:
          - "8081:8080"
        environment:
          KAFKA_BROKERS: "${var.bootstrap_server}"
          AWS_REGION: "${var.aws_region}"
          AWS_ROLE_ARN: "${var.role_arn}"
          KAFKA_TLS_ENABLED: "true"
          KAFKA_SECURITY_PROTOCOL: "SASL_SSL"
          KAFKA_SASL_ENABLED: "true"
          KAFKA_SASL_MECHANISM: "AWS_MSK_IAM"
          KAFKA_SASL_JAAS_CONFIG: "software.amazon.msk.auth.iam.IAMLoginModule required"
          KAFKA_SASL_CLIENT_CALLBACK_HANDLER_CLASS: "software.amazon.msk.auth.iam.IAMClientCallbackHandler"
    EOT
    sudo docker-compose -f /opt/docker-compose-akhq.yml up -d
    sudo docker-compose -f /opt/docker-compose-redpanda-console.yml up -d
  EOF
}
