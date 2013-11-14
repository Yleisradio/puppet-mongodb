# Define: mongodb::replication::script
# Parameters:
# arguments
#
define mongodb::replication::script (
  $replica_set_name = '',
  $replica_set_hosts = [],
) {


  file {
    "${::mongodb::params::homedir}/commands":
      ensure  => 'directory',
      owner   => $mongodb::params::run_as_user,
      group   => $mongodb::params::run_as_group,
      mode    => '0755',
      require => Anchor['mongodb::install::end'];

    "${::mongodb::params::homedir}/commands/init-replication-${replica_set_name}.sh":
      owner   => $mongodb::params::run_as_user,
      group   => $mongodb::params::run_as_group,
      mode    => '0755',
      require => File["${::mongodb::params::homedir}/commands"],
      content => template('mongodb/init-replication.sh.erb');
  }

}