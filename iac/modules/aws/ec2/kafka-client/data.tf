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

    cat <<EOT > /opt/kafka/config/client_sasl_iam.properties
    security.protocol=SASL_SSL
    sasl.mechanism=AWS_MSK_IAM
    sasl.jaas.config=software.amazon.msk.auth.iam.IAMLoginModule required;
    sasl.client.callback.handler.class=software.amazon.msk.auth.iam.IAMClientCallbackHandler
    EOT

    echo "export KAFKA_OPTS=\"-Xms512m -Xmx1g\"" >> /home/ec2-user/.bash_profile

    echo "export var.bootstrap_serverS_SASL_IAM=${var.bootstrap_server}" >> /home/ec2-user/.bash_profile
    echo "export CLASSPATH=\"/opt/kafka/libs/\"" >> /home/ec2-user/.bash_profile
        echo "alias create_topic=\"/opt/kafka/bin/kafka-topics.sh --create --topic ${var.topic_name} --partitions 2 --replication-factor 3 --bootstrap-server ${var.bootstrap_server}\"" >> /home/ec2-user/.bash_profile
        echo "alias list_topics=\"/opt/kafka/bin/kafka-topics.sh --list --bootstrap-server ${var.bootstrap_server}\"" >> /home/ec2-user/.bash_profile
        echo "alias start_consumer=\"/opt/kafka/bin/kafka-console-consumer.sh --topic ${var.topic_name} --group ${var.group_name} --bootstrap-server ${var.bootstrap_server} --consumer.config /opt/kafka/config/client_sasl_iam.properties\"" >> /home/ec2-user/.bash_profile
        echo "alias start_producer=\"/opt/kafka/bin/kafka-console-producer.sh --topic ${var.topic_name} --bootstrap-server ${var.bootstrap_server} --producer.config /opt/kafka/config/client_sasl_iam.properties\"" >> /home/ec2-user/.bash_profile
  EOF
}
