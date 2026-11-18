/*
 * A lightweight and portable command-line YAML, JSON, INI and XML processor.
 * yq uses jq (a popular JSON processor)
 */
class vs_core::packages::yq
{
    wget::fetch { "Install YQ":
        source      => "https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64",
        destination => '/usr/local/bin/yq',
        verbose     => true,
        mode        => '0777',
        cache_dir   => '/var/cache/wget',
    }
}