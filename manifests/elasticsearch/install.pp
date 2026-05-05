class vs_core::elasticsearch::install (
    Variant[String, Boolean] $version,
    Variant[String, Boolean] $yumRepo = false,
    
    Enum['http', 'https'] $apiProtocol = 'https',
    String $apiHost,
    Integer[0, 65535] $apiPort,
    Integer $apiTimeout = 10,
    String $apiUsername = 'elastic',
    String $apiPassword = 'elastic',
    
) {
    if ( $yumRepo == false ) {
        $manageRepo = true
        $requiredPackages   = []
    } else {
        $manageRepo = false
        $requiredPackages   = [ Yumrepo['elasticsearch'] ]
    }
    
    if ( $yumRepo != false ) {
        yumrepo { 'elasticsearch':
            ensure      => 'present',
            descr       => "Elasticsearch repository for ${yumRepo} packages",
            baseurl     => "https://artifacts.elastic.co/packages/${yumRepo}/yum",
            gpgkey      => 'https://artifacts.elastic.co/GPG-KEY-elasticsearch',
            enabled     => true,
            gpgcheck    => '1',
            #target      => '/etc/yum.repo.d/puppetlabs.repo',
        }
    }

    ###########################################################################################
    # In Elastic Search 8.x
    # =======================
    # Aborting auto configuration because the node keystore contains password settings already
    ###########################################################################################
    class { 'elasticsearch':
        version                 => $version,
        manage_repo             => $manageRepo,
        
        api_protocol            => "${apiProtocol}",
        api_host                => "${apiHost}",
        api_port                => $apiPort,
        api_timeout             => $apiTimeout,
        api_basic_auth_username => "${apiUsername}",
        api_basic_auth_password => "${apiPassword}",
        
        api_ca_file             => undef,
        api_ca_path             => undef,
        validate_tls            => true,
        
        require                 => $requiredPackages,
    }
}