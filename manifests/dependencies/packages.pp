class vs_core::dependencies::packages (
    String $gitUserName     = 'undefined_user_name',
    String $gitUserEmail    = 'undefined@example.com',
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
    
    vs_core::openjdk { 'openjdk-17':
        jdkVersion  => '17',
    }
    
    /* EXEC THIS IF YOU NEEDED , BUT SHOULD BE IN MAIN OR AFTER MAIN STAGE
    Exec{ 'Set Java Default 17':
        command => '/opt/vs_devenv/set_default_java.sh 17',
    }
    */

    #############################################################
    # Install Latest CURL
    #############################################################
    #include vs_core::packages::curl
}
