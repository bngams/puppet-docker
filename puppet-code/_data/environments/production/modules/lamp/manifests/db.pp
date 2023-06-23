class lamp::db {

  # default install
  # include mysql::server

  # custom install
  class { 'mysql::server':
    package_name => 'mariadb-server',
    root_password           => 'strongpassword',
    remove_default_accounts => true,
    restart                 => true,
    service_provider => 'debian',
    # service_name     => 'mysql',
    # override_options        => $override_options,
  }

  # ensure root password in .my.cnf set
  # file { '/root/.my.cnf':
  #   content => epp('lamp/my.cnf.epp', { 'db_root_password' => $lamp::params::db_root_password } )
  # }

  # setup dependencies
  # File['/root/.my.cnf']
  #   -> ::Mysql::Db['mydb']
  #   -> Exec['rm my.cnf']

  # create a db
  mysql::db { 'mydb':
    user     => 'myuser',
    password => 'mypass',
    host     => 'localhost',
    grant    => ['SELECT', 'UPDATE'],
  }

  # remove .my.cnf after database setup:
  # exec { 'rm my.cnf':
  #   command => '/bin/rm /root/.my.cnf'
  # }

}
