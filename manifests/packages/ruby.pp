class vs_core::packages::ruby (
    String $rubyVersion = '2.7.2',
) {
    $baseVersion    = $rubyVersion[0,3]
    
    /*
     * Some Puppet Modules Use Some Ruby Functions Available in Ruby 2.7
     */
    case $::operatingsystem {
        centos: {
            if Integer( $::operatingsystemmajrelease ) >= 8 {
                Exec { 'Reset Ruby Module':
                    command => 'dnf module reset -y ruby',
                }
                -> Exec { "Switch to Ruby ${baseVersion} Stream":
                    command => "dnf module enable -y ruby:${baseVersion}",
                }
                -> Exec { "Install Ruby ${baseVersion}":
                    command => "dnf module -y install ruby:${baseVersion}/common",
                }
            }
        }
    }
}
