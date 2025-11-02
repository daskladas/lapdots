{
  agenix,
  system,
  username,
  ...
}:
{
  environment.systemPackages = [
    agenix.packages."${system}".default
  ];

  age = {
    identityPaths = [
      "/home/${username}/.ssh/agenix_key"
    ];
    secrets = {
    };
  };
}
