require 'rspec/core'

module TestPuller
  module Workers
    class RspecWorker
      def initialize(args)
        @options = RSpec::Core::ConfigurationOptions.new(args)
        temp_runner = RSpec::Core::Runner.new(@options)
        temp_runner.configure($stderr, $stdout)
        @configuration = temp_runner.configuration
        @reporter = temp_runner.configuration.reporter
        @reporter.start(0)
        @passed = true
      end

      def run_until_empty(adapter)
        while spec = adapter.pop
          run_spec(spec)
        end
        finish
      end

      def finish
        @reporter.finish
        exit(exit_code(@passed))
      end

      def exit_code(passed)
        return 1 unless passed
        0
      end

      def run_spec(spec_path)
        RSpec.reset
        @runner = RSpec::Core::Runner.new(@options, @configuration)
        @runner.configure($stderr, $stdout)
        load(spec_path)
        example_groups = @runner.world.example_groups
        examples_count = @runner.world.example_count(example_groups)
        @configuration.with_suite_hooks do
          if examples_count == 0 && @configuration.fail_if_no_examples
            return @configuration.failure_exit_code
          end

          @passed = @passed && example_groups.map { |g| g.run(@reporter) }.all?
        end
      end

      def self.boot(args)
        RSpec::Core::Runner.disable_autorun!
        RSpec::Core::Runner.trap_interrupt
        new(args)
      end
    end
  end
end
