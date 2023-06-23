$ret = try() || {
  assert_type('String', 1)
  notice('This code is never reached')
  'return value from try'
}.catch |$exception| {
  notice($exception['class'])
  notice($exception['message'])
  'return value from catch'
}
notice($ret)
