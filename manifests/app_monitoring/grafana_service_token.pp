class vs_core::app_monitoring::grafana_service_token (
    String $grafanaHost,
) {
    $serviceAccountCommand1 = "/usr/bin/curl -X POST http://admin:admin@${grafanaHost}/api/serviceaccounts"
    $serviceAccountCommand2 = "-H 'Content-Type: application/json'"
    $serviceAccountCommand3 = "-d @/opt/grafana/dashboards/blackbox_prometheus.json > /tmp/GrafanaServiceAccount.json"
    
    Exec { "Create GrafanaServiceAccount":
        command => "${serviceAccountCommand1} ${serviceAccountCommand2} ${serviceAccountCommand3}",
        returns => [0, 56],
    }
    $serviceAccount = loadjson( '/tmp/GrafanaServiceAccount.json' )
    
    $serviceTokenCommand1 = "/usr/bin/curl -X POST http://admin:admin@${grafanaHost}/api/serviceaccounts/${serviceAccount['id']}/tokens"
    $serviceTokenCommand2 = "-H 'Content-Type: application/json'"
    $serviceTokenCommand3 = "-d @/opt/grafana/dashboards/blackbox_prometheus.json > /tmp/GrafanaServiceToken.json"
    
    Exec { "Create GrafanaServiceToken":
        command => "${serviceTokenCommand1} ${serviceTokenCommand2} ${serviceTokenCommand3}",
        returns => [0, 56],
    }
}