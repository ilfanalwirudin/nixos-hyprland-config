# 💫 https://github.com/JaKooLit 💫 #
# Packages and Fonts config including the "programs" options

{ pkgs, inputs, options, ...}: let

  python-packages = pkgs.python3.withPackages (
    ps:
      with ps; [
        requests
        pyquery # needed for hyprland-dots Weather script
        ]
    );

  in {

  nixpkgs.config.allowUnfree = true;
  

 
  # Set your time zone.
#  time.timeZone = "Asia/Jakarta";
#   services.automatic-timezoned.enable = true;
   networking.timeServers = options.networking.timeServers.default;
   services.ntp.enable = true;



# Virt Manager
#  programs.dconf.enable = true;
 programs.virt-manager.enable = true;
 users.groups.libvirtd.members = ["ilfarin"];
# virtualisation.libvirtd.enable = true;
# virtualisation.spiceUSBRedirection.enable = true;
#  users.users.ilfarin.extraGroups = [ "libvirtd" ];


 #Enable Cloudflare warp cli B

  systemd.packages = [ pkgs.cloudflare-warp ]; # for warp-cli
  systemd.targets.multi-user.wants = [ "warp-svc.service" ]; # causes warp-svc to be started automatically
  
  environment.systemPackages = (with pkgs; [
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
    glib #for gsettings to work
    gsettings-qt
    git
    killall  
    libappindicator
    libnotify
    openssl #required by Rainbow borders
    pciutils
    vim
    wget
    xdg-user-dirs
    xdg-utils

    fastfetch
    (mpv.override {scripts = [mpvScripts.mpris];}) # with tray
    ranger
    inputs.nixvim.packages.x86_64-linux.default
   

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
    spice spice-gtk
    spice-protocol
    win-virtio
    win-spice
    xfce.thunar-archive-plugin
   # gnome.adwaita-icon-theme
    p7zip
    yazi
 
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
    gtk-engine-murrine #for gtk themes
    hypridle
    imagemagick 
    inxi
    jq
    kitty
    libsForQt5.qtstyleplugin-kvantum #kvantum
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
    kdePackages.qtstyleplugin-kvantum #kvantum
    rofi-wayland
    slurp
    swappy
    swaynotificationcenter
    swww
    unzip
    wallust
    wl-clipboard
    wlogout
    xarchiver
    yad
    yt-dlp

    #waybar  # if wanted experimental next line
    #(pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];}))
  ]) ++ [
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
    nerd-fonts.fantasque-sans-mono #unstable
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
    #neovim.enable = true;

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

#Neovim

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
	
  };


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
