notify { 'is group':
  message => $facts['groups']
}


if $facts['groups'] == 'webserver' {
  notify { 'webserver':
    message => $facts['groups']
  }
}

