class vs_core::nvm::install (
  $user,
  $home,
  $version,
  $nvm_dir,
  $nvm_repo,
) {

  exec { "git clone ${nvm_repo} ${nvm_dir}":
    command => "git clone ${nvm_repo} ${nvm_dir}",
    cwd     => $home,
    user    => $user,
    unless  => "/usr/bin/test -d ${nvm_dir}/.git",
    notify  => Exec["git checkout ${nvm_repo} ${version}"],
  }

  exec { "git checkout ${nvm_repo} ${version}":
    command     => "git checkout --quiet ${version}",
    cwd         => $nvm_dir,
    user        => $user,
    refreshonly => true,
  }

}
