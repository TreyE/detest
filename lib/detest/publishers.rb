require_relative "publishers/rspec_publisher" if Detest::FrameworkSupport.rspec_available?
require_relative "publishers/cucumber_publisher" if Detest::FrameworkSupport.cucumber_available?

module Detest
  module Publishers
  end
end
