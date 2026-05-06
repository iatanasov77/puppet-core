class vs_core::telsocket (
    String $version,
) {
    $telsocketSource  = "https://github.com/lafikl/telsocket/releases/download/v${version}/${version}_linux_amd64.tar.gz"
    
    archive { "/tmp/telsocket.tar.gz":
        ensure          => present,
        source          => $telsocketSource,
        extract         => true,
        extract_path    => '/tmp',
        cleanup         => true,
    }
    -> file { '/usr/local/bin/telsocket':
        ensure  => 'present',
        owner   => 'root',
        group   => 'root',
        mode    => '0777',
        source  => "/tmp/lafikl_${version}_linux_amd64/lafikl",
    }
}
