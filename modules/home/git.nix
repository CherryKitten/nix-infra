{ ... }: {
  programs.git = {
    enable = true;
    extraConfig = {
      init = { defaultBranch = "main"; };
      core = { editor = "nvim"; };
      pull.rebase = true;
    };
    aliases = {
      a = "add";
      ai = "add -p";
      br = "branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]' --sort=-committerdate";
      c = "commit";
      del = "branch -D";
      p = "push";
      pf = "push --force-with-lease";
      r = "rebase";
      ri = "rebase -i";
      s = "status";
      sw = "switch";
    };
  };
}
