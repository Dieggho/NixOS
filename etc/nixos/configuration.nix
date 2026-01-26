{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.initrd.systemd.enable = true;
  boot.plymouth.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # Hardening
  boot.kernel.sysctl = {
  "kernel.randomize_va_space" = 2;
  "vm.mmap_rnd_bits" = 32;
  "vm.mmap_rnd_compat_bits" = 16;
  };

  nixpkgs.config.hardening = {
  enable = true;
  pie = true;
  relro = "full";
  now = true;
  stackprotector = true;
  fortify = true;
  };

  security.apparmor.enable = true;

  # Enable Wifi
  networking.hostName = "t480"; # Define your hostname.
  networking.wireless.iwd.enable = true;
 
  # You can choose your kernel simply by setting the boot.kernelPackages option 
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  # ThinkPad battery + power
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_BAT="powersave";
      CPU_SCALING_GOVERNOR_ON_AC="performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT="power";
      CPU_ENERGY_PERF_POLICY_ON_AC="performance";
      PLATFORM_PROFILE_ON_BAT="low-power";
      PLATFORM_PROFILE_ON_AC="performance";
    };
  };

  # No X11
  services.xserver.enable = false;

  # Enable Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

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

  # Enable services
  services.seatd.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
       command = "${pkgs.cage}/bin/cage -d -s -- gtkgreet -b /home/void/.local/share/Wallpapers/000-NixOS.png";
       user = "void";
      };
    };
  };

  environment.etc."greetd/environments".text = ''
    Hyprland
  '';

   services.logind.settings.Login = {
   HandleLidSwitchExternalPower = "ignore";
   HandleLidSwitch = "ignore";
   KillUserProcesses = false;
   };

  zramSwap.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.void = {
    isNormalUser = true;
    description = "void";
    extraGroups = [ "wheel" "video" "audio" "storage" "optical" "input" "seat" ];
    packages = with pkgs; [
     # No user packs for now
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable doas instead of sudo
   security.doas.enable = true;
   security.sudo.enable = false;
   security.polkit.enable = true;

  # Configure doas
   security.doas.extraRules = [{
  	users = [ "void" ];
  	keepEnv = true;
        persist = true;
  }];

  # Enable packages
  programs.udevil.enable = true;
  programs.waybar.enable = true;
  programs.hyprlock.enable = true;  
  programs.hyprland = {
    enable = true;
  }; 

  # Default shell
  users.defaultUserShell = pkgs.mksh;
  
  # Dash as sh
  environment.binsh = "${pkgs.dash}/bin/dash";
 
  # Intel configuration
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vpl-gpu-rt
    ];
  };

  # Remove defalt packages
  programs.nano.enable = false;
  programs.xwayland.enable = false;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
  nvi
  dash
  iwgtk
  cage
  pragha
  brave 
  ffmpeg-full
  mako
  fastfetch
  gimp3
  transmission_4
  hyprlandPlugins.hyprbars
  adwaita-icon-theme
  flat-remix-icon-theme
  nwg-look
  swww
  gsimplecal
  gtkgreet
  glib
  wofi
  foot
  wf-recorder
  hyprpicker
  libnotify
  simple-mtpfs
  dconf-editor
  galculator
  lxtask
  imv
  grim
  slurp
  gucharmap
  unzip
  p7zip
  pavucontrol
  pcmanfm
  ffmpegthumbnailer
  python3
  waytrogen
  kotatogram-desktop
  ];

  # Set session environment
  environment.sessionVariables = rec {
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";
    LIBVA_DRIVER_NAME = "iHD";
    # Not officially in the specification
    XDG_BIN_HOME    = "$HOME/.local/bin";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
    PATH = "$PATH:${XDG_BIN_HOME}";
  };
 
  # Unbloat system
  nix.optimise.automatic = true;

  nix.settings = {
    auto-optimise-store = true;
    warn-dirty = false;
    experimental-features = [ "nix-command" "flakes" ];
  };

  services.avahi.enable = false;
  services.printing.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

  system.stateVersion = "25.11"; # Did you read the comment?
}
