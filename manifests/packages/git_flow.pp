class vs_core::packages::git_flow
{
    case $operatingsystem 
    {
        'Debian', 'Ubuntu':
        {
            package { 'git-flow':
                ensure => present,
            }
        }
        'CentOS':
        {
            if $::operatingsystemmajrelease == '8' {
                /* USING NVIE REPO
                wget::fetch { "Download GitFlow Installer":
                    source      => "https://raw.github.com/nvie/gitflow/develop/contrib/gitflow-installer.sh",
                    destination => '/tmp/gitflow-installer.sh',
                    verbose     => true,
                    mode        => '0755',
                    cache_dir   => '/var/cache/wget',
                } ->
                Exec { "Install GitFlow":
                    command     => '/tmp/gitflow-installer.sh',
                }
                */
                
                /* MY FORKED REPO 
                wget::fetch { "Download GitFlow Installer":
                    source      => "https://raw.github.com/iatanasov77/gitflow/use_fixed_gitmodules/contrib/gitflow-installer.sh",
                    destination => '/tmp/gitflow-installer.sh',
                    verbose     => true,
                    mode        => '0755',
                    cache_dir   => '/var/cache/wget',
                } ->
                Exec { "Install GitFlow":
                    command => '/tmp/gitflow-installer.sh',
                }
                */
                
                /* USING PETERVANDERDOES REPO */
                wget::fetch { "Download GitFlow Installer":
                    source      => "https://raw.githubusercontent.com/petervanderdoes/gitflow-avh/develop/contrib/gitflow-installer.sh",
                    destination => '/tmp/gitflow-installer.sh',
                    verbose     => true,
                    mode        => '0755',
                    cache_dir   => '/var/cache/wget',
                } ->
                Exec { "Install GitFlow":
                    command => '/tmp/gitflow-installer.sh install stable',
                }
            } else {
                package { 'gitflow':
                    ensure => present,
                }
            }
        }
    }
}
