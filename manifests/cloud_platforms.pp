class vs_core::cloud_platforms (
    Hash $config       = {},
) {
    if ( 'azure' in $config and $config['azure'] ) {
        case $facts['os']['family'] {
            'RedHat': {
              yumrepo { 'AzureCli':
                descr         => 'Microsoft Azure package repository.',
                baseurl       => "https://packages.microsoft.com/yumrepos/azure-cli",
                gpgcheck      => 1,
                gpgkey        => 'https://packages.microsoft.com/keys/microsoft.asc',
                repo_gpgcheck => 0,
                enabled       => 1,
                /*priority    => 50,*/
              }
            }
            default: {
                fail("\"${module_name}\" provides no repository information for OSfamily \"${facts['os']['family']}\"")
            }
        }
        
        package { "azure-cli":
            ensure  => installed,
            require => Yumrepo['AzureCli'],
        }
    }
    
    if ( 'aws' in $config and $config['aws'] ) {
        # CentOs 7 and CentOs 8
        package { "awscli":
            ensure  => installed,
        }
    }
    
    if ( 'digital_ocean' in $config ) {
    
        archive { "/tmp/doctl-1.94.0-linux-amd64.tar.gz":
            ensure          => present,
            source          => "https://github.com/digitalocean/doctl/releases/download/v${config['digital_ocean']}/doctl-${config['digital_ocean']}-linux-amd64.tar.gz",
            extract         => true,
            extract_path    => '/usr/local/bin',
            cleanup         => true,
        }
        -> file { '/usr/local/bin/doctl':
            ensure  => 'present',
            mode    => '0755',
        }
        
    }
    
    ###################################################################################################
    # Official s3cmd repo -- Command line tool for managing Amazon S3 and CloudFront services
    # ----------------------------------------------------------------------------------------
    # https://github.com/s3tools/
    ##################################################################################################@
    if ( 's3tools' in $config and $config['s3tools'] ) {
        
        # CentOs 7 and CentOs 8
        package { "s3cmd":
            ensure  => installed,
        }
        
    }
    
    if ( 'k8s_station' in $config ) {
        wget::fetch { "Install 'kubectl' Tool to Manage External Kubernetes  Clusters.":
            source      => "https://dl.k8s.io/release/v${config['k8s_station']}/bin/linux/amd64/kubectl",
            destination => '/usr/local/bin/kubectl',
            verbose     => true,
            mode        => '0755',
            cache_dir   => '/var/cache/wget',
        }
    }
}
