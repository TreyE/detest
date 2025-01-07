module Detest
  class FrameworkSupport
    @@rspec_support = false
    @@cucumber_support = false

    def self.initialize!
      begin
        require "rspec/core"
        @@rspec_support = true
      rescue LoadError
      end
      begin
        require "cucumber"
        @@cucumber_support = true
      rescue LoadError
      end
    end

    def self.rspec_available?
      @@rspec_support
    end

    def self.cucumber_available?
      @@cucumber_support
    end
  end
end

Detest::FrameworkSupport.initialize!