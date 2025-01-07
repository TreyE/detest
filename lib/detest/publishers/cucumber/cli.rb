require "cucumber/cli/main"

module Detest
  module Publishers
    module Cucumber
      class Cli < ::Cucumber::Cli::Main
        def runtime(existing_runtime)
          return ::Detest::Publishers::Cucumber::Runtime.new(configuration) unless existing_runtime
  
          existing_runtime.configure(configuration)
          existing_runtime
        end
      end
    end
  end
end