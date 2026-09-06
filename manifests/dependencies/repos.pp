class vs_core::dependencies::repos {

    $yumrepoDefaults = {
        'ensure'   => 'present',
        'enabled'  => true,
        'gpgcheck' => false,
        'priority' => 50,
    }
    
    case $facts['os']['name'] {
    	'RedHat', 'CentOS', 'OracleLinux', 'Fedora', 'AlmaLinux': {
            class { 'vs_core::dependencies::epel':
                yumrepoDefaults => $yumrepoDefaults,
            }
            
            if Integer( $facts['os']['release']['major'] ) >= 8 {
                if ! defined( Package['dnf-plugins-core'] ) {
                    Package { 'dnf-plugins-core':
                        ensure => present,
                    }
                }
		    }
		    
            if $facts['os']['release']['major'] == '7' {
		    	if ! defined( Package['yum-plugin-priorities'] ) {
		            Package { 'yum-plugin-priorities':
		                ensure => 'present',
		            }
		        }
		    }
	    }
	}
}