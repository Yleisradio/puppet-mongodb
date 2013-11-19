require "spec_helper"

describe "mongodb::mongod", :type => :define do
  let(:title) { "instance_name" }

  let(:params) do
    {
      :name => "instance_name",
      :mongod_add_options => [],
    }
  end

  it do
    should contain_file("/etc/mongod_instance_name.conf")
      .with(
        :mode => '0644'
      )
  end

  it do
    should contain_file("/etc/init/mongod_instance_name.conf")
      .with(
        :mode => '0644'
      )
  end

  it { should contain_mongodb__logrotate("mongod_instance_name_logrotate") }
  it { should contain_service("mongod_instance_name") }
end