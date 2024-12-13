require "spec_helper"

describe Detest::Adapters::RedisAdapter, "when a runner is recorded" do
  let(:session_key) { "TESTING SESSION KEY"}

  subject { described_class.new(session_key) }

  let(:redis) { subject.redis }

  it "adds to the number of runners" do
    rc_1 = nil
    rc_2 = nil
    redis.multi do |pipeline|
      rc_1 = pipeline.get(subject.redis_session_runner_key)
      subject.record_worker(pipeline)
      rc_2 = pipeline.get(subject.redis_session_runner_key)
    end
    expect(rc_2.value.to_i).to eql((rc_1.value || "0").to_i + 1)
  end
end