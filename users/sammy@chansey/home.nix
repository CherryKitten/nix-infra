{ ... }: {
  imports = [
    ../sammy/home.nix
  ];
  programs.ssh.includes = [
    "./famedly-config"
  ];
  programs.git.includes = [
    {
      path = "~/famedly/.gitconfig";
      condition = "gitdir:~/famedly/";
    }
  ];
}
