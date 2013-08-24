node default {
  include apt
  include stdlib
  include roles::infrastructure

  $run_as_user = "vagrant"
  $ruby_version = "2.0.0-p247"
  $ruby_home_path = "/home/${run_as_user}/.rbenv/versions/${ruby_version}"
  $base_app_home = "/home/${run_as_user}/apps"


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

  class { 'roles::database': } ->

  class { 'roles::www::webserver':
    run_as_user  => $run_as_user,
    ruby_version => '2.0.0-p247',
    rails_env    => 'development',
  } ->

  puma::app { 'mytechbooks':
    app_path         => "${base_app_home}/mytechbooks",
    run_as_user      => $run_as_user,
    ensure           => "present",
    ruby_home_path   => $run_home_path,
    rails_env        => "development",
  }


}
