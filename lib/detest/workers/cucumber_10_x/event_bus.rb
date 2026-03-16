require "cucumber/events"

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
            ::Cucumber::Events::GherkinSourceParsed,
            ::Cucumber::Events::GherkinSourceRead,
            ::Cucumber::Events::HookTestStepCreated,
            ::Cucumber::Events::StepActivated,
            ::Cucumber::Events::StepDefinitionRegistered,
            ::Cucumber::Events::TestCaseCreated,
            ::Cucumber::Events::TestCaseFinished,
            ::Cucumber::Events::TestCaseStarted,
            ::Cucumber::Events::TestCaseReady,
            ::Cucumber::Events::TestRunFinished,
            ::Cucumber::Events::TestRunStarted,
            ::Cucumber::Events::TestStepCreated,
            ::Cucumber::Events::TestStepFinished,
            ::Cucumber::Events::TestStepStarted,
            ::Cucumber::Events::Envelope,
            ::Cucumber::Events::UndefinedParameterType,
            TestFileStarted,
            TestFileFinished
          )
        end
      end
    end
  end
end