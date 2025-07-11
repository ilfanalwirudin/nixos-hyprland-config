# 💫 https://github.com/JaKooLit 💫 #
# Packages and Fonts config including the "programs" options

{
  pkgs,
  inputs,
  options,
  lib,
  ...
}:
let

  python-packages = pkgs.python3.withPackages (
    ps: with ps; [
      requests
      pyquery # needed for hyprland-dots Weather script
    ]
  );

in
{

  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  #  time.timeZone = "Asia/Jakarta";
  #   services.automatic-timezoned.enable = true;
  networking.timeServers = options.networking.timeServers.default;
  services.ntp.enable = true;

  # Virt Manager
  #  programs.dconf.enable = true;
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "ilfarin" ];
  # virtualisation.libvirtd.enable = true;
  # virtualisation.spiceUSBRedirection.enable = true;
  #  users.users.ilfarin.extraGroups = [ "libvirtd" ];

  #Enable Cloudflare warp cli B

  systemd.packages = [ pkgs.cloudflare-warp ]; # for warp-cli
  systemd.targets.multi-user.wants = [ "warp-svc.service" ]; # causes warp-svc to be started automatically







  environment.systemPackages =
    (with pkgs; [
      # System Packages
      bc
      baobab
      btrfs-progs
      clang
      curl
      cpufrequtils
      duf
      eza
      ffmpeg
      ffmpegthumbnailer
      glib # for gsettings to work
      gsettings-qt
      git
      killall
      libappindicator
      libnotify
      openssl # required by Rainbow borders
      pciutils
     # vim
      wget
      xdg-user-dirs
      xdg-utils
      warp-terminal
      fastfetch
      (mpv.override { scripts = [ mpvScripts.mpris ]; }) # with tray
      ranger
      #inputs.nixvim.packages.x86_64-linux.default
      #  inputs.yazi.packages.${pkgs.system}.default

      #Personal stuff
      brave
      libsForQt5.dolphin
      ghostty
      inputs.zen-browser.packages."${system}".default # beta
      telegram-desktop
      discord
      cloudflare-warp
      cloudflared
      github-desktop
      flatpak
      distrobox
      vscode
      gparted

      virt-viewer
      spice
      spice-gtk
      spice-protocol
      win-virtio
      win-spice
      xfce.thunar-archive-plugin
      # gnome.adwaita-icon-theme
      p7zip
      google-chrome
      clockify
      obsidian

      #yazi-tutorial
      #yazi
      fzf
      zoxide
      jq
      poppler
      fd
      ripgrep
      imagemagick
      #neovim
      #code
      nodejs

      # Hyprland Stuff
      #(ags.overrideAttrs (oldAttrs: { inherit (oldAttrs) pname; version = "1.8.2"; }))
      ags # desktop overview
      btop
      brightnessctl # for brightness control
      cava
      cliphist
      loupe
      gnome-system-monitor
      grim
      gtk-engine-murrine # for gtk themes
      hypridle
      imagemagick
      inxi
      jq
      kitty
      libsForQt5.qtstyleplugin-kvantum # kvantum
      networkmanagerapplet
      nwg-displays
      nwg-look
      nvtopPackages.full
      pamixer
      pavucontrol
      playerctl
      polkit_gnome
      pyprland
      libsForQt5.qt5ct
      kdePackages.qt6ct
      kdePackages.qtwayland
      kdePackages.qtstyleplugin-kvantum # kvantum
      rofi-wayland
      slurp
      swappy
      swaynotificationcenter
      swww
      hypridle

      fd
      (pkgs.python3.withPackages (
        python-pkgs: with python-pkgs; [
          aubio
          pyaudio
          numpy
        ]
      ))
      inputs.quickshell.packages.x86_64-linux.default
      cava
      bluez
      ddcutil
      brightnessctl
      curl
      material-symbols

      unzip
      wallust
      wl-clipboard
      wlogout
      xarchiver
      yad
      yt-dlp

      ticktick
      ulauncher
      #waybar  # if wanted experimental next line
      #(pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];}))
    ])
    ++ [
      python-packages
    ];

  # FONTS
  fonts.packages = with pkgs; [
    noto-fonts
    fira-code
    noto-fonts-cjk-sans
    jetbrains-mono
    font-awesome
    terminus_font
    victor-mono
    # (nerdfonts.override {fonts = ["JetBrainsMono"];}) # stable banch
    # (nerdfonts.override {fonts = ["FantasqueSansMono"];}) # stable banch

    nerd-fonts.jetbrains-mono # unstable
    nerd-fonts.fira-code # unstable
    nerd-fonts.fantasque-sans-mono # unstable
  ];

  programs = {

    hyprland = {
      enable = true;
      #package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland; #hyprland-git
      #portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland; #xdph-git

      portalPackage = pkgs.xdg-desktop-portal-hyprland; # xdph none git
      xwayland.enable = true;
    };

    waybar.enable = true;
    hyprlock.enable = true;
    firefox.enable = true;
    git.enable = true;
    nm-applet.indicator = true;

    thunar.enable = true;
    thunar.plugins = with pkgs.xfce; [
      exo
      mousepad
      thunar-archive-plugin
      thunar-volman
      tumbler
    ];

    steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    #Neovim already use on flake

    #neovim = {
    #  enable = true;
    #  defaultEditor = true;
    #};


    xwayland.enable = true;

    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };




  nvf = {
    enable = true;
    settings = {

        vim.theme.enable = true;
        vim.theme.name = "gruvbox";
        vim.theme.style = "dark";


        vim.statusline.lualine.enable = true;
        vim.navigation.harpoon.enable = true;
        #vim.autocomplete.enableSharedCmpSources = true;
        

        #Languages
        vim.languages.ts.enable = true;
        vim.languages.nix.enable = true;
        vim.languages.rust.enable = true;
        
        #Autocomplete

      vim.autocomplete.nvim-cmp = {
      enable = true;

      sources = lib.mkForce {
        "nvim_lsp" = "[LSP]";
        "path" = "[Path]";
        "buffer" = "[Buffer]";
        "luasnip" = "[snippets]";
      };
    };

        #Clipboard
        
          vim.clipboard = {
            enable = true;
            providers.wl-copy.enable = true;
            registers = "unnamedplus";
          };

         vim.enableLuaLoader = true;

         #Options 

           vim = {
    globals = {
      mapleader = " ";
    };
    options = {
      # Numbering
      number = true;
      relativenumber = true;

      # Tab Settings
      tabstop = 2;
      softtabstop = 2;
      showtabline = 2;
      expandtab = true;

      # Indentation
      smartindent = true;
      shiftwidth = 2;
      breakindent = true;

      wrap = false;
    };
  };

        #Utility 



  vim.utility = {
    preview = {
      glow.enable = true;
      glow.mappings.openPreview = "<leader>mg";
      markdownPreview = {
        enable = true;
        alwaysAllowPreview = true;
        autoClose = true;
        autoStart = true;
      };
    };
    snacks-nvim.enable = true;

    images = {
      image-nvim = {
        enable = true;
        setupOpts = {
          backend = "kitty";
          editorOnlyRenderWhenFocused = false;
          integrations = {
            markdown = {
              enable = true;
              clearInInsertMode = true;
              downloadRemoteImages = true;
            };
          };
        };
      };
      img-clip.enable = true;
    };
  };




        #Keymap
  vim.keymaps = [
    {
      key = "<C-p>";
      mode = "n";
      silent = true;
      action = "<cmd>Telescope find_files<CR>";
      desc = "Find files wiht names";
    }
    {
      key = "<leader>fg";
      mode = "n";
      silent = true;
      action = "<cmd>Telescope live_grep<CR>";
      desc = "Find files with Contents FZF";
    }
    {
      key = "<C-n>";
      mode = "n";
      silent = true;
      action = "<cmd>Neotree filesystem reveal left<CR>";
      desc = "Show filesystem";
    }
    {
      key = "<C-m>";
      mode = "n";
      silent = true;
      action = "<cmd>Neotree close<CR>";
      desc = "Close filesystem";
    }
    {
      key = "<K>";
      mode = "n";
      silent = true;
      action = "<cmd>vim.lsp.buf.hover<CR>";
      desc = "Hover Documentation";
    }
    {
      key = "gd";
      mode = "n";
      silent = true;
      action = "<cmd>lua vim.lsp.buf.definition()<CR>";
      desc = "Go to Definition";
    }
    {
      key = "<leader>ca";
      mode = "n";
      silent = true;
      action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
      desc = "LSP Code Action (Normal)";
    }
    {
      key = "<leader>ca";
      mode = "v";
      silent = true;
      action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
      desc = "LSP Code Action (Visual)";
    }

  ];

        };

    };



















  };
  # End of program #


  # Manage the virtualisation services
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    #    spiceUSBRedirection.enable = true;
  };
  # services.spice-vdagentd.enable = true;

  # Extra Portal Configuration
  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
  };




















}
