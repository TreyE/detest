require "cucumber/cli/main"

module Detest
  module Workers
    module Cucumber
      class Cli
        def initialize(*args)
          raise NotImplementedError, "this version of cucumber is not supported: #{::Cucumber::VERSION}"
        end
      end
    end
  end
end