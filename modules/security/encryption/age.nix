{
  agenix,
  pkgs,
  username,
  ...
}:
{
  environment.systemPackages = [
    agenix.packages."${pkgs.system}".default
  ];

  age = {
    identityPaths = [
      "/home/${username}/.ssh/agenix_key"
    ];
    secrets = {
    };
  };
}
