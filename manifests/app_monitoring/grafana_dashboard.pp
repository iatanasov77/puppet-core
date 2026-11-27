define vs_core::app_monitoring::grafana_dashboard (
    String $grafanaHost,
    String $serviceToken,
    String $dashboard,
) {
    #$grafanaUrl = http://${grafanaHost}/apis/dashboard.grafana.app/v2/namespaces/default/dashboards
    $grafanaUrl = "http://admin:admin@${grafanaHost}/apis/dashboard.grafana.app/v2/namespaces/default/dashboards"
    
    $command1 = "/usr/bin/curl -X POST ${grafanaUrl}"
    $command2 = "-H 'Content-Type: application/json'"
    $command3 = "-H 'Authorization: Bearer ${serviceToken}'"
    $command4 = "-d @/opt/grafana/dashboards/${dashboard}.json"
    
    #$command = "${command1} ${command2} ${command3} ${command4}"
    $command = "${command1} ${command2} ${command4}"
    
    Exec { "Install Dashboard ${dashboard}":
        command => $command,
        returns => [0, 56],
    }
}