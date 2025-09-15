{
  config,
  pkgs,
  neovim-nightly-overlay,
  username,
  host,
  ...
}: let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;
  homeDir =
    if isDarwin
    then "/Users"
    else "/home";
  configsDir = ./configs;
in rec {
  home.username = username;
  home.homeDirectory = "/${homeDir}/${username}";
  home.stateVersion = "25.05";

  home.sessionPath = [
    "~/.nix-profile/bin"
    "/nix/var/nix/profiles/default/bin"
  ];
  home.sessionVariables = rec {
    EDITOR = "nvim";
    VISUAL = EDITOR;
  };
  home.shellAliases = {
    ls = "eza --group-directories-first";
    ll = "eza -al --group-directories-first";
    tree = "eza -aT --git-ignore --group-directories-first";
  };

  xdg.configFile = builtins.mapAttrs (entry: type: {
    source = "${configsDir}/${entry}";
    recursive = type == "directory";
  }) (builtins.readDir configsDir);

  programs.home-manager.enable = true;

  programs = {
    bat.enable = true;
    eza.enable = true;
    fd.enable = true;
    fzf.enable = true;
    ripgrep.enable = true;
    zoxide.enable = true;
  };

  programs.fish = {
    enable = true;
  };

  programs.ghostty =
    if isDarwin
    then {
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
    }
    else {};

  programs.neovim = {
    enable = true;
    package = neovim-nightly-overlay.packages.${pkgs.system}.default;
  };

  programs.codex = {
    enable = true;
    settings.approval_policy = "untrusted";
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks =
      {
        "github.com" = {
          user = "git";
          identityFile = ["~/.ssh/github"];
          identitiesOnly = true;
        };
      }
      // (
        if isDarwin
        then {
          "carlos-inspiron*" = {
            identityFile = ["~/.ssh/carlos-inspiron"];
            identitiesOnly = true;
          };
          "carlos-raspberry-pi*" = {
            identityFile = ["~/.ssh/carlos-raspberry-pi"];
            identitiesOnly = true;
          };
        }
        else {}
      );
  };

  programs.direnv = {
    enable = true;
    silent = true;
    nix-direnv.enable = true;
  };

  programs.gh = {
    enable = true;
    settings.git_protocol = "ssh";
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
          {
            "carlos-macbook-pro" = "macos_small";
            "carlos-inspiron" = "ubuntu_small";
            "carlos-rapsberry-pi" = "raspbian_small";
          }.${
            host
          };
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
