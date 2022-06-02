class vs_core::packages::git_ftp
{
    exec { 'download git-ftp':
        command => '/usr/bin/wget -P /tmp https://raw.githubusercontent.com/git-ftp/git-ftp/master/git-ftp',
        creates => '/tmp/git-ftp',
    }
    
    file { '/bin/git-ftp':
        source  => '/tmp/git-ftp',
        mode    => 'a+x',
        require => Exec['download git-ftp'],
    }
}