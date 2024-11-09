class vs_core::git_setup (
    String $gitUserName     = 'undefined_user_name',
    String $gitUserEmail    = 'undefined@example.com',
    Array $gitCredentials  	= [],
) {
    include vs_core::packages::git_subtree
    
    # Setup Git Global Config
    git::config { 'user.name':
        value   => $gitUserName,
        user    => 'vagrant',
    }
    git::config { 'user.email':
        value   => $gitUserEmail,
        user    => 'vagrant',
    }
    
    # Download Git Prompt
    wget::fetch { "Download GitPrompt Script":
        source      => "https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh",
        destination => '/usr/local/bin/git-prompt.sh',
        verbose     => true,
        mode        => '0777',
        cache_dir   => '/var/cache/wget',
    }
    # Setup Git Prompt
    file_line { 'source_git_prompt':
        path => '/home/vagrant/.bashrc',
        line => 'source /usr/local/bin/git-prompt.sh',
    } ->
    file_line { 'use_git_prompt':
        path => '/home/vagrant/.bashrc',
        line => 'PS1=\'`if [ $? = 0 ]; then echo "\[\e[32m\] ✔ "; else echo "\[\e[31m\] ✘ "; fi`\[\033[01;32m\]\u@\h\[\033[00m\]:\[\e[01;34m\]\w\[\e[00;34m\] `(( $(git status --porcelain 2>/dev/null | wc -l) == 0 )) && echo "\[\e[01;32m\]" || ( (( $(git status --porcelain --untracked-files=no 2>/dev/null | wc -l) > 0 )) && echo "\[\e[01;31m\]" ) || echo "\[\e[01;33m\]"`$(__git_ps1 "(%s)")`echo "\[\e[00m\]"`\$ \'',
    }
    
    # Setup Git Credentials
    exec { 'Setup Git Credentials':
        command     => '/usr/bin/git config --global credential.helper store',
        user        => 'vagrant',
        environment => ["HOME=/home/vagrant"],
    } ->
    file { '/home/vagrant/.git-credentials':
		ensure => present,
	}
	
    $gitCredentials.each |String $value|
    {
        file_line { "${value}":
            path    => '/home/vagrant/.git-credentials',
            line    => "${value}",
            require => File['/home/vagrant/.git-credentials'],
        }
    }
}
