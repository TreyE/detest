require "redis"

module Detest
  module Adapters
    class RedisAdapter
      attr_reader :redis, :redis_session_key, :redis_session_failure_key,
                  :redis_session_retry_key, :redis_session_runner_key

      def initialize(session_key, *args)
        @redis = Redis.new(*args)
        @redis_session_key = "__tp_adapter_test_storage_#{session_key}" 
        @redis_session_failure_key = "__tp_adapter_test_failure_storage_#{session_key}"
        @redis_session_runner_key = "__tp_adapter_test_runner_count_storage_#{session_key}"
        @redis_session_retry_key = "__tp_adapter_test_retry_error_storage_#{session_key}"
      end

      def record_worker(pipeline = redis)
        pipeline.incr(@redis_session_runner_key)
      end

      def end_worker(pipeline = redis)
        decr = pipeline.decr(@redis_session_runner_key)
        if decr < 1
          smem = pipeline.smembers(@redis_session_failure_key)
          smem.each do |smember|
            pipeline.smove(@redis_session_failure_key, @redis_session_retry_key, smember)
          end
        end
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
        @redis.spop(@redis_session_retry_key)
      end
    end
  end
end