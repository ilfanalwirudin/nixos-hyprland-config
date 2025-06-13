# 💫 https://github.com/JaKooLit 💫 #
# Users - NOTE: Packages defined on this will be on current user only

{
  pkgs,
  username,
  lib,
  ...
}:

let
  inherit (import ./variables.nix) gitUsername;
in
{
  users = {
    mutableUsers = true;
    users."${username}" = {
      homeMode = "755";
      isNormalUser = true;
      description = "${gitUsername}";
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "scanner"
        "lp"
        "video"
        "input"
        "audio"
      ];

      # define user packages here
      packages = with pkgs; [
      ];
    };

    defaultUserShell = pkgs.zsh;
  };

  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = with pkgs; [ fzf ];

  virtualisation.docker = {
    enable = true;
    # Set up resource limits
    daemon.settings = {
      experimental = true;
      default-address-pools = [
        {
          base = "172.30.0.0/16";
          size = 24;
        }
      ];
    };
  };

  programs = {

    #Yazi Configuration

    yazi = {
      enable = true;
      settings = {
        yazi = {

          manager = {
            ratio = [
              1
              4
              3
            ];
            sort_by = "natural";
            sort_sensitive = true;
            sort_reverse = false;
            sort_dir_first = true;
            linemode = "none";
            show_hidden = false;
            show_symlink = true;
          };
        };

      };
    };

    # Zsh configuration
    zsh = {
      enable = true;
      enableCompletion = true;
      ohMyZsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "funky";
      };

      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      promptInit = ''
                fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc
                
                #pokemon colorscripts like. Make sure to install krabby package
                #krabby random --no-mega --no-gmax --no-regional --no-title -s; 
                
                source <(fzf --zsh);
                HISTFILE=~/.zsh_history;
                HISTSIZE=10000;
                SAVEHIST=10000;
                setopt appendhistory;


                #Yazi setup
                 function y() {
        	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        	yazi "$@" --cwd-file="$tmp"
        	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        		builtin cd -- "$cwd"
        	fi
        	rm -f -- "$tmp"
                }
                
                export EDITOR=nvim

      '';
    };
  };
}
