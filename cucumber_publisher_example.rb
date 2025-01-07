require 'detest'

adapter = Detest::Adapters::RedisAdapter.new("cucumber-frank")

Detest::Publishers::CucumberPublisher.run!(adapter, ARGV)