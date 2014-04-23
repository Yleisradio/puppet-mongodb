# == Class: mongodb::params
#
class mongodb::params {

    $repo_class = $::osfamily ? {
        redhat => 'mongodb::repos::yum',
        debian => 'mongodb::repos::apt',
    }

    $server_pkg_name = $::osfamily ? {
        debian  => ['mongodb-org-server','mongodb-org-shell','mongodb-org-tools'],
        redhat  => ['mongodb-org-server','mongodb-org-shell','mongodb-org-tools'],
    }

    $old_server_pkg_name = $::osfamily ? {
        debian  => 'mongodb-10gen',
        redhat  => 'mongodb-server',
    }

    $old_servicename = $::osfamily ? {
        debian  => 'mongodb',
        redhat  => 'mongod',
    }

    $run_as_user = $::osfamily ? {
        debian  => 'mongod',
        redhat  => 'mongod',
    }

    $run_as_group = $::osfamily ? {
        debian  => 'mongodb',
        redhat  => 'mongod',
    }

    # directorypath to store db directory in
    # subdirectories for each mongo instance will be created

    $dbdir = '/opt/mongodb'

    # numbers of files (days) to keep by logrotate

    $logrotatenumber = 7

    # package version / installed / absent

    $package_ensure = 'installed'

    # should this module manage the mongodb repository from upstream?

    $repo_manage = true

    # should this module manage the logrotate package?

    $logrotate_package_manage = true

    # directory for mongo logfiles

    $logdir = $::osfamily ? {
        debian  => '/var/log/mongodb',
        redhat  => '/var/log/mongo',
    }

    # specify ulimit - nofile = 64000 and nproc = 32000 is recommended setting from
    # http://docs.mongodb.org/manual/reference/ulimit/#recommended-settings

    $ulimit_nofiles = 64000
    $ulimit_nproc   = 32000

    # specify pidfilepath

    $pidfilepath = $dbdir
}
