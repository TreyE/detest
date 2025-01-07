cucumber_version = Gem::Version.new(Cucumber::VERSION)
cucumber_4_x_version = Gem::Version.new("4.0.0")
if cucumber_version < cucumber_4_x_version
  require_relative "cucumber_3_x/cli"
  require_relative "cucumber_3_x/runtime"
else
  require_relative "cucumber/cli"
  require_relative "cucumber/runtime"
end

module Detest
  module Publishers
    module Cucumber
    end
  end
end