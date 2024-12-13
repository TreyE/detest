require 'rspec/core'

module TestPuller
  module Publishers
    class RspecPublisher
      def initialize(args)
        @options = RSpec::Core::ConfigurationOptions.new(args)
        temp_runner = RSpec::Core::Runner.new(@options)
        temp_runner.configure($stderr, $stdout)
        @configuration = temp_runner.configuration
      end

      def enqueue_specs(adapter)
        adapter.enqueue(spec_files)
      end

      def spec_files
        @configuration.files_to_run
      end
    end
  end
end
