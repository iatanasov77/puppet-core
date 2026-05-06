class vs_core::dependencies::php7 (
	$phpVersion			= '7.4',
	$yumrepoDefaults
) {
	$phpVersionShort    = regsubst( sprintf( "%.1f", $phpVersion ), '[.]', '', 'G' )
	
	case $facts['os']['name'] {
    	'RedHat', 'CentOS', 'OracleLinux', 'Fedora', 'AlmaLinux': {
    		$repo               = sprintf( 'remi-php%s', "${phpVersionShort}" )
    		
		    if $facts['os']['release']['major'] == '7' {
		    	$repoMirrors		= "http://cdn.remirepo.net/enterprise/7/php${phpVersionShort}/mirror"
		    	$requiredPackages	= [ Package['remi-release'], Package['yum-plugin-priorities'] ]
		    } elsif $facts['os']['release']['major'] == '8' {
		    	$repoMirrors		= "http://cdn.remirepo.net/enterprise/8/php${phpVersionShort}/x86_64/mirror"
		    	$requiredPackages	= [ Package['remi-release'] ]
		    } else {
                $requiredPackages   = [ Package['remi-release'] ]
		    }
		    
		    # PHP 8.2 Has Not Mirror
		    if Integer( $phpVersionShort ) < 82  and Integer( $facts['os']['release']['major'] ) < 9 {
    			yumrepo { $repo:
    		        descr      	=> "Remi PHP ${phpVersion} RPM repository for Enterprise Linux",
    		        mirrorlist	=> $repoMirrors,
    		        require  	=> $requiredPackages,
    		        *          	=> $yumrepoDefaults,
    		    }
    		}
    		
		    Exec { 'Reset PHP Module':
                command => 'dnf module reset -y php',
                require => $requiredPackages,
            }
            -> Exec { 'Install PHP Module Stream':
                command => "dnf module install -y php:remi-${phpVersion}",
                require => $requiredPackages,
            }
		}
	}
}
