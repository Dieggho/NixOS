# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.initrd.systemd.enable = true;
  boot.plymouth.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "t480"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;


  # Enable nix-command and flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];  

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Enable services
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
       command = "${pkgs.cage}/bin/cage -d -s -- gtkgreet -b /home/void/.local/share/backgrounds/nixos.png";
       user = "void";
      };
    };
  };

  environment.etc."greetd/environments".text = ''
    HYPRLAND
  '';

  services.logind.lidSwitchExternalPower = "ignore";
  sound.enable = true;
  zramSwap.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.void = {
    isNormalUser = true;
    description = "void";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "storage" "optical" "input"];
    packages = with pkgs; [
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable doas instead of sudo
  security.doas.enable = true;
  security.sudo.enable = false;

  # Configure doas
  security.doas.extraRules = [{
	users = [ "void" ];
	keepEnv = true;
        persist = true;
  }];

  # Enable packages
  programs.firefox.enable = true;
  programs.udevil.enable = true;
  programs.waybar.enable = true;
  programs.regreet.enable = true;

  programs.hyprland = {
  enable = true;
  xwayland.enable = false;
  }; 

  # Default shell
  users.defaultUserShell = pkgs.mksh;

  # Intel configuration
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  alsa-utils
  cage
  dunst
  deadbeef
  wbg
  greetd.gtkgreet
  wofi
  foot
  wf-recorder
  hyprpicker
  libnotify
  simple-mtpfs
  gnome.dconf-editor
  galculator
  lxtask
  imv
  grim
  slurp
  gucharmap
  ffmpeg-full
  pinta
  transmission
  telegram-desktop
  unzip
  p7zip
  dash
  pcmanfm
  python3
  plymouth
  swaylock
  ];

  # Set session environment
  environment.sessionVariables = rec {
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";

    # Not officially in the specification
    XDG_BIN_HOME    = "$HOME/.local/bin";
    PATH = [ 
      "${XDG_BIN_HOME}"
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}

# Edit this configuration file to define what should be installed on
