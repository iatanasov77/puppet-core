#######################################################################################################
# Install Plugins
# ================
# https://github.com/voxpupuli/puppet-elasticsearch#plugins
#
# How to use dejavu for elasticsearch on local running it from opensource.appbase.io
# ====================================================================================
# https://stackoverflow.com/questions/50231296/how-to-use-dejavu-for-elasticsearch-on-local-running-it-from-opensource-appbase
#######################################################################################################
class vs_core::elasticsearch (
    Variant[String, Boolean] $version = false,
    Variant[String, Boolean] $yumRepo = false,
    
    Enum['http', 'https'] $apiProtocol = 'https',
    String $apiHost,
    Integer[0, 65535] $apiPort,
    Integer $apiTimeout = 10,
    String $apiUsername = 'elastic',
    String $apiPassword = 'elastic',
    
<<<<<<< HEAD
    Hash $apiConfig,
=======
>>>>>>> 9244c815473026ea626abdfdaaa96a7924748a00
) {
    class { 'vs_core::elasticsearch::install':
        version     => $version,
        yumRepo     => $yumRepo,
        
        apiProtocol => $apiProtocol,
        apiHost     => $apiHost,
        apiPort     => $apiPort,
        apiUsername => $apiUsername,
        apiPassword => $apiPassword,
<<<<<<< HEAD
        
        apiConfig   => $apiConfig,
=======
>>>>>>> 9244c815473026ea626abdfdaaa96a7924748a00
    }
    
    # Error: Could not find a suitable provider for elasticsearch_plugin
    #######################################################################
    #class { 'vs_core::elasticsearch::gui': }
}