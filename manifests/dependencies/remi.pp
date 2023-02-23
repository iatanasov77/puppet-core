class vs_core::dependencies::remi (
    $yumrepoDefaults,
    String $remiReleaseRpm
) {
    case $::operatingsystem {
        centos: {
            if $::operatingsystemmajrelease == '7' {
                $remiSafeMirrors    = 'http://cdn.remirepo.net/enterprise/7/safe/mirror'
                $requiredPackages   = [ Package['epel-release'], Package['yum-plugin-priorities'] ]
            } elsif Integer( $::operatingsystemmajrelease ) >= 8 {
                $remiSafeMirrors    = "http://cdn.remirepo.net/enterprise/${operatingsystemmajrelease}/safe/x86_64/mirror"
                $requiredPackages    = [ Package['epel-release'] ]
            }
            
            if ! defined( Package['remi-release'] ) {
                if empty( $remiReleaseRpm ) {
                    $remiReleaseSource  = "http://rpms.remirepo.net/enterprise/remi-release-${operatingsystemmajrelease}.rpm"
                } else {
                    $remiReleaseSource  = $remiReleaseRpm
                }
                
                Package { 'remi-release':
                    ensure   => 'present',
                    name     => 'remi-release',
                    provider => 'rpm',
                    source   => $remiReleaseSource,
                    require  => $requiredPackages,
                }
            }
            
            yumrepo { 'remi-safe':
                descr       => 'Safe Remi RPM repository for Enterprise Linux',
                mirrorlist  => $remiSafeMirrors,
                require     => $requiredPackages,
                *           => $yumrepoDefaults,
            }
        }
    }
}
