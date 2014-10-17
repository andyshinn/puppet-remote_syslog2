# == Class: remote_syslog2
#
# Full description of class remote_syslog2 here.
#
# === Parameters
#
# [*destination_port*]
#   The port of your log destination at Papertrail. This is a required parameter.
#
# [*destination_protocol*]
#   The destination protocol to conncet with. Either tls, udp, or tcp. Defaults to tls.
#
# [*destination_host*]
#   The host of your log destination at Papertrail. Usually logs.papertrailapp.com
#   or logs2.papertrailapp.com. Defaults to logs.papertrailapp.com.
#
# [*exclude_files*]
#   An array of files to exclude from sending. Defaults to empty array.
#
# === Examples
#
#  class { remote_syslog2:
#    destination_port => 55555,
#    files            => ['/var/log/syslog', '/home/**/logs/*.log'],
#  }
#
class remote_syslog2 (
  $destination_port,
  $destination_protocol    = 'tls',
  $destination_host        = 'logs.papertrailapp.com',
  $exclude_files           = [],
  $exclude_patterns        = [],
  $files                   = [],
  $hostname                = undef,
  $install_dir             = '/usr/local/bin',
  $log_files               = '/etc/log_files.yml',
  $new_file_check_interval = 10,
  $temp_dir                = '/tmp',
  $version                 = 'v0.13',
  $service_ensure          = 'running',
) {

  validate_absolute_path($temp_dir)
  validate_absolute_path($install_dir)
  validate_re($new_file_check_interval, '[0-9]+')
  validate_string($version)
  validate_string($hostname)
  validate_string($service_ensure)

  $config_file     = '/etc/log_files.yml'
  $config_template = 'remote_syslog2/log_files.yml.erb'
  $service_file     = '/etc/init/remote_syslog2.conf'
  $service_template = 'remote_syslog2/remote_syslog2.upstart.conf.erb'

  if empty($files) {
    fail('files must be an array with at least one element')
  }

  include remote_syslog2::install
  include remote_syslog2::configure
  include remote_syslog2::service
}
