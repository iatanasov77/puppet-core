#######################################
# Creating All Needed Scipts
#######################################
class vs_core::scripts
{
    #######################################
    # Creating Directory For Scipts
    #######################################
    ensure_resource( 'file', '/opt/vs_devenv', {
        ensure  => 'directory',
        owner   => 'root',
        group   => 'root',
        mode    => '0777',
    })
    
    #######################################
    # Set Default Java Version
    #######################################
    file { '/opt/vs_devenv/set_default_java.sh':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0777',
        source  => 'puppet:///modules/vs_core/set_default_java.sh',
        require => File['/opt/vs_devenv'],
    }
    
    #######################################
    # Set VS DevEnv ENV Variables
    #######################################
    file { '/etc/profile.d/vs_devenv.sh':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        source  => 'puppet:///modules/vs_core/vs_devenv.sh',
        require => File['/opt/vs_devenv'],
    }
    
    #######################################
    # Set Vault Secrets
    #######################################
    file { '/opt/vs_devenv/vault_setup.php':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0777',
        source  => 'puppet:///modules/vs_core/vault_setup.php',
        require => File['/opt/vs_devenv'],
    }
}