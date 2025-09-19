resource "aws_msk_configuration" "this" {
  name                = var.name
  kafka_versions      = [var.kafka_version]
  server_properties   = <<-EOT
    auto.create.topics.enable = false
    default.replication.factor = 2
    log.retention.hours = 72
    min.insync.replicas = 1
    num.io.threads = 8
    num.network.threads = 5
    num.partitions = 2
    num.replica.fetchers = 2
    replica.lag.time.max.ms = 30000
    socket.receive.buffer.bytes = 102400
    socket.request.max.bytes = 104857600
    socket.send.buffer.bytes = 102400
    unclean.leader.election.enable = true
    zookeeper.session.timeout.ms = 18000
  EOT
}
