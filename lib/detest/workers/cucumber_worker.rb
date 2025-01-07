require_relative "cucumber"

module Detest
  module Workers
    class CucumberWorker
      def self.run!(adapter, args)
        cli = Detest::Workers::Cucumber::Cli.new(args)
        cli.execute!(adapter)
      end
    end
  end
end