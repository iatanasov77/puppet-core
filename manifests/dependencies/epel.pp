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
		    } else {
                $enhancers = ['epel-release', 'epel-next-release']
                
                #####################################################################
                # powertools are called crb(CodeReady Linux Builder, or epel 9) now. 
                #####################################################################
                Exec { 'Enable the CodeReady Linux Builder repository':
                    command => 'dnf config-manager --set-enabled crb',
                } ->
                Package { $enhancers:
                    ensure   => 'present',
                    provider => 'yum',
                } ->
                yumrepo { 'epel-testing':
                    descr       => "Enable Epel-Testing Repo",
                    *           => $yumrepoDefaults,
                }
		    }
		    
		    if $::operatingsystemmajrelease == '8' {
                ###############################################################################################
                # Install EPEL repository – PowerTools repository & EPEL repository are best friends.
                # So enable EPEL repository as well.
                # Note: May be Not Need This because is installed with class vs_devenv::dependencies::epel
                ###############################################################################################
                Exec { 'Install EPEL repository':
                    command => 'dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm',
                } ->
                Exec { "Force Enabling YumRepo PowerTools":
                    command => 'dnf config-manager --set-enabled powertools',
                    require => [
                        Package['epel-release'],
                        Class['vs_core::dependencies::remi'],
                    ],
                }
            }
		}
	}
}
