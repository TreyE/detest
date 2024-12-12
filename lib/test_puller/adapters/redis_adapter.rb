require "redis"

module TestPuller
  module Adapters
    class RedisAdapter
      def initialize(session_key, *args)
        @redis = Redis.new(*args)
        @redis_session_key = "__tp_adapter_test_storage_#{session_key}" 
      end

      def enqueue(list)
        @redis.sadd(@redis_session_key, list)
      end

      def pop
        @redis.spop(@redis_session_key)
      end
    end
  end
end