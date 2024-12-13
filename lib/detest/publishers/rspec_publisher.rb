require 'rspec/core'

module Detest
  module Publishers
    class RspecPublisher
      def initialize(args)
        @options = RSpec::Core::ConfigurationOptions.new(args)
        temp_runner = RSpec::Core::Runner.new(@options)
        temp_runner.configure($stderr, $stdout)
        @configuration = temp_runner.configuration
      end

      def enqueue_specs(adapter)
        sf = spec_files
        puts spec_files.inspect
        adapter.enqueue(spec_files)
      end

      def spec_files
        our_cwd = Dir.pwd
        @configuration.files_to_run.map do |s_file|
          Pathname(s_file).relative_path_from(our_cwd).to_s
        end
      end
    end
  end
end
