class vs_core::app_monitoring::grafana_password (
    String $grafanaHost,
    String $newPassword,
) {
    $grafanaUrl = "http://admin:admin@${grafanaHost}/api/user/password"
    
    $command1 = "/usr/bin/curl -X PUT ${grafanaUrl}"
    $command2 = "-H 'Content-Type: application/json'"
    $command3 = "-d '{ \"newPassword\": \"${newPassword}\", \"oldPassword\": \"admin\" }'"
    
    $command = "${command1} ${command2} ${command3}"
    
    Exec { "Change Grafana Admin Password":
        command => $command,
        returns => [0, 56],
    }
}