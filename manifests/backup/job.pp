# Define: mongodb::backup::job
#
#
define mongodb::backup::job (
  $replica_set_name = '',
  $replica_set_hosts = [],
  $replica_set_backuphosts = [],
  $backupdir = "",
  $database_name = "",
) {

  file {
    "${::mongodb::params::homedir}/backup":
      ensure  => 'directory',
      owner   => $mongodb::params::run_as_user,
      group   => $mongodb::params::run_as_group,
      mode    => '0755',
      require => Anchor['mongodb::install::end'];

    "${::mongodb::params::homedir}/backup/run-${replica_set_name}-backup.sh":
      owner   => $mongodb::params::run_as_user,
      group   => $mongodb::params::run_as_group,
      mode    => '0755',
      require => File["${::mongodb::params::homedir}/backup"],
      content => template('mongodb/automongobackup.sh.erb');
  }

  file {
    "${backupdir}":
      ensure  => 'directory',
      owner   => $mongodb::params::run_as_user,
      group   => $mongodb::params::run_as_group,
      mode    => '0755',
      require => Anchor['mongodb::install::end'];
  }

  cron { "${replica_set_name}-backup":
    ensure  => 'present',
    user    => $mongodb::params::run_as_user,
    command => "${::mongodb::params::homedir}/backup/run-${replica_set_name}-backup.sh",
    hour    => [ 6, 12, 18, 0 ],
    minute  => '00',
  }


}