class vs_core::packages::curl
{
    /*
    wget::fetch { "Install Latest Version of CURL.":
        source      => "https://github.com/moparisthebest/static-curl/releases/download/v7.83.1/curl-amd64",
        destination => '/usr/bin/curl',
        verbose     => true,
        mode        => '0777',
        cache_dir   => '/var/cache/wget',
    }
    */
    
    exec { 'download latest curl':
        command => '/usr/bin/wget -P /tmp https://github.com/moparisthebest/static-curl/releases/download/v7.83.1/curl-amd64',
        creates => '/tmp/curl',
    }
    
    file { '/usr/bin/curl':
        source  => '/tmp/curl-amd64',
        mode    => 'a+x',
        require => Exec['download latest curl'],
    }
    
    file { '/etc/ssl/certs/ca-certificates.crt':
        ensure  => link,
        target  => "/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem",
    }
}
