require_relative "workers/rspec_worker" if Detest::FrameworkSupport.rspec_available?
require_relative "workers/cucumber_worker" if Detest::FrameworkSupport.cucumber_available?

module Detest
  module Workers
  end
end
