define vs_core::openjdk (
    $jdkVersion     = '17',
) {
    
    $packages   = ["java-${jdkVersion}-openjdk", "java-${jdkVersion}-openjdk-devel"]
    
    $packages.each |String $value|
    {
        if ! defined( Package[$value] ) {
            package { $value:
                ensure => present,
            }
        }
    }
}
