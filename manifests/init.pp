# == Class: mongodb
#
class mongodb inherits mongodb::params {

    anchor{ 'mongodb::begin':
        before => Anchor['mongodb::install::begin'],
    }

    anchor { 'mongodb::end':
        require => Anchor['mongodb::install::end'],
    }

    case $::osfamily {
        /(?i)(Debian|RedHat)/: {
            class { 'mongodb::install': }
        }
        default: {
            fail "Unsupported OS ${::operatingsystem} in 'mongodb' module"
        }
    }


    mongodb::limits::conf {
        'mongod-soft':
          type  => soft,
          item  => nofile,
          value => $mongodb::params::ulimit_nofiles;
        'mongod-hard':
          type  => hard,
          item  => nofile,
          value => $mongodb::params::ulimit_nofiles;
    }

}

