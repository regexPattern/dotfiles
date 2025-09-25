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
    # LS_COLORS = "di=1;36";
  };
  home.shellAliases = {
    ls = "eza --group-directories-first";
    ll = "eza -al --group-directories-first";
    tree = "eza -aT --git-ignore --group-directories-first";
  };

  home.packages = with pkgs; [imagemagick qemu];

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
        background-opacity = 0.85;
        background-blur = 64;
        theme = "Blue Dolphin";
        maximize = true;
        shell-integration-features = "no-cursor";
        macos-titlebar-style = "tabs";

        palette = [
          "0=#292d3e"
          "1=#ff8288"
          "2=#b4e88d"
          "3=#f4d69f"
          "4=#82aaff"
          "5=#e9c1ff"
          "6=#89ebff"
          "7=#d0d0d0"
          "8=#434758"
          "9=#ff8b92"
          "10=#ddffa7"
          "11=#ffe585"
          "12=#9cc4ff"
          "13=#ddb0f6"
          "14=#a3f7ff"
          "15=#ffffff"
        ];
        background = "#5ea1b5";
        foreground = "#c5f2ff";
        cursor-color = "#ffcc00";
        cursor-text = "#292d3e";
        selection-background = "#c5f2ff";
        selection-foreground = "#5ea1b5";
      };
    }
    else {};

  programs.neovim = {
    enable = true;
    package = neovim-nightly-overlay.packages.${pkgs.system}.default;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter-parsers.c
      nvim-treesitter-parsers.lua
      nvim-treesitter-parsers.nix
      nvim-treesitter-parsers.rust
    ];
  };

  programs.codex = {
    enable = true;
    settings = {
      approval_policy = "untrusted";
      model = "gpt-5-codex";
      model_reasoning_effort = "medium";
    };
  };

  programs.opencode = {
    enable = true;
    settings = {
      theme = "system";
      autoshare = false;
    };
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
    settings = import ./configs/nix/fastfetch.nix {inherit host isLinux;};
  };

  xdg.configFile = {
    "nvim" = {
      source = ./configs/text/nvim;
      recursive = true;
    };
    "skhd/skhdrc".source = ./configs/text/skhdrc;
    "yabai/yabairc".source = ./configs/text/yabairc;
  };
}
