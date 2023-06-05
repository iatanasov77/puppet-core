class vs_core::hashicorp::terraform (
    String $version = 'latest',
    Hash $config    = {}
) {
    package { 'terraform':
        ensure  => installed,
        require => Class['Hashi_stack::Repo'],
    }
    
    # Set Environement Variables for Cloud Access
    file { "/etc/profile.d/terraform.sh":
        ensure  => present,
        content => template( 'vs_core/hashicorp/terraform_profile.sh.erb' ),
        require => Package['terraform']
    }
}
