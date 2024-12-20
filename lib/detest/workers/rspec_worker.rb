require 'rspec/core'

module Detest
  module Workers
    class RspecWorker
      def initialize(args)
        @options = RSpec::Core::ConfigurationOptions.new(args)
        @runner = RSpec::Core::Runner.new(@options)
        @runner.configure($stderr, $stdout)
        @configuration = @runner.configuration
        @our_cwd = Dir.pwd
        setup
        @reporter = @runner.configuration.reporter
        @reporter.start(0)
        @passed = true
      end

      def setup
        @configuration.load_spec_files

        ensure
        @runner.world.announce_filters
      end

      def run(adapter)
        adapter.record_worker
        if ENV["DETEST_RERUN"] == "true"
          run_failures(adapter)
        else
          run_until_empty(adapter)
        end
        adapter.end_worker
      end

      def run_failures(adapter)
        while spec = adapter.fpop
          run_spec(adapter, spec)
          bail?(adapter, spec)
        end
        finish(adapter)
      end

      def run_until_empty(adapter)
        while spec = adapter.pop
          run_spec(adapter, spec)
          bail?(adapter, spec)
        end
        finish(adapter)
      end

      def bail?(adapter, spec)
        if RSpec.world.wants_to_quit
          adapter.log_failure(spec)
          @reporter.finish
          adapter.end_worker
          exit(1)
        end
      end

      def finish(adapter)
        @reporter.finish
        adapter.end_worker
        exit(exit_code(@passed))
      end

      def exit_code(passed)
        return 1 unless passed
        0
      end

      def run_spec(adapter, spec_path)
        example_groups = @runner.world.example_groups.select do |eg|
          Pathname(File.expand_path(eg.file_path)).relative_path_from(@our_cwd).to_s == spec_path
        end

        examples_count = @runner.world.example_count(example_groups)
        @configuration.with_suite_hooks do
          if examples_count == 0 && @configuration.fail_if_no_examples
            return @configuration.failure_exit_code
          end

          egs_passed = example_groups.map { |g| g.run(@reporter) }.all?
          adapter.log_failure(spec_path) unless egs_passed

          @passed = @passed && egs_passed
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
