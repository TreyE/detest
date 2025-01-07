require 'detest'

adapter = Detest::Adapters::RedisAdapter.new("cucumber-frank")

Detest::Workers::CucumberWorker.run!(adapter, ARGV)