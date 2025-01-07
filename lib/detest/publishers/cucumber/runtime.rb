require "cucumber/runtime"
require "cucumber/messages"
require 'cucumber/runtime/meta_message_builder'

module Detest
  module Publishers
    module Cucumber
      class Runtime < ::Cucumber::Runtime
        def run!
          @configuration.notify :envelope, ::Cucumber::Messages::Envelope.new(
            meta: ::Cucumber::Runtime::MetaMessageBuilder.build_meta_message
          )
    
          load_step_definitions
          fire_install_plugin_hook
          fire_before_all_hook unless dry_run?
          # TODO: can we remove this state?
          self.visitor = report
    
          # receiver = Cucumber::Test::Runner.new(@configuration.event_bus)
          receiver = nil
          compile features, receiver, filters, @configuration.event_bus
          @configuration.notify :test_run_finished, !failure?
    
          fire_after_all_hook unless dry_run?
        end
      end
    end
  end
end