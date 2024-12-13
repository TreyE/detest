require 'test_puller'

adapter = TestPuller::Adapters::RedisAdapter.new("frank")

client = TestPuller::Workers::RspecWorker.boot(ARGV)
client.run_until_empty(adapter)