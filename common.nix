{ config, pkgs, ... }:
{
  imports = import ./modules/module-list.nix;

  nix.extraOptions = "auto-optimise-store = true";

  i18n = {
    consoleKeyMap = pkgs.lib.mkForce "${pkgs.neomodmap}/share/keymaps/i386/neo/neo.map";
    consoleFont = "lat9w-16";
    defaultLocale = "de_DE.UTF-8";
  };

  networking.firewall = {
    enable = true;
    allowPing = true;
    allowedTCPPorts = [ 22 ];
  };

  services.openssh.enable = true;
  services.ntp.enable = true;

  programs = {
    ssh.startAgent = false;
    bash.enableCompletion = true;
    zsh.enable = true;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      packageOverrides = import ./pkgs;
    };
  };

  environment.shellAliases = { l = "ls -lah"; };
  environment.shells = [
    "${pkgs.bash}/bin/bash"
    "${pkgs.zsh}/bin/zsh"
  ];

  environment.systemPackages = with pkgs; [
    binutils
    coreutils
    psmisc
    lsof
    file
    wget
    gnupg1compat
    gitAndTools.gitFull
    curl
    tmux
    screen
    nmap
    htop
    iotop
    zip
    unzip
    zsh
    mc
    telnet
    jwhois
    cryptsetup
    pass
    mr
    vcsh
    rlwrap
    sqlite
    fdupes
    zile
    elinks
    w3m
    lynx
    storeBackup
    bind
    nix-prefetch-scripts
    markdown
    guile
    openssl
    which
    recutils
    tmuxinator
    direnv
    tree
  ];

  users.extraUsers.eike = {
    isNormalUser = true;
    name = "eike";
    group = "users";
    uid = 1000;
    createHome = true;
    home = "/home/eike";
    shell = "/run/current-system/sw/bin/zsh";
    extraGroups = [ "wheel" "audio" "messagebus" "systemd-journal" ];
  };
}
