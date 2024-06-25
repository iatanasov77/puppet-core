class vs_core::dependencies::epel (
    $yumrepoDefaults,
) {
	case $::operatingsystem {
    	centos: {
			if ! defined( Package['epel-release'] ) and Integer( $::operatingsystemmajrelease ) < 9 {
		        Exec { 'Import RPM GPG KEYS':
		            command => 'rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY*',
		        } ->
		        Package { 'epel-release':
		            ensure   => 'present',
		            provider => 'yum',
		        } ->
		        yumrepo { 'epel-testing':
                    descr       => "Enable Epel-Testing Repo",
                    *           => $yumrepoDefaults,
                }
		    }
		    
<<<<<<< Updated upstream
		    
=======
>>>>>>> Stashed changes
		    ###############################################################################################
            # Install EPEL repository – PowerTools repository & EPEL repository are best friends.
            # So enable EPEL repository as well.
            # Note: May be Not Need This because is installed with class vs_devenv::dependencies::epel
            ###############################################################################################
		    if $::operatingsystemmajrelease == '8' {
                Exec { 'Install EPEL repository':
                    command => 'dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm',
                }
                
                Exec { "Force Enabling YumRepo PowerTools":
                    command => 'dnf config-manager --set-enabled powertools',
                    require => [
                        Package['epel-release'],
                        Class['vs_core::dependencies::remi'],
                        Exec["Install EPEL repository"],
                    ],
                }
            }
            
            if $::operatingsystemmajrelease == '9' {
                Exec { 'Install EPEL repository':
                    command => 'dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm',
                }
                
<<<<<<< Updated upstream
                # powertools are called crb in epel 9
=======
                Package { ['epel-release', 'epel-next-release']:
                    ensure   => 'present',
                    provider => 'yum',
                    require => [
                        Exec["Install EPEL repository"],
                    ],
                }
                
                #####################################################################
                # powertools are called crb(CodeReady Linux Builder, or epel 9) now. 
                #####################################################################
>>>>>>> Stashed changes
                Exec { "Force Enabling YumRepo PowerTools":
                    command => 'dnf config-manager --set-enabled crb',
                    require => [
                        Package['epel-release'],
                        Class['vs_core::dependencies::remi'],
                        Exec["Install EPEL repository"],
                    ],
                }
<<<<<<< Updated upstream
=======
                
                yumrepo { 'epel-testing':
                    descr   => "Enable Epel-Testing Repo",
                    *       => $yumrepoDefaults,
                    require => [
                        Package['epel-release'],
                    ],
                }
>>>>>>> Stashed changes
            } 
		}
	}
}
