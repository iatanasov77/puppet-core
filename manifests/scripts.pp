#######################################
# Creating All Needed Scipts
#######################################
class vs_core::scripts
{
    #######################################
    # Creating Directory For Scipts
    #######################################
    file { '/opt/vs_devenv':
        ensure  => 'directory',
        owner   => 'root',
        group   => 'root',
        mode    => '0777',
    }
    
    #######################################
    # Set Default Java Version
    #######################################
    -> file { '/opt/vs_devenv/set_default_java.sh':
        ensure  => present,
        owner   => 'root',
        group   => 'root',
        mode    => '0777',
        source  => 'puppet:///modules/vs_core/set_default_java.sh',
    }
}