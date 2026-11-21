class vs_core::app_monitoring::external_resources (
    Array $volumes = [],
    Array $networks = [],
) {
    $volumes.each |String $name| {
        docker_volume { $name:
            * => { 'ensure' => 'present' },
        }
    }
    
    $networks.each |String $name| {
        docker_network { $name:
            * => { 'ensure' => 'present', driver => 'bridge' },
        }
    }
}