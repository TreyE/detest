require "cucumber/cli/main"

module Detest
  module Workers
    module Cucumber
      class Cli < ::Cucumber::Cli::Main

        def execute!(adapter, existing_runtime = nil)
          trap_interrupt
  
          runtime = if existing_runtime
                      existing_runtime.configure(configuration)
                      existing_runtime
                    else
                      ::Detest::Workers::Cucumber::Runtime.new(configuration)
                    end
  
          runtime.run!(adapter)
          if ::Cucumber.wants_to_quit
            exit_unable_to_finish
          else
            if runtime.failure?
              exit_tests_failed
            else
              exit_ok
            end
          end
        rescue SystemExit => e
          @kernel.exit(e.status)
        rescue ::Cucumber::FileNotFoundException => e
          @err.puts(e.message)
          @err.puts("Couldn't open #{e.path}")
          exit_unable_to_finish
        rescue ::Cucumber::FeatureFolderNotFoundException => e
          @err.puts(e.message + '. You can use `cucumber --init` to get started.')
          exit_unable_to_finish
        rescue ::Cucumber::Cli::ProfilesNotDefinedError, ::Cucumber::Cli::YmlLoadError, ::Cucumber::Cli::ProfileNotFound => e
          @err.puts(e.message)
          exit_unable_to_finish
        rescue Errno::EACCES, Errno::ENOENT => e
          @err.puts("#{e.message} (#{e.class})")
          exit_unable_to_finish
        rescue Exception => e
          @err.puts("#{e.message} (#{e.class})")
          @err.puts(e.backtrace.join("\n"))
          exit_unable_to_finish
        end
      end
    end
  end
end