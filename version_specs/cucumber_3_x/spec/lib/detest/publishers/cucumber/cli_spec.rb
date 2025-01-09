require "spec_helper"

describe Detest::Publishers::Cucumber::Cli do
  it "can be initialized" do
    described_class.new([])
  end
end