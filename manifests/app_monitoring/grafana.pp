class vs_core::app_monitoring::grafana (
    Hash $config                = {},
    String $systemd_unit_path   = '/etc/systemd/system',
    String $hostIp              = '0.0.0.0',
) {
    $grafanaDirectory = '/opt/grafana'
    
    File { 'grafana_opt_dir':
        path    => "${grafanaDirectory}",
        ensure  => directory,
        mode    => '0755',
    }
    
    class { 'vs_core::app_monitoring::grafana_config':
        config              => $config,
        grafanaDirectory    => $grafanaDirectory,
        require             => File['grafana_opt_dir'],
    }
    
    class { 'vs_core::app_monitoring::external_resources':
        volumes     => $config['volumes'],
        networks    => $config['networks'],
        require         => [
            Service['docker']
        ],
    }
    
    File { 'grafana_docker_compose_file':
        path    => "${grafanaDirectory}/docker-compose.yml",
        owner   => root,
        group   => root,
        mode    => '0644',
        content => template( 'vs_core/app_monitoring/grafana/docker-compose.yml.erb' ),
        require => File['grafana_opt_dir'],
    }
    
    docker_compose { 'grafana_docker_compose':
        ensure          => present,
        
        compose_files   => ["${grafanaDirectory}/docker-compose.yml"],
        #up_args         => '-it',
        
        require         => [
            Class['vs_core::app_monitoring::grafana_config'],
            Class['vs_core::app_monitoring::external_resources'],
            File['grafana_docker_compose_file'],
        ],
    }
    
    File { 'grafana.service':
        path    => "${systemd_unit_path}/grafana.service",
        owner   => root,
        group   => root,
        mode    => '0644',
        content => template( 'vs_core/app_monitoring/grafana/docker_compose.service.erb' ),
        require => Docker_compose['grafana_docker_compose'],
        notify  => [
            Exec['daemon-reload'],
        ],
    }
}