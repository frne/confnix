{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hw-shang.nix
      ../../common-desktop.nix
    ];

  boot.loader = {
    gummiboot.enable = true;
    gummiboot.timeout = 5;
    efi.canTouchEfiVariables = true;
    #boot.kernelPackages = pkgs.linuxPackages_4_0;
  };

  boot.initrd.kernelModules = [ "nouveau" "fbcon" ];

  networking = {
    hostName = "shang";
    hostId = "b43f128a";
    wireless = {
      enable = false;
    };
    useDHCP = true;
    wicd.enable = false;
    firewall = {
      allowedTCPPorts = [ 8080 ];
    };

#    nat = {
#      enable = true;
#      externalInterface = "enp3s0";
#      internalInterfaces = [ "ve-+" ];
#    };
  };

  # Enable the X11 windowing system.
  services.xserver = {
    videoDrivers = [ "nouveau" ];
  };

  services.postgresql = {
    enable = true;
    #dataDir = "/data/postgresql/data-9.4";
    package = pkgs.postgresql94;
  };

  environment.pathsToLink = [ "/" ];

  hardware = {
    enableAllFirmware = true;
    bluetooth.enable = false;
    cpu.intel.updateMicrocode = true;  #needs unfree
    opengl.driSupport32Bit = true;
  };

}
