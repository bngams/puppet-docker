# class lamp::params (
#   $db_root_password = 'root',
# ) {}

class lamp::params {
  # in hieara common.yaml?
  $db_root_password = 'root'

  # in hiera %{::facts.osfamily}%.yaml? 
  $apachename = $osfamily ? {
    'RedHat' => 'httpd',
    'Debian' => 'apache2',
    default  => fail("This is not a supported distro."),
  }
}
