# == Class: mongodb::install
#
#
class mongodb::install {

    anchor { 'mongodb::install::begin': }
    anchor { 'mongodb::install::end': }

    package { 'mongodb-stable':
        ensure  => absent,
        name    => $::mongodb::params::old_server_pkg_name,
        require => Anchor['mongodb::install::begin'],
        before  => Anchor['mongodb::install::end']
    }

    package { 'curl':
        name    => 'curl',
        ensure  => present,
        require => Anchor['mongodb::install::begin']
    }

    user{ "${mongodb::params::run_as_user}":
        comment  => "MongoDB user",
        ensure   => present,
        require  => Anchor['mongodb::install::begin']
    }
    group { "${mongodb::params::run_as_group}":
        ensure   => present,
        require  => Anchor['mongodb::install::begin']
    }
    file { "$mongodb::params::logdir":
        ensure   => directory,
        mode     => '0755',
        owner    => $mongodb::params::run_as_user,
        group    => $mongodb::params::run_as_group,
        require  => [User[$mongodb::params::run_as_user], Group[$mongodb::params::run_as_user]]
    }
    file { "$mongodb::params::dbdir":
        ensure   => directory,
        mode     => '0755',             # TODO: more restricted permissons
        owner    => $mongodb::params::run_as_user,
        group    => $mongodb::params::run_as_group,
        require  => [User[$mongodb::params::run_as_user], Group[$mongodb::params::run_as_user]]
    }

    $installConf = {
        user     => $mongodb::params::run_as_user,
        group    => $mongodb::params::run_as_group,
        version  => $mongodb::params::version,
        home     => $mongodb::params::installdir
    }
    file { '/tmp/install-mongo.sh':
        mode     => '0755',
        content  => template('mongodb/install-mongo.sh.erb')
    }
    exec { 'install-mongo':
        command  => "/tmp/install-mongo.sh",
        path     => ["/bin", "/usr/bin"],
        require  => [Package['curl'], File['/tmp/install-mongo.sh', $mongodb::params::logdir, $mongodb::params::dbdir]],
        before   => Anchor['mongodb::install::end']
    }

}
