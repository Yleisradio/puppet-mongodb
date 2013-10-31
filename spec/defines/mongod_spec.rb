require "spec_helper"

describe "mongodb::mongod", :type => :define do
  let(:title) { "instance_name" }

  let(:params) do
    {
      :name => "instance_name",
      :mongod_add_options => [],
    }
  end

  it { should contain_file("/etc/mongod_instance_name.conf") }
  it { should contain_service("mongod_instance_name") }
end