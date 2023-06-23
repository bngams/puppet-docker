# groups

$hiera_groups = lookup('hiera_groups')

notify { 'is group hiera':
  message => $hiera_groups
}


if $hiera_groups == 'webserver' {
  notify { 'webserver hiera':
    message => $groups
  }

  notify { 'require other manifest':
    message => 'required ok',
    require => Class['Lamp::Apache']
  }

  # databases

  # WIP - Syntax issue
  # Class['Lamp::Db']->create_resources(mysql::db, lookup('db::app1'))
  
  # Load var
  $databases = lookup('databases');

  # simple loop with notify
  # double quotes are important to use template vars / interpolation, use double quotes instead 'db loop over ${dbname}'
  # |$dbname, $dbdata|  like |$index, $value|
  $databases.each |$dbname, $dbdata| { notify{"db loop over ${dbname}": message => $dbdata['user']} }
  
  # Loop to create databases
  # Class['Lamp::Db']->$databases.each |$dbname, $dbdata| {
  #   mysql::db { $dbname:
  #     user     => $dbdata['user'],
  #     password => $dbdata['password'],
  #   }
  # }
  
}
