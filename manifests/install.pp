class remote_syslog2::install inherits remote_syslog2 {
  include wget

  Exec {
    path => '/usr/bin:/bin:/usr/sbin:/sbin'
  }

  $downcase_kernel = downcase($kernel)
  $url = "https://github.com/papertrail/remote_syslog2/releases/download/${version}/remote_syslog_${downcase_kernel}_${architecture}.tar.gz"
  $temp_file_name = 'remote_syslog2.tar.gz'
  $temp_file = "${temp_dir}/${temp_file_name}"

  wget::fetch { $url:
    destination => $temp_file,
  }

  exec { 'unzip_remote_syslog2':
    command     => "tar -zxf ${temp_file}",
    cwd         => $install_dir,
    creates     => "$install_dir/remote_syslog",
    subscribe   => Wget::Fetch[$url],
    refreshonly => true,
  }
}
