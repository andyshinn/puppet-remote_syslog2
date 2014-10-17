class remote_syslog2::configure inherits remote_syslog2 {
  contain remote_syslog2::install

  file { $config_file:
    ensure  => file,
    mode    => 0664,
    content => template($config_template)
  }
}
