define vs_core::nvm::node::install (
    $user,
    $nvm_dir     = undef,
    $version     = $title,
    
    $set_default = false,
) {

    exec { "nvm install node version ${version}":
        cwd         => $nvm_dir,
        command     => ". ${nvm_dir}/nvm.sh && nvm install ${version}",
        user        => $user,
        unless      => ". ${nvm_dir}/nvm.sh && nvm which ${version}",
        environment => [ "NVM_DIR=${nvm_dir}" ],
        require     => Class['vs_core::nvm::install'],
        provider    => shell,
    }
    
    if $set_default {
        exec { "nvm set node version ${version} as default":
            cwd         => $nvm_dir,
            command     => ". ${nvm_dir}/nvm.sh && nvm alias default ${version}",
            user        => $user,
            environment => [ "NVM_DIR=${nvm_dir}" ],
            unless      => ". ${nvm_dir}/nvm.sh && nvm which default | grep ${version}",
            provider    => shell,
            require     => Exec["nvm install node version ${version}"],
        }
    }
}
