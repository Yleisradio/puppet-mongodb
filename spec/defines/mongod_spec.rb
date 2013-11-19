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
        :mode => "0644"
      )
  end

  it do
    should contain_file("/etc/init/mongod_instance_name.conf")
      .with(
        :mode => "0644"
      )
  end

  it do
    should contain_file("/opt/mongodb/instance_name/log")
      .with(
        :mode => "0755",
        :owner => "mongodb",
        :group => "mongodb"
      )
  end


  it do
    should contain_mongodb__logrotate("mongod_instance_name_logrotate")
      .with(
        :instance => "instance_name",
        :logdir   => "/opt/mongodb/instance_name/log"
      )
  end

  it do
    should contain_service("mongod_instance_name")
      .with(
        :hasstatus  => true,
        :hasrestart => true
      )
  end
end