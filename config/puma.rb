pidfile "/tmp/puma/home_vagrant_apps_mytechbooks.pid"
state_path "/tmp/puma/home_vagrant_apps_mytechbooks.state"
bind 'tcp://127.0.0.1:9292'
activate_control_app

threads 3, 10
