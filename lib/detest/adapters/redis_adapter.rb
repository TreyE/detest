require "redis"

module Detest
  module Adapters
    class RedisAdapter
      def initialize(session_key, *args)
        @redis = Redis.new(*args)
        @redis_session_key = "__tp_adapter_test_storage_#{session_key}" 
        @redis_session_failure_key = "__tp_adapter_test_failure_storage_#{session_key}" 
      end

      def enqueue(list)
        return if list.nil?
        return unless list.any?
        @redis.sadd(@redis_session_key, list)
      end

      def pop
        @redis.spop(@redis_session_key)
      end

      def log_failure(spec_file)
        @redis.sadd(@redis_session_failure_key, [spec_file])
      end

      def fpop
        @redis.spop(@redis_session_failure_key)
      end      
    end
  end
end