{
  username,
  config,
  pkgs,
  neovim-nightly-overlay,
  ...
}: let
  lib = pkgs.lib;
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
  homeDir =
    if isDarwin
    then "/Users"
    else "/home";
  configDir = ./config;
in rec {
  home.username = username;
  home.homeDirectory = "/${homeDir}/${username}";
  home.stateVersion = "25.05";

  home.packages = [];

  home.sessionVariables = rec {
    EDITOR = "nvim";
    VISUAL = EDITOR;
  };

  home.sessionPath = [
    "~/.nix-profile/bin"
    "/nix/var/nix/profiles/default/bin"
  ];

  home.shellAliases = {
    ls = "eza --group-directories-first";
    ll = "eza -al --group-directories-first";
    tree = "eza -aT --git-ignore --group-directories-first";
  };

  xdg.configFile = builtins.mapAttrs (entry: type: {
    source = "${configDir}/${entry}";
    recursive = type == "directory";
  }) (builtins.readDir configDir);

  programs.home-manager.enable = true;

  programs.neovim = {
    enable = true;
    package = neovim-nightly-overlay.packages.${pkgs.system}.default;
  };

  programs.fish = {
    enable = true;
  };

  programs.ghostty = {
    enable = true;
    package = null;
    settings = {
      font-family = "Iosevka";
      font-size = 18;
      adjust-cell-height = 8;
      font-thicken = true;
      window-padding-x = 12;
      window-padding-y = 12;
      maximize = true;
      shell-integration-features = "no-cursor";
      macos-titlebar-style = "tabs";
    };
  };

  programs.codex.enable = true;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = ["~/.ssh/github"];
        identitiesOnly = true;
      };
      "carlos-inspiron" = {
        hostname = "carlos-inspiron";
        user = "regexpattern";
        identityFile = ["~/.ssh/carlos-inspiron"];
        identitiesOnly = true;
      };
    };
  };

  programs.direnv = {
    enable = true;
    silent = true;
    nix-direnv.enable = true;
  };

  programs = {
    bat.enable = true;
    eza.enable = true;
    fzf.enable = true;
    ripgrep.enable = true;
    fd.enable = true;
    zoxide.enable = true;
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };

  programs.git = {
    enable = true;
    userName = "Carlos Castillo";
    userEmail = "47466248+regexPattern@users.noreply.github.com";
    delta.enable = true;
  };

  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source =
          if isDarwin
          then "macos_small"
          else "linux_small";
        padding = {
          top = 1;
          left = 1;
        };
      };
      modules = [
        {
          type = "host";
          key = "HOST";
        }
        {
          type = "cpu";
          key = "CPU";
        }
        {
          type = "gpu";
          key = "GPU";
        }
        {
          type = "memory";
          key = "MEMORY";
        }
        {
          type = "swap";
          key = "SWAP";
        }
        {
          type = "disk";
          key = "DISK";
          folders = "/";
        }
        {
          type = "os";
          key = "OS";
        }
        {
          type = "packages";
          key = "PACKAGES";
        }
        {
          type = "terminal";
          key = "TERMINAL";
        }
        {
          type = "shell";
          key = "SHELL";
        }
      ];
    };
  };
}
