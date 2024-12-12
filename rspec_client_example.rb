require 'test_puller'

adapter = TestPuller::Adapters::RedisAdapter.new("frank")

client = TestPuller::Clients::RspecClient.boot(ARGV)
client.run_until_empty(adapter)