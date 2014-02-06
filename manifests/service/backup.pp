# Class: mongodb::service::backup
#
#
class mongodb::service::backup ($instance_name, $replica_set_name, $replica_set_hosts,$replica_set_backuphosts,$backup_dir = "/opt/mongo_backups") {
  include ::mongodb

  # http://docs.mongodb.org/master/reference/configuration-options/
  mongodb::mongod {
    $instance_name:
      mongod_instance    => $instance_name,
      mongod_replSet     => $replica_set_name,
      mongod_port        => 27017,
      mongod_add_options => ["diaglog=1"],
      mongod_monit       => false,
      mongod_fork       => false,
  }

  mongodb::replication::backup-init-script { 'init-replica-set-with-backup':
      replica_set_hosts => $replica_set_hosts,
      replica_set_backuphosts => $replica_set_backuphosts,
      replica_set_name  => $replica_set_name,

  }

  mongodb::backup::job { 'automongobackup':
      replica_set_hosts => $replica_set_hosts,
      replica_set_backuphosts => $replica_set_backuphosts,
      replica_set_name  => $replica_set_name,
      backupdir => $backup_dir,
  }

}