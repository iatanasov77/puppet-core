class vs_core::app_monitoring::grafana_config (
    Hash $config,
    String $grafanaDirectory,
) {
    File { 'monitoring_grafana_datasources_configs':
        path    => "${grafanaDirectory}/configs",
        ensure  => directory,
        mode    => '0755',
    }
    
    File { 'monitoring_grafana_datasources_rules':
        path    => "${grafanaDirectory}/rules",
        ensure  => directory,
        mode    => '0755',
    }
    
    if ( $config['dataSources']['prometheus']['enabled'] ) {
        $prometheusConfig = $config['dataSources']['prometheus']
        
        File { 'grafana_prometheus_config':
            path    => "${grafanaDirectory}/configs/prometheus.yml",
            owner   => root,
            group   => root,
            mode    => '0644',
            content => template( 'vs_core/app_monitoring/grafana/configs/prometheus.yml.erb' ),
            require => File['monitoring_grafana_datasources_configs'],
        }
        
        if ( $config['dataSources']['prometheus']['alertmanager']['enabled'] ) {
            File { 'grafana_prometheus_alertmanager_config':
                path    => "${grafanaDirectory}/configs/alertmanager-blackbox.yml",
                owner   => root,
                group   => root,
                mode    => '0644',
                content => template( 'vs_core/app_monitoring/grafana/configs/alertmanager-blackbox.yml.erb' ),
                require => File['monitoring_grafana_datasources_configs'],
            }
            
            File { 'alert-rules-blackbox-exporter':
                path    => "${grafanaDirectory}/rules/alerts.yml",
                owner   => root,
                group   => root,
                mode    => '0644',
                content => template( 'vs_core/app_monitoring/grafana/rules/alerts.yml.erb' ),
                require => File['monitoring_grafana_datasources_rules'],
            }
        }
    }
    
    ####################################################
    # Datasources
    ####################################################
    File { 'monitoring_grafana_datasources':
        path    => "${grafanaDirectory}/datasources",
        ensure  => directory,
        mode    => '0755',
    }
    
    if ( $config['dataSources']['prometheus']['enabled'] ) {
        File { 'app_monitoring_grafana_datasource_prometheus':
            path    => "${grafanaDirectory}/datasources/prometheus.yaml",
            owner   => root,
            group   => root,
            mode    => '0644',
            content => template( 'vs_core/app_monitoring/grafana/datasources/prometheus.yaml.erb' ),
            require => File['monitoring_grafana_datasources'],
        }
    }
    
    if ( $config['dataSources']['graphite']['enabled'] ) {
        $graphiteConfig = $config['dataSources']['graphite']
        
        File { 'monitoring_grafana_datasource_graphite':
            path    => "${grafanaDirectory}/datasources/graphite.yaml",
            owner   => root,
            group   => root,
            mode    => '0644',
            content => template( 'vs_core/app_monitoring/grafana/datasources/graphite.yaml.erb' ),
            require => File['monitoring_grafana_datasources'],
        }
    }
    
    ####################################################
    # Dashboards
    ####################################################
    File { 'monitoring_grafana_dashboards':
        path    => "${grafanaDirectory}/dashboards",
        ensure  => directory,
        mode    => '0755',
    }
    
    if ( $config['dataSources']['prometheus']['enabled'] ) {
        File { 'monitoring_grafana_dashboard_blackbox_prometheus':
            path    => "${grafanaDirectory}/dashboards/blackbox_prometheus.json",
            owner   => root,
            group   => root,
            mode    => '0644',
            content => template( 'vs_core/app_monitoring/grafana/dashboards/blackbox_prometheus.json.erb' ),
            require => File['monitoring_grafana_dashboards'],
        }
        
        File { 'monitoring_grafana_dashboard_mercure_prometheus':
            path    => "${grafanaDirectory}/dashboards/mercure_prometheus.json",
            owner   => root,
            group   => root,
            mode    => '0644',
            content => template( 'vs_core/app_monitoring/grafana/dashboards/mercure_prometheus.json.erb' ),
            require => File['monitoring_grafana_dashboards'],
        }
    }
}