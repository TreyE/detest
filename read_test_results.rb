require 'redis'
require "json"

workflow_run_id = "12468990776"
DETEST_SERVER_HOST = ""
DETEST_SERVER_PASSWORD = ""

@redis = Redis.new(host: DETEST_SERVER_HOST, password: DETEST_SERVER_PASSWORD)

members = @redis.smembers("__rspec_#{workflow_run_id}_tp_adapter_test_results_storage")
member_total = members.count
members_written = 0

File.open("rspec_results.json", "wb") do |f|
  f.write("[\n")
  members.each do |member|
    f.write member
    members_written = members_written + 1
    if members_written < member_total
      f.write ",\n"
    else
      f.write "\n"
    end
  end
  f.write("]")
end

data_str = File.read("rspec_results.json")
data = JSON.parse(data_str)

sorted_data = data.sort_by do |item|
  item["duration"]
end

puts sorted_data[-10..-1].inspect
