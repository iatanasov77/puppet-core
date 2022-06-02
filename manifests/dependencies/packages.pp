class vs_core::dependencies::packages (
    String $gitUserName     = 'undefined_user_name',
    String $gitUserEmail    = 'undefined@example.com',
) {

    class { 'vs_devops::packages::git':
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
    
    include vs_devops::packages::java
    
    #############################################################
    # Install Latest CURL
    #############################################################
    #include vs_devops::packages::curl
}
