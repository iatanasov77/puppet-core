class vs_core::elasticsearch::gui::kibana (
    Hash $config,
    String $esHost,
) {
    class { 'kibana':
        ensure => "${config['version']}",
        
        config => {
            'server.port' => $config['port'],
            'server.host' => "${facts['host_ip']}",
            'server.name' => "${facts['hostname']}",
            
            'elasticsearch.hosts'           => ["${esHost}"],
            'elasticsearch.requestTimeout'  => '180000',
        },
    }
}