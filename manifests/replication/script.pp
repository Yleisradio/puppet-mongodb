# Define: mongodb::replication::script
# Parameters:
# arguments
#
define mongodb::replication::script (
  $replica_set_name = '',
  $replica_set_hosts = [],
) {

  include mongodb::params

  File {
    owner   => $mongodb::params::run_as_user,
    group   => $mongodb::params::run_as_group,
    mode    => '0755',
  }

  file {
    "${::mongodb::params::homedir}/commands":
      ensure  => 'directory',
      require => Anchor['mongodb::install::end'];

    "${::mongodb::params::homedir}/commands/init-replication-${replica_set_name}.sh":
      require => File["${::mongodb::params::homedir}/commands"],
      content => template('mongodb/init-replication.sh.erb');
  }

}