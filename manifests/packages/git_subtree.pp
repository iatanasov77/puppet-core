class vs_core::packages::git_subtree
{
    $source_dir = "/usr/local/src/git-master/contrib/subtree"
    
    archive { "/tmp/git-source.zip":
        ensure          => present,
        source          => "https://github.com/git/git/archive/refs/heads/master.zip",
        extract         => true,
        extract_path    => '/usr/local/src',
        cleanup         => true,
    }
    
    -> exec { 'Build git-subtree':
        command => "make prefix=/usr libexecdir=/usr/libexec/git-core",
        creates => "${source_dir}/git-subtree",
        cwd     => $source_dir,
        path    => ['/usr/bin', '/bin', '/usr/local/bin'],
    }
    
    -> package { [ 'asciidoc', 'xmlto', ]:
        ensure => present,
    }
    
    -> exec { 'Install git-subtree':
      command => "make prefix=/usr libexecdir=/usr/libexec/git-core install",
      cwd     => $source_dir,
      path    => ['/usr/bin', '/bin', '/usr/local/bin'],
    }
}