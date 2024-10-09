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
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices."luks-537fc36d-adea-41da-8140-40ba1c5402a4".device = "/dev/disk/by-uuid/537fc36d-adea-41da-8140-40ba1c5402a4";

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";
services.xserver.windowManager.dwm.enable = true;
services.xserver.enable = true;
hardware.pulseaudio.enable = true;
hardware.pulseaudio.support32Bit = true;
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "dvorak";
 
};
#services.xserver.deviceSection = ''Option "TearFree" "true"'';
services.picom = {
    enable = true;
    vSync = true;
  };
#nixpkgs.config = {
#  st.conf = builtins.readFile /home/anon/Downloads/config.def.h;
#};




services.xserver.windowManager.dwm.package = pkgs.dwm.override {
    # Or alternatively `conf = ./config.def.h;`
    conf = /home/anon/Downloads/config.dwm.h;
    patches= [
    /home/anon/Downloads/dwmgap.diff
];
  };
programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
}; 
  # Configure console keymap
  console.keyMap = "dvorak";
services.mullvad-vpn.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.anon = {
    isNormalUser = true;
    description = "anon";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
hardware.openrazer.enable = true;
hardware.openrazer.users = ["anon"];
services.printing.enable = true;
services.avahi = {
  enable = true;
  nssmdns = true;
  openFirewall = true;
};
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
 
    hunspell
    hunspellDicts.en_US
calibre
polychromatic
netflix
openrazer-daemon
razergenie
moc
feh
vim
brave
nicotine-plus
tauon
dmenu
kitty
wireguard-tools
qbittorrent
vlc
pavucontrol
git
tmux
neofetch
xfce.thunar
libreoffice
gparted
discord
etcher
polkit
polkit_gnome
spotify
chromium
# (pkgs.st.override {
#    patches = [
 #   /home/anon/Downloads/st-scrollback-0.8.5.diff
 #    /home/anon/Downloads/st-scrollback-reflow-0.9.diff
 #     /home/anon/Downloads/st-scrollback-mouse-20220127-2c5edf2.diff
 #     /home/anon/Downloads/st-scrollback-mouse-altscreen-20200416-5703aa0.diff
#];
#conf =  /home/anon/Downloads/config.def.h;   
#}) 
];
nixpkgs.config.permittedInsecurePackages = [
                "electron-19.1.9"
              ];
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
  system.stateVersion = "23.11"; # Did you read the comment?

}
