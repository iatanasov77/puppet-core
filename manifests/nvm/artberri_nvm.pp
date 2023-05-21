/**
 * FORKED FROM https://github.com/artberri/puppet-nvm
 * BUT NVM INSTALL IS GOOD TO USE https://github.com/nvm-sh/nvm
 * MANUAL: https://www.liquidweb.com/kb/install-nvm-node-version-manager-node-js-centos-8/
 */
class vs_core::nvm::artberri_nvm (
    $user,
    $version             = 'v0.29.0',
    
    $nvm_repo            = 'https://github.com/creationix/nvm.git',
    
    $node_instances      = {},
) {

    class { 'vs_core::nvm::install':
        user         => $user,
        home         => "/home/${user}",
        version      => 'v0.29.0',
        nvm_dir      => "/home/${user}/.nvm",
        nvm_repo     => $nvm_repo,
    }

    $node_instances.each |String $version, Hash $params| {
        vs_core::nvm::node::install{ "${version}":
            user        => $user,
            nvm_dir     => "/home/${user}/.nvm",
            set_default => ( 'set_default' in $params )
        }
    }
}
