$ret = try() || {
  service { 'mysqld':
    ensure   => 'running',
    enable   => 'true',
  }
  notice('This code is never reached')
  'return value from try'
}.catch |$exception| {
  notice($exception['class'])
  notice($exception['message'])
  'return value from catch'
}
notice($ret)

notify {'debug': 
  message => 'test after',
  require => Service['mysqld']
}
