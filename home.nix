{ config, pkgs, inputs,... }:

{
  home.username = "yourusername";
  home.homeDirectory = "/home/yourusername";

  imports = [
    inputs.dms.homeModules.dank-material-shell
  ];

  # Dank Material Shell Setup
  programs.dank-material-shell = {
    enable = true;
    # Enables dynamic wallpaper colors, system monitoring, and widgets 
    enableSystemMonitoring = true; 
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    dgop.package = inputs.dgop.packages.${pkgs.system}.default; [1]
    
    # Hyprland specific integration
    systemd.enable = true; [1]
  };

  # Hyprland Compositor configuration
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # Auto-start DMS on Hyprland launch
      exec-once = "dms run";
      
      # Explicit sync fallback (leave alone unless experiencing tearing)
      # render:explicit_sync = 1;
    };
  };

  # Polyglot Environment Manager
  programs.mise = {
    enable = true;
    enableBashIntegration = true; [5]
    globalConfig = {
      tools = {
        node = "lts";
        python = "3.12";
      };
    };
  };

  # Modern Linux Toolchain
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      # Note: Treesitter parsers would be configured via extraWrapperArgs here
    };
    
    zoxide = {
      enable = true;
      enableBashIntegration = true;
    };

    eza = {
      enable = true;
      enableAliases = true;
      icons = true;
      git = true;
    };

    zellij = {
      enable = true;
    };
    
    ripgrep.enable = true;
  };

  home.stateVersion = "24.05";
}