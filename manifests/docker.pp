class vs_core::docker (
	Hash $config    = {},
) {
	class { 'docker':
        ensure          => 'present',
        version         => "${config['version']}",
        docker_users    => $config['docker_users'],
    }
    
    class { 'docker::compose':
        ensure => present,
        version => "${config['composer_version']}",
    }
    
    class { 'vs_core::docker::portainer':
        admin_password  => "${config['portainer_password']}",
        require         => Class['docker'],
    }
}
