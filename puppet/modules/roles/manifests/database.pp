class roles::database {

  package { ['mysql-server', 'libmysqlclient-dev']:
    ensure => absent,
  } # ->

  # service { 'mysql':
    # enable => true,
    # ensure => running,
  # }
}
