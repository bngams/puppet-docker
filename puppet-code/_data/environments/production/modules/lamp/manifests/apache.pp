class lamp::apache {

  $ret = package { 'apache':
    name    => $lamp::params::apachename,
    ensure  => present,
  }

  notify { 'return':
    message => $ret
  }

}
