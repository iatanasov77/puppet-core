class vs_core::hashicorp (
	Hash $config   = {},
) {
    include hashi_stack::repo
    
    if ( 'packer' in $config ) {
        class { vs_core::hashicorp::packer:
            version => $config['packer']['version'],
        }
        
        ######################################################################
        # Install Vagrant Binary
        ######################################################################
        class { vs_core::hashicorp::vagrant:
            data    => $config['packer']['vagrant'],
            stage   => 'packer-setup',
        }
    }
    
    if ( 'terraform' in $config ) {
    	class { vs_core::hashicorp::terraform:
            version => $config['terraform']['version'],
            config  => $config['terraform']['config'],
        }
    }
    
    if ( 'vault' in $config ) {
        class { vs_core::hashicorp::vault:
            version => $config['vault']['version'],
            config  => $config['vault']['config'],
        }
        
        ####################################################################
        # Setup Credentials
        # ------------------
        # https://learn.hashicorp.com/tutorials/vault/static-secrets
        ####################################################################
        class { '::vs_core::hashicorp::vaultSetup':
            port    => "${config['vault']['config']['port']}",
            secrets => "${config['vault']['config']['secrets']}",
            stage   => 'vault-setup',
        }
    }
}
