require "spec_helper"

describe Detest::Workers::Cucumber::Cli do
  it "can be initialized" do
    described_class.new([])
  end
end