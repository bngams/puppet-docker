$ret = try() || {
  assert_type('String', 1)
  'return value from try'
}.catch |$exception| {
  'return value from catch'
}
notice($ret)
