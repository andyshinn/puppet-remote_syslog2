class { 'remote_syslog2':
  destination_port => 55555,
  files            => ['/var/log/syslog'],
}
