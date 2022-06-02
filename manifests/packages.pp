class vs_core::packages (
    Array $packages         = [],
    String $gitUserName     = 'undefined_user_name',
    String $gitUserEmail    = 'undefined@example.com',
) {
    $packages.each |String $value|
    {
        if ( $value == 'git' ) {
            class { 'vs_core::packages::git':
                gitUserName     => "${gitUserName}",
                gitUserEmail    => "${gitUserEmail}"
            }
        } elsif ( $value == 'git-ftp' ) {
        	include vs_core::packages::git_ftp
        } elsif ( $value == 'gitflow' ) {
            include vs_core::packages::git_flow
        } else {
        	if ! defined(Package[$value]) {
	            package { $value:
	                ensure => present,
	            }
	        }
        }
    }
}
