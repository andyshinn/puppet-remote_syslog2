# remote_syslog2

Puppet module to install and manage [remote_syslog2][remote_syslog2].

## Usage

This module comes with two main classes, the main `remote_syslog2` class, and the `remote_syslog2::file` definition.

Include the `remote_syslog2` class in your manifest to install the utility. The Papertrail host and port should be overridden by Hiera in this case:

```puppet
include remote_syslog2
```

Here is an example declaring the class with the full list of available parameters and their defaults. Port is the only required parameter:

```puppet
class { 'remote_syslog2':
  destination_port        => undef
  destination_protocol    => 'tls'
  destination_host        => 'logs.papertrailapp.com',
  exclude_files           => [],
  exclude_patterns        => [],
  files                   => [],
  hostname                => undef,
  install_dir             => '/usr/local/bin',
  log_files               => '/etc/log_files.yml',
  new_file_check_interval => 10,
  temp_dir                => '/tmp',
  version                 => 'v0.13'

}
```

You need to set at least `files` and `destination_port`. An example with multiple logs might look like:

```puppet
$files = ['/var/log/syslog', '/home/**/logs/*.log']

class { 'remote_syslog2':
  destination_port => 55555,
  files            => $files,
}
```

[remote_syslog2]: https://github.com/papertrail/remote_syslog2
