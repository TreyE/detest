require "cucumber/runtime"
require "cucumber/messages"

module Detest
  module Workers
    module Cucumber
      class Runtime < ::Cucumber::Runtime
        def run!(adapter)
          load_step_definitions
          install_wire_plugin
          fire_after_configuration_hook
          # TODO: can we remove this state?
          self.visitor = report
    
          receiver = Test::Runner.new(@configuration.event_bus)

          adapter.record_worker
          if ENV["DETEST_RERUN"] == "true"
              while f_file = adapter.fpop
                fs = process_feature_file(f_file)
                compile fs, receiver, filters
              end
            else
              while f_file = adapter.pop
                fs = process_feature_file(f_file)
                compile fs, receiver, filters
              end
          end
          @configuration.notify :test_run_finished
          adapter.end_worker
        end

        def process_feature_file(file)
          f_filespecs = ::Cucumber::FileSpecs.new([file])
          f_files = f_filespecs.files
          f_files.map do |path|
            source = NormalisedEncodingFile.read(path)
            @configuration.notify :gherkin_source_read, path, source
            ::Cucumber::Core::Gherkin::Document.new(path, source)
          end
        end
      end
    end
  end
end