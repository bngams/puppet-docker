# include lamp

class { 'lamp':
  params_overrides => {
    'db_root_password' => 'new_password',
  },
}

node 'agent1.internal' {
  service { 'apache2':
     ensure => 'running',
     provider => 'debian'
  }
}

