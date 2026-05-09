class vs_core::elasticsearch::gui::dejavu (
    Hash $config,
    String $systemd_unit_path   = '/etc/systemd/system',
) {
    /**
     * https://blog.marcnuri.com/docker-container-as-linux-system-service
     */
    file { 'dejavu.service':
        path    => "${systemd_unit_path}/dejavu.service",
        owner   => root,
        group   => root,
        mode    => '0444',
        content => template( 'vs_core/dejavu.service.erb' ),
        notify  => [
            Exec['daemon-reload'],
            Service['dejavu'],
        ],
    }
    
    service { 'dejavu':
        ensure      => running,
        enable      => true,
        provider    => systemd,
        timeout     => 3600,
        require     => File['dejavu.service'],
    }
}