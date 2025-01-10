require "spec_helper"

describe Detest::Workers::Cucumber::Cli do
  it "is not supported" do
    expect { described_class.new([]) }.to raise_exception(NotImplementedError)
  end
end