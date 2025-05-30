class vs_core::vstools (
    Hash $vstools   = {},
) {
	# Install VankoSoft BumpVersion script
	if ( 'bumpversion' in $vstools ) {
    	wget::fetch { "Install VankoSoft BumpVersion script":
    		source      => "https://github.com/iatanasov77/bumpversion/raw/v${vstools['bumpversion']}/bumpversion.php",
    		destination => '/usr/local/bin/bumpversion',
    		verbose     => true,
    		mode        => '0777',
    		cache_dir   => '/var/cache/wget',
    	}
    }
	
	# Install VankoSoft GitflowReinit script
	if ( 'gitflow-reinit' in $vstools ) {
        wget::fetch { "Install VankoSoft GitflowReinit script":
            source      => "https://github.com/iatanasov77/bumpversion/raw/v${vstools['gitflow-reinit']}/gitflow-reinit.php",
            destination => '/usr/local/bin/gitflow-reinit',
            verbose     => true,
            mode        => '0777',
            cache_dir   => '/var/cache/wget',
        }
    }
	
	# Install VankoSoft MkPhar script
	if ( 'mkphar' in $vstools ) {
    	wget::fetch { "Install VankoSoft MkPhar script":
    		source      => "https://github.com/iatanasov77/mkphar/raw/v${vstools['mkphar']}/mkphar.php",
    		destination => '/usr/local/bin/mkphar',
    		verbose     => true,
    		mode        => '0777',
    		cache_dir   => '/var/cache/wget',
    	}
    }
	
	# Install VankoSoft MkVhost script
	if ( 'mkvhost' in $vstools ) {
    	wget::fetch { "Install VankoSoft MkVhost script":
    		source      => "https://github.com/iatanasov77/mkvhost/releases/download/v${vstools['mkvhost']}/mkvhost.phar",
    		destination => '/usr/local/bin/mkvhost',
    		verbose     => true,
    		mode        => '0777',
    		cache_dir   => '/var/cache/wget',
    	}
    }
	
	# Install FtpDeploy script
	if ( 'ftpdeploy' in $vstools ) {
        wget::fetch { "Install FtpDeploy script":
            #source      => "https://github.com/iatanasov77/ftp-deployment/releases/download/v2.9/deployment.phar",
            #source      => "https://github.com/dg/ftp-deployment/releases/download/${vstools['ftpdeploy']}/deployment.phar",
            source      => "http://downloads.vankosoft.org/vstools/0-ftpdeploy-${vstools['ftpdeploy']}.phar",
            destination => '/usr/local/bin/ftpdeploy',
            verbose     => true,
            mode        => '0777',
            cache_dir   => '/var/cache/wget',
        }
    }
}
