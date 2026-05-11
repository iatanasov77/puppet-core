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
    Hash $apiConfig,
    
    Array $indexes      = [],
    Hash $guis          = {},
) {
    class { 'vs_core::elasticsearch::install':
        version     => $version,
        yumRepo     => $yumRepo,
        
        apiProtocol => $apiProtocol,
        apiHost     => $apiHost,
        apiPort     => $apiPort,
        apiUsername => $apiUsername,
        apiPassword => $apiPassword,
        
        apiConfig   => $apiConfig,
    }
    
    class { 'vs_core::elasticsearch::plugins': }
    
    $indexes.each |String $index| {
        elasticsearch::index{ "${index}":
            api_host        => "${apiHost}",
            api_port        => $apiPort,
            api_protocol    => "${apiProtocol}",
            api_timeout     => $apiTimeout,
        }
    }
    
    $guis.each |String $guiKey, Hash $guiConfig| {
        case $guiKey
        {
            'kibana':
            {
                class { "::vs_core::elasticsearch::gui::${$guiKey}":
                    config  => $guiConfig,
                    esHost  => "${apiProtocol}://${apiHost}:${apiPort}",
                }
            }
            default:
            {
                class { "::vs_core::elasticsearch::gui::${$guiKey}":
                    config  => $guiConfig,
                }
            }
        }
    }
}