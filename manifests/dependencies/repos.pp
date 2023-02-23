class vs_core::dependencies::repos (
    Hash $dependencies     = {},
	$repos                 = {},
	Boolean $forcePhp7Repo = true,
	String $phpVersion     = '7.2',
	String $mySqlProvider  = 'mysql'
) {

    $yumrepoDefaults = {
        'ensure'   => 'present',
        'enabled'  => true,
        'gpgcheck' => false,
        'priority' => 50,
    }
            
    case $::operatingsystem {
    	centos: {
            class { 'vs_core::dependencies::epel':
                yumrepoDefaults => $yumrepoDefaults,
            }
            
            class { 'vs_core::dependencies::remi':
                remiReleaseRpm  => "${dependencies['remiReleaseRpm']}",
                yumrepoDefaults => $yumrepoDefaults,
            }
            
            if Integer( $::operatingsystemmajrelease ) >= 8 {
                if ! defined( Package['dnf-plugins-core'] ) {
                    Package { 'dnf-plugins-core':
                        ensure => present,
                    }
                }
		    }
		    
            if $::operatingsystemmajrelease == '7' {
		    	if ! defined( Package['yum-plugin-priorities'] ) {
		            Package { 'yum-plugin-priorities':
		                ensure => 'present',
		            }
		        }
		        
		        if $mySqlProvider == 'mysql' {
                    include vs_core::dependencies::mysql_comunity_repo
                }
		    }
		    
		    if ( $forcePhp7Repo ) {
			    class { 'vs_core::dependencies::php7':
			    	phpVersion		=> $phpVersion,
					yumrepoDefaults	=> $yumrepoDefaults,
			    }
			}
	    }
	}
}