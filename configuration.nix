{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];


    ##################################
    nixpkgs.config.allowUnfree = true;
    ##################################
    boot.loader.grub.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.grub.useOSProber = true;
    boot.loader.efi.efiSysMountPoint = "/boot";
    boot.loader.grub.efiSupport = true;
    boot.loader.grub.device = "nodev";
    ##################################
    boot.kernelPackages = pkgs.linuxPackages_zen;
    ##################################
    networking.hostName = "NixOS";
    ##################################
    networking.networkmanager.enable = true;
    hardware.bluetooth.enable = true;
    services.libinput.enable = true;
    ##################################
    time.timeZone = "Europe/Kyiv";
    ##################################
    i18n = {
      defaultLocale = "uk_UA.UTF-8";
      extraLocales = [ ];
           };
    console = {
    font = "cyr-sun16";
    useXkbConfig = true;
    };
    ##################################
    users.users.pc = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
    tree
      ];
    };
    ##################################
    #xdg.portal.enable = true;
    #xdg.portal.extraPortals = [
    #pkgs.xdg-desktop-portal-hyprland ];
    #services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;
    #services.displayManager.defaultSession = "hyprland";
    services.desktopManager.plasma6.enable = true;
    services.power-profiles-daemon.enable = false;
    services.auto-cpufreq.enable = true;
    services.flatpak.enable = true;
    #services.blueman.enable = true;
    hardware.graphics.enable = true;
    #services.zerotierone.enable = true;
    security.rtkit.enable = true;
    services.fstrim.enable = true;
    services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    jack.enable = true;
    };
    #################################
    programs.gamemode.enable = true;
    programs.starship.enable = true;
    #programs.hyprland.enable = true;
    programs.firefox.enable = true;
    programs.fish.enable = true;
    programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi
      obs-gstreamer
      obs-vkcapture
    ];
    };
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
    #################################
    environment.systemPackages = with pkgs; [
    #fuse
    nwg-look # GTK Settings
    #kitty
    gparted
    starship
    #kdePackages.sddm-kcm
    #swaynotificationcenter
    #wofi
    #xed-editor
    #swww
    dosfstools
    #mpvpaper
    #waypaper
    #hypridle
    #nmgui
    #hyprlock
    #kdePackages.dolphin
    #wlogout
    #nautilus
    #waybar
    #glava # Аудиовизуализатор
    protonup-qt # Программа для загрузки версий Wine/Proton для Steam
    #jetbrains-mono # Шрифт
    mpv # Видеопроигрователь
    qbittorrent # Клиент для загрузки torrent файлов
    fastfetch # Утилита для показа системной информации в терминале
    #power-profiles-daemon # Демон для управления режимом питания ноутбука
    #unzip # Утилита для извлечения zip
    unrar
    #p7zip # Утилита для извлечения 7zip
    xdg-user-dirs # Утилита для управления папками пользователя
    #brightnessctl # Утилита для управления яркостью экрана
    #pavucontrol # Утилита для управления звуком
    #playerctl # Демон для управления медиа (его переключением)
    #networkmanagerapplet # Графический апплет для NetworkManager
    ayugram-desktop #  Мессенджер
    audacious # Аудиопроигрователь
    neovim # Консольный текстовый редактор
    btop # Терминальный системный монитор
    git
    #hyprshot
    wget
    curl
    steam-run
    #(python3.withPackages (ps: with ps; [ python-telegram-bot requests telethon aiohttp ]))
    krita
    #usbutils
    #samrewritten
    bazaar
    kdePackages.qtstyleplugin-kvantum
    #wofi
    #chromium
    #pcmanf
    #waybar
    #mission-center
    #kooha
    #dialect
    #gnome-tweaks
    #upscaler
    #wineWowPackages.stable
    #cinnamon-translations
    #xfce.mousepad
    #networkmanagerapplet
    #blueman
    #gparted
    lm_sensors
    pciutils
    kdePackages.kcalc
    #cmake
    #ninja
    #scrcpy
    #gnumake
    #gettext
    #pkg-config
    #extra-cmake-modules
    #gcc
    #android-tools
    #kdePackages.qtbase
    #kdePackages.kdeplasma-addons
    ];
    ##################################
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      discover
      okular
      elisa
    ];
    fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    jetbrains-mono
    ];
    ##################################
    boot.kernelParams = [
    "amd_pstate=active"
    "amdgpu.ppfeaturemask=0xffffffff"
    "amdgpu.dc=1"
    "amdgpu.gpu_recovery=1"
    "amdgpu.runpm=0"
    "nvme_core.default_ps_max_latency_us=0"
    "clocksource=tsc"
    "tsc=reliable"
    "nohz=on"
    "nowatchdog"
    ];
    ##################################
    boot.kernel.sysctl = {
    "kernel.sched_latency_ns" = 6000000;
    "kernel.sched_min_granularity_ns" = 750000;
    "kernel.sched_wakeup_granularity_ns" = 1000000;
    "kernel.sched_autogroup_enabled" = 1;
    "vm.swappiness" = 10;
    "vm.vfs_cache_pressure" = 50;
    "vm.dirty_ratio" = 10;
    "vm.dirty_background_ratio" = 5;
    };
    ##################################
    zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
    };
    ##################################
    environment.variables = {
    RADV_PERFTEST = "aco";
    MESA_GLTHREAD = "true";
    mesa_glthread = "true";
    AMD_VULKAN_ICD = "RADV";
    __GL_THREADED_OPTIMIZATIONS = "1";
    };
    ###################################
    users.defaultUserShell = pkgs.fish;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    ###################################
    system.stateVersion = "25.11";
    ###################################
    }


