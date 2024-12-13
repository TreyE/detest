require 'detest'

adapter = Detest::Adapters::RedisAdapter.new("frank")

server = Detest::Publishers::RspecPublisher.new(ARGV)
server.enqueue_specs(adapter)