class vs_core::dependencies::packages (
    String $gitUserName     = 'undefined_user_name',
    String $gitUserEmail    = 'undefined@example.com',
    String $jdkVersion      = '17',
) {

    if (
        ( $::operatingsystem == 'centos' or $::operatingsystem == 'AlmaLinux' ) and
        $::operatingsystemmajrelease == '9' and
        ! defined( Package['initscripts'] )
    ) {
        Package { 'initscripts':
            ensure => present,
        }
    }
    
    class { 'vs_core::packages::git':
        gitUserName     => "${gitUserName}",
        gitUserEmail    => "${gitUserEmail}"
    }
    
    if ! defined(Package['wget']) {
        Package { 'wget':
            ensure => present,
        }
    }
    
    if ! defined(Package['unzip']) {
        Package { 'unzip':
            ensure => present,
        }
    }
    
    vs_core::openjdk { "openjdk-${jdkVersion}":
        jdkVersion  => "${jdkVersion}",
    }
    
    #############################################################
    # Install Latest CURL
    #############################################################
    #include vs_core::packages::curl
    
    exec { 'daemon-reload':
        command     => 'systemctl daemon-reload',
        path        => '/bin:/sbin:/usr/bin:/usr/sbin',
        refreshonly => true,
    }
}
