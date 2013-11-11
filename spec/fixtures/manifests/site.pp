node 'sample.org' {
  class {'mongodb::params':
    dbdir => '/data'
  }

  include ::mongodb

  mongodb::mongod {
    "sample":
      mongod_instance => "sample",
      mongod_add_options => ['fastsync'],
  }

}
