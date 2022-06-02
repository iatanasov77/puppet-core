class vs_core::packages::git (
    String $gitUserName     = 'undefined_user_name',
    String $gitUserEmail    = 'undefined@example.com',
) {
    require git
                
    git::config { 'user.name':
        value   => $gitUserName,
        user    => 'vagrant',
    }
    git::config { 'user.email':
        value   => $gitUserEmail,
        user    => 'vagrant',
    }
}
