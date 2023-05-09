class vs_core::packages::ruby
{
    /*
     * Some Puppet Modules Use Some Ruby Functions Available in Ruby 2.7
     */
    case $::operatingsystem {
        centos: {
            if $::operatingsystemmajrelease == '8' {
                Exec { 'Reset Ruby Module':
                    command => 'dnf module reset -y ruby',
                }
                -> Exec { 'Switch to Ruby 2.7 Stream':
                    command => 'dnf module enable -y ruby:2.7',
                }
                -> Exec { 'Install Ruby 2.7':
                    command => 'dnf module -y install ruby:2.7/common',
                }
            }
        }
    }
}
