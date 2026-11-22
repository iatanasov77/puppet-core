class vs_core::app_monitoring (
    Hash $grafanaConfig,
    
    String $systemd_unit_path   = '/etc/systemd/system',
    String $hostIp              = '0.0.0.0',
) {
    if $grafanaConfig['enabled'] {
        class { 'vs_core::app_monitoring::grafana':
            config => $grafanaConfig,
        }
    }
}