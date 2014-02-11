require "spec_helper"

describe "mongodb::service::backup", :type => :class do
  describe "without database name" do
    let(:title) { "instance_name" }

    let(:params) do
      {
        :instance_name           => "instance_name",
        :replica_set_name        => "replica_set_name",
        :replica_set_hosts       => ["192.168.10.11", "192.168.10.12", "192.168.10.13"],
        :replica_set_backuphosts => ["192.168.10.14"],
        :backup_dir              => "/mongodb_backup/backup",
      }
    end

    it do
      should contain_mongodb__mongod("instance_name")
        .with(
          :mongod_instance    => "instance_name",
          :mongod_port        => 27017,
          :mongod_add_options => "diaglog=1",
          :mongod_monit       => false,
          :mongod_fork        => false
        )
    end

    it do
      should contain_mongodb__backup__job("automongobackup")
        .with(
          :replica_set_hosts => ["192.168.10.11", "192.168.10.12", "192.168.10.13"],
          :replica_set_backuphosts => "192.168.10.14",
          :replica_set_name  => "replica_set_name",
          :backupdir => "/mongodb_backup/backup",
          :database_name => "replica_set_name"
        )
    end

  end

  describe "with database name" do
    let(:title) { "instance_name" }

    let(:params) do
      {
        :instance_name           => "instance_name",
        :replica_set_name        => "replica_set_name",
        :replica_set_hosts       => ["192.168.10.11", "192.168.10.12", "192.168.10.13"],
        :replica_set_backuphosts => ["192.168.10.14"],
        :backup_dir              => "/mongodb_backup/backup",
        :database_name           => "database_name"
      }
    end

    it do
      should contain_mongodb__mongod("instance_name")
        .with(
          :mongod_instance    => "instance_name",
          :mongod_port        => 27017,
          :mongod_add_options => "diaglog=1",
          :mongod_monit       => false,
          :mongod_fork        => false
        )
    end

    it do
      should contain_mongodb__backup__job("automongobackup")
        .with(
          :replica_set_hosts => ["192.168.10.11", "192.168.10.12", "192.168.10.13"],
          :replica_set_backuphosts => "192.168.10.14",
          :replica_set_name  => "replica_set_name",
          :backupdir => "/mongodb_backup/backup",
          :database_name => "database_name"
        )
    end
  end
end
