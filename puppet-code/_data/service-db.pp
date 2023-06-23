service { 'mysqld':
  ensure   => 'running',
  # name     => 'mysql',
  enable   => 'true',
  # provider => 'debian',
}

