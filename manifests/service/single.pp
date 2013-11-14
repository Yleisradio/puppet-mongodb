# Class: mongodb::service::single
#

class mongodb::service::single($instance_name, $replica_set_name) {
  include ::mongodb

  # http://docs.mongodb.org/master/reference/configuration-options/
  mongodb::mongod {
    $instance_name:
      mongod_instance    => $instance_name,
      mongod_replSet     => $replica_set_name,
      mongod_port        => 27017,
      mongod_add_options => [],
      mongod_monit       => false,
  }
}