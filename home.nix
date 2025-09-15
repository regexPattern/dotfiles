{
  config,
  pkgs,
  neovim-nightly-overlay,
  ...
}: let
  homeDir =
    if pkgs.system == "aarch64-darwin"
    then "/Users"
    else "/home";
  configDir = ./config;
  configEntries = builtins.readDir configDir;
in rec {
  home.username = "regexpattern";
  home.homeDirectory = "/${homeDir}/${home.username}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  xdg.configFile =
    builtins.mapAttrs (entry: type: {
      source = "${configDir}/${entry}";
      recursive = type == "directory";
    })
    configEntries;

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

  # Let Home Manager install and manage itself.
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
    package = pkgs.ghostty-bin;
    settings = {
      font-family = "Iosevka";
      font-size = 18;
      adjust-cell-height = 8;
      font-thicken = true;
      window-padding-x = 12;
      window-padding-y = 12;
      maximize = true;
      macos-titlebar-style = "tabs";
      shell-integration-features = "no-cursor";
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
        source = "macos_small";
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
