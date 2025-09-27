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

  home.packages = with pkgs; [tree-sitter imagemagick qemu];

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
        background = "#2a7e94";
      };
    }
    else {};

  programs.neovim = {
    enable = true;
    package = neovim-nightly-overlay.packages.${pkgs.system}.default;
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
