class remote_syslog2::service inherits remote_syslog2 {
  contain remote_syslog2::configure

  if ! ($service_ensure in [ 'running', 'stopped' ]) {
    fail('service_ensure parameter must be running or stopped')
  }

  file { $service_file:
    ensure  => file,
    mode    => 0664,
    content => template($service_template)
  }

  service { 'remote_syslog2':
    ensure     => $service_ensure,
  }
}
