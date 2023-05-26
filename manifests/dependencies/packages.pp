class vs_core::dependencies::packages (
    String $gitUserName     = 'undefined_user_name',
    String $gitUserEmail    = 'undefined@example.com',
) {

    if $::operatingsystem == 'centos' and $::operatingsystemmajrelease == '9' and ! defined( Package['initscripts'] ) {
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
    
    include vs_java::openjdk
    
    #############################################################
    # Install Latest CURL
    #############################################################
    #include vs_core::packages::curl
}
