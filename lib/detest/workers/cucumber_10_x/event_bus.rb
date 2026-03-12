module Detest
  module Workers
    module Cucumber
      module EventBus
        class TestFileStarted < ::Cucumber::Core::Event.new(:path)
          attr_reader :path
        end

        class TestFileFinished < ::Cucumber::Core::Event.new(:path)
          attr_reader :path
        end

        def self.make_event_bus
          ::Cucumber::Core::EventBus.new(registry)
        end
    
        def self.registry
        ::Cucumber::Core::Events.build_registry(
          ::Cucumber::Core::Events::TestCaseStarted,
          ::Cucumber::Core::Events::TestCaseFinished,
          ::Cucumber::Core::Events::TestStepFinished,
          ::Cucumber::Events::TestStepStarted,
          ::Cucumber::Events::StepDefinitionRegistered,
          ::Cucumber::Events::StepActivated,
          ::Cucumber::Events::TestRunFinished,
          ::Cucumber::Events::GherkinSourceRead,
          ::Cucumber::Events::TestRunStarted,
          TestFileStarted,
          TestFileFinished
          )
        end
      end
    end
  end
end