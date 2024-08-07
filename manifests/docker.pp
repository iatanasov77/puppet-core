class vs_core::docker (
    Hash $config               = {},
    String $dockerInstallStage = 'main',
) {
    ###############################################################
    # Install Docker
    ###############################################################
    if 'tcp_bind' in $config {
        $tcp_bind   = $config['tcp_bind']
    } else {
        $tcp_bind   = undef
    }
    
    class { 'docker':
        ensure          => 'present',
        version         => "${config['version']}",
        docker_users    => $config['docker_users'],
        tcp_bind        => $tcp_bind,
        
        stage           => $dockerInstallStage,
    }
    
    if 'dockerhubUser' in $config and 'accessToken' in $config {
        Exec { 'Login into Docker Hub':
            command => "/usr/bin/docker login -u ${config['dockerhubUser']} -p ${config['accessToken']}",
            user    => 'vagrant',
            require => Class['docker'],
        }
        
        $requiredPackages   = [ Class['docker'], Exec[ 'Login into Docker Hub'] ]
    } else {
        $requiredPackages   = [ Class['docker'] ]
    }
    
    class { 'docker::compose':
        ensure  => present,
        /*version => "${config['composer_version']}",*/
    }
    
    ###############################################################
    # Install Docker Dashboard
    ###############################################################
    class { 'vs_core::docker::portainer':
        admin_password  => "${config['portainer_password']}",
        require         => $requiredPackages,
    }
}
