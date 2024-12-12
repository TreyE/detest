require 'test_puller'

adapter = TestPuller::Adapters::RedisAdapter.new("frank")

server = TestPuller::Servers::RspecServer.new(ARGV)
server.enqueue_specs(adapter)