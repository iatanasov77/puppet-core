class vs_core::packages::java
{
    /*
    class { 'java':
      version => 'latest',
    }
    */
    
    
    Package{ ['java-11-openjdk', 'java-11-openjdk-devel']:
        ensure => present,
    }
}
