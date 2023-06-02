class vs_core::hashicorp::packer (
    String $version = 'latest',
) {
    package { 'packer':
        ensure  => installed,
        require => Class['Hashi_stack::Repo'],
    }
}
