class vs_core::hashicorp::vault (
    String $version = 'latest',
    Hash $config    = { port => '8200' }
) {
    package { 'vault':
        ensure  => installed,
        require => Class['Hashi_stack::Repo'],
    } ->
    vs_core::hashicorp::vaultService { 'vault':
        vaultPort   => "${config['port']}",
    }
}