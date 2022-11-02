class vs_core::packages::git (
    String $gitUserName     = 'undefined_user_name',
    String $gitUserEmail    = 'undefined@example.com',
) {
    require git
           
    /*
     * `git::config ` make dependency cycle here
     * -----------------------------------------
     *
    */
}
