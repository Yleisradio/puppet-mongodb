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

  it do
    should contain_file("/opt/mongodb/commands/init-replication-replica_set_name.sh")
      .with(
        :owner => "mongodb",
        :group => "mongodb",
        :mode => "0755"
      )
         .with_content("#!/bin/sh\n\nmongo localhost/replica_set_name --eval \"hosts = ['192.168.10.11','192.168.10.12','192.168.10.13'];\n\nfor (members = [], i = 0; i < hosts.length; i++) {\n  members[i] = {_id: i, host: hosts[i]};\n}\n\nconfig = {\n  _id: 'replica_set_name',\n  members: members\n};\n\nresult = rs.initiate(config);\nprintjson(result); \"\n\nmongo localhost/replica_set_name --eval \"printjson(rs.status());\"\n\n")
  end
end
