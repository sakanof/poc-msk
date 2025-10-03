data "template_file" "user_data" {
  template = <<-EOF
    #!/bin/bash

    sudo yum update -y
    sudo yum install -y telnet
    sudo yum install -y java-17-amazon-corretto.x86_64

    sudo yum install -y docker  # For Amazon Linux
    sudo curl -L https://github.com/docker/compose/releases/download/v2.2.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

    sudo systemctl start docker
    sudo systemctl enable docker
    sudo usermod -aG docker $USER
    sudo usermod -aG docker-compose $USER

    # install terraform
    sudo yum install -y yum-utils
    sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
    sudo yum install -y terraform

    cd /opt

    # Get kafka binaries
    wget https://downloads.apache.org/kafka/3.9.0/kafka_2.13-3.9.0.tgz
    tar -xzf kafka_2.13-3.9.0.tgz
    ln -s kafka_2.13-3.9.0 kafka
    rm -f kafka_2.13-3.9.0.tgz
    wget https://github.com/aws/aws-msk-iam-auth/releases/download/v2.2.0/aws-msk-iam-auth-2.2.0-all.jar -P /opt/kafka/libs

    # Setup IAM client properties
    cat <<EOT > /opt/kafka/config/client_sasl_iam.properties
    security.protocol=SASL_SSL
    sasl.mechanism=AWS_MSK_IAM
    sasl.jaas.config=software.amazon.msk.auth.iam.IAMLoginModule required;
    sasl.client.callback.handler.class=software.amazon.msk.auth.iam.IAMClientCallbackHandler
    EOT

    # Create docker-compose to run redpanda
    cat <<EOT > /opt/docker-compose-redpanda.yml
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
    echo "alias start_redpanda=\"sudo docker-compose -f /opt/docker-compose-redpanda.yml up -d\"" >> /home/ec2-user/.bash_profile

    cat <<EOT > /opt/docker-compose-akhq.yml
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
    echo "alias start_akhq=\"sudo docker-compose -f /opt/docker-compose-akhq.yml up -d\"" >> /home/ec2-user/.bash_profile

    echo "export KAFKA_OPTS=\"-Xms512m -Xmx1g\"" >> /home/ec2-user/.bash_profile

    echo "export BOOTSTRAP_SERVER=${var.bootstrap_server}" >> /home/ec2-user/.bash_profile
    echo "export CLASSPATH=\"/opt/kafka/libs/\"" >> /home/ec2-user/.bash_profile
        echo "alias create_topic=\"/opt/kafka/bin/kafka-topics.sh --create --topic ${var.topic_name} --partitions 1 --bootstrap-server ${var.bootstrap_server} --command-config /opt/kafka/config/client_sasl_iam.properties\"" >> /home/ec2-user/.bash_profile
        echo "alias list_topics=\"/opt/kafka/bin/kafka-topics.sh --list --bootstrap-server ${var.bootstrap_server} --command-config /opt/kafka/config/client_sasl_iam.properties\"" >> /home/ec2-user/.bash_profile
        echo "alias start_consumer=\"/opt/kafka/bin/kafka-console-consumer.sh --topic ${var.topic_name} --group ${var.group_name} --bootstrap-server ${var.bootstrap_server} --consumer.config /opt/kafka/config/client_sasl_iam.properties\"" >> /home/ec2-user/.bash_profile
        echo "alias start_producer=\"/opt/kafka/bin/kafka-console-producer.sh --topic ${var.topic_name} --bootstrap-server ${var.bootstrap_server} --producer.config /opt/kafka/config/client_sasl_iam.properties\"" >> /home/ec2-user/.bash_profile
  EOF
}
