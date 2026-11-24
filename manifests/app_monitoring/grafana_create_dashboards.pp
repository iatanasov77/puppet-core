class vs_core::app_monitoring::grafana_create_dashboards (
    String $grafanaHost,
    Array $dashboards,
) {
    /*  
    class { 'vs_core::app_monitoring::grafana_service_token':
        grafanaHost => "${facts['hostname']}:${config['port']}",
    }
    $serviceToken = loadjson( '/tmp/GrafanaServiceToken.json' )
    */
    $serviceToken = ''
    
    $dashboards.each |String $dashboard| {
        vs_core::app_monitoring::grafana_dashboard { "Grafana Dashboard ${dashboard}":
            grafanaHost     => $grafanaHost,
            serviceToken    => $serviceToken,
            dashboard       => $dashboard,
            #require        => Class['vs_core::app_monitoring::grafana_service_token'],
        }
    }
}