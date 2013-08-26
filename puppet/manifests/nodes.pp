node default {
  include apt
  include stdlib
  include roles::infrastructure

  $run_as_user    = "vagrant"
  $ruby_version   = "2.0.0-p247"
  $ruby_home_path = "/home/${run_as_user}/.rbenv/shims"
  $base_app_home  = "/home/${run_as_user}/apps"

  $application_name  = 'mytechbooks'

  $database_name     = 'mytechbooks_development'
  $database_username = 'mytechbooks'
  $database_password = 'letmein123'

  file { "${home_dir}/.bash_aliases":
    ensure => present,
  } ->

  line { 'create aliases':
    file    => "${home_dir}/.bash_aliases",
    line    => 'alias be="bundle exec"',
    ensure  => present,
  }

  package { ['git', 'wget', 'curl', 'vim', 'nfs-common']:
    ensure => installed,
  }

  class { 'roles::setup': } ->

  class { 'java': } ->

  class { 'roles::database':
    db_name  => $database_name,
    owner    => $database_username,
    password => $database_password,
  } ->

  class { 'roles::www::webserver':
    run_as_user  => $run_as_user,
    ruby_version => $ruby_version,
    rails_env    => 'development',
  } ->

  puma::app { $application_name:
    app_path       => "${base_app_home}/${application_name}",
    run_as_user    => $run_as_user,
    ensure         => "present",
    port           => 9292,
    ruby_home_path => $ruby_home_path,
    rails_env      => "development",
  }


}
