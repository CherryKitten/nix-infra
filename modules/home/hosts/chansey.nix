{ ... }: {
  programs.ssh.includes = [
    "./famedly-config"
  ];
}
