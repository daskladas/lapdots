{ username, ... }:
{
  home-manager.users.${username} = {
    programs.git = {
      enable = true;
      
      settings = {
        user = {
          name = "daskladas";
          email = "xvzrsm@tutanota.de";
        };
        init.defaultBranch = "main";
        pull.rebase = false;
      };
    };
  };
}
