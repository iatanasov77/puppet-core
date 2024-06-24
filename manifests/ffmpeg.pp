class vs_core::ffmpeg (
    Hash $config    = {},
) {
    if $::operatingsystem != 'centos' {
        fail( "Unsupported OS '${::operatingsystem}'" )
    }
    
    case $::operatingsystem {
        centos: {
            if $::operatingsystemmajrelease == '8' {
                Exec { 'Install RPMfusion Free repository':
                    command => 'dnf -y install https://download1.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm',
                    require => Exec["Force Enabling YumRepo PowerTools"],
                }
                
                Exec { 'Install RPMfusion NonFree repository':
                    command => 'dnf -y install https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-8.noarch.rpm',
                }
            } elsif $::operatingsystemmajrelease == '9' {
                Exec { 'Install RPMfusion Free repository':
                    command => 'dnf -y install https://download1.rpmfusion.org/free/el/rpmfusion-free-release-9.noarch.rpm',
                    require => Exec["Force Enabling YumRepo PowerTools"],
                }
                
                Exec { 'Install RPMfusion NonFree repository':
                    command => 'dnf -y install https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-9.noarch.rpm',
                }
            } else {
                fail( "Unsupported CentOS version '${::operatingsystemmajrelease}'" )
            }
        }
    }
    
    package { 'ffmpeg':
        ensure  => present,
        require => [
            Exec["Install RPMfusion Free repository"],
            Exec["Install RPMfusion NonFree repository"],
        ],
    }
}