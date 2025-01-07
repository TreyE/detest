require_relative "cucumber"

module Detest
  module Publishers
    class CucumberPublisher
      def self.run!(adapter, args)
        cli = Detest::Publishers::Cucumber::Cli.new(args)
        cli.execute!(adapter)
      end
    end
  end
end