require 'test_puller'

adapter = TestPuller::Adapters::RedisAdapter.new("frank")

server = TestPuller::Publishers::RspecPublisher.new(ARGV)
server.enqueue_specs(adapter)