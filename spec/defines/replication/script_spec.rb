require "spec_helper"

describe "mongodb::replication::script", :type => :define do
  let(:title) { "instance_name" }

  let(:params) do
    {
      :replica_set_name => "replica_set_name",
      :replica_set_hosts => ["192.168.10.11", "192.168.10.12", "192.168.10.13"],
    }
  end

  it do
    should contain_file("/opt/mongodb/commands")
      .with(
        :ensure => "directory",
        :owner => "mongodb",
        :group => "mongodb",
        :mode => "0755"
      )
  end

end
