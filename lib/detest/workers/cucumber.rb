cucumber_version = Gem::Version.new(Cucumber::VERSION)
cucumber_4_x_version = Gem::Version.new("4.0.0")
cucumber_10_version = Gem::Version.new("10.0.0")
cucumber_11_version = Gem::Version.new("11.0.0")
if cucumber_version < cucumber_4_x_version
  require_relative "cucumber_3_x/cli"
  require_relative "cucumber_3_x/runtime"
  require_relative "cucumber_3_x/event_bus"
elsif cucumber_version >= cucumber_10_version && cucumber_version < cucumber_11_version
  require_relative "cucumber_10_x/cli"
  require_relative "cucumber_10_x/runtime"
  require_relative "cucumber_10_x/event_bus"
else
  require_relative "cucumber_unsupported/cli"
end

module Detest
  module Workers
    module Cucumber
    end
  end
end