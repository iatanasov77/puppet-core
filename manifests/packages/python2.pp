class vs_core::packages::python2
{
    if Integer( $facts['os']['release']['major'] ) > 8 {
        wget::fetch { "Download Python2 Installer":
            source      => "https://github.com/niess/python-appimage/releases/download/python2.7/python2.7.18-cp27-cp27m-manylinux1_x86_64.AppImage",
            destination => '/tmp/python2.7.18-cp27-cp27m-manylinux1_x86_64.AppImage',
            verbose     => true,
            mode        => '0755',
            cache_dir   => '/var/cache/wget',
        } ->
        Exec { "Install Python2":
            command => '/usr/bin/install -m 755 /tmp/python2.7.18-cp27-cp27m-manylinux1_x86_64.AppImage /usr/local/bin/',
        } ->
        file { '/usr/local/bin/python2':
            ensure  => link,
            target  => "/usr/local/bin/python2.7.18-cp27-cp27m-manylinux1_x86_64.AppImage",
        }
    } else {
        if ! defined(Package['python2']) {
            package { 'python2':
                ensure => present,
            }
        }
    }
}