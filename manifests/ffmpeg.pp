class vs_core::ffmpeg (
    Hash $config    = {},
) {
    if $::operatingsystemmajrelease == '8' {
        Exec { 'Install RPMfusion Free repository':
            command => 'dnf -y install https://download1.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm',
            require => Exec["Force Enabling YumRepo PowerTools"],
        } ->
        
        Exec { 'Install RPMfusion NonFree repository':
            command => 'dnf -y install https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-8.noarch.rpm',
        } ->
        
        package { 'ffmpeg':
            ensure => present,
        }
    }
}