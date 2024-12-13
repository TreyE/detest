require 'detest'

adapter = Detest::Adapters::RedisAdapter.new("frank")

client = Detest::Workers::RspecWorker.boot(ARGV)
client.run(adapter)