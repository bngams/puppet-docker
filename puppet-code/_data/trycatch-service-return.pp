$ret = service { 'mysqld':
  ensure   => 'running',
  enable   => 'true',
}
notice($ret)

notify {'debug':
  message => $ret,
#  require => Service['mysqld']
}
