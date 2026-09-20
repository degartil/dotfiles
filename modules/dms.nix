{ pkgs, ... }:
let
  settings = {

    currentThemeName = "dynamic";
    currentThemeCategory = "dynamic";
    clockFormat = "24h";

    controlCenterShowMicPercent = true;

    controlCenterWidgets = [
      {
        id = "volumeSlider";
        enabled = true;
        width = 50;
      }
      {
        id = "brightnessSlider";
        enabled = true;
        width = 50;
      }
      {
        id = "inputVolumeSlider";
        enabled = true;
        width = 50;
      }
      {
        id = "wifi";
        enabled = true;
        width = 50;
      }
      {
        id = "bluetooth";
        enabled = true;
        width = 50;
      }
      {
        id = "audioOutput";
        enabled = true;
        width = 50;
      }
      {
        id = "audioInput";
        enabled = true;
        width = 50;
      }
      {
        id = "nightMode";
        enabled = true;
        width = 50;
      }
      {
        id = "darkMode";
        enabled = true;
        width = 50;
      }
      {
        id = "doNotDisturb";
        enabled = true;
        width = 50;
      }
    ];

    showWorkspaceName = true;
    showWorkspacePadding = true;
    showOccupiedWorkspacesOnly = true;

    mediaUseAlbumArtAccent = true;

    appDrawerSectionViewModes = {
      apps = "list";
    };

    niriOverviewLauncherStyle = "spotlight";
    launcherUseOverlayLayer = true;
    launcherStyle = "island";
    spotlightBarShowModeChips = true;
    useAutoLocation = true;

    iconThemeDark = "Colloid-Dark";
    iconThemeLight = "Colloid-Light";
    iconThemePerMode = true;

    launcherLogoMode = "os";
    launcherLogoColorOverride = "primary";
    launcherLogoSizeOffset = 9;

    textRenderType = 1;

    notificationSummaryFontSize = 10;
    notificationBodyFontSize = 10;

    notepadShowLineNumbers = true;
    notepadUseCompositorGap = true;

    soundLogin = true;
    acMonitorTimeout = 600;
    acProfileName = "0";
    acPostLockMonitorTimeout = 60;
    lockBeforeSuspend = true;
    batteryCriticalThreshold = 20;
    batteryLowThreshold = 30;
    batteryNotifyLow = true;

    muxType = "zellij";

    notificationOverlayEnabled = true;
    notificationCompactMode = true;
    notificationShowTimeoutBar = true;

    osdAlwaysShowValue = true;
    osdPowerProfileEnabled = true;

    powerMenuActions = [
      "reboot"
      "logout"
      "poweroff"
      "lock"
      "suspend"
    ];
    powerMenuDefaultAction = "suspend";
    powerMenuGridLayout = true;
    screenPreferences = {
      wallpaper = [ "all" ];
    };

    barConfigs = [
      {
        id = "default";
        name = "Main Bar";
        enabled = true;

        position = 2;

        screenPreferences = [ "all" ];
        showOnLastDisplay = true;

        leftWidgets = [
          {
            id = "workspaceSwitcher";
            enabled = true;
          }
          {
            id = "privacyIndicator";
            enabled = true;
          }
          {
            id = "launcherButton";
            enabled = true;
          }
        ];

        centerWidgets = [
          {
            id = "launcherButton";
            enabled = true;
          }
          {
            id = "music";
            enabled = true;
          }
          {
            id = "clock";
            enabled = true;
          }
          {
            id = "weather";
            enabled = true;
          }
        ];

        rightWidgets = [
          {
            id = "systemTray";
            enabled = true;
          }
          {
            id = "clipboard";
            enabled = true;
          }
          {
            id = "battery";
            enabled = true;
          }
          {
            id = "controlCenterButton";
            enabled = true;
          }
        ];

        spacing = 4;
        innerPadding = 4;

        barInsetPadding = -1;
        barLengthPadding = 0;
        bottomGap = 0;

        attachToScreenEdge = false;

        transparency = 1;
        widgetTransparency = 1;

        squareCorners = false;
        noBackground = false;

        batteryColorMode = "theme";

        gothCornersEnabled = true;
        gothCornerRadiusOverride = false;
        gothCornerRadiusValue = 12;

        widgetOutlineEnabled = false;

        fontScale = 1;
        iconScale = 1;

        autoHide = false;

        showOnWindowsOpen = true;
        openOnOverview = true;

        visible = true;

        popupGapsAuto = true;
        popupGapsManual = 4;

        maximizeDetection = true;
        useOverlayLayer = false;

        scrollEnabled = true;
        scrollXBehavior = "column";
        scrollYBehavior = "workspace";

        shadowIntensity = 0;

        hoverPopouts = true;
        hoverPopoutDelay = 150;

        island = true;

        islandFloating = false;
        islandHomeCompactTight = false;
        islandHomeLayout = [
          {
            id = "media";
            enabled = true;
          }
          {
            id = "clock";
            enabled = true;
          }
          {
            id = "weather";
            enabled = false;
          }
          {
            id = "status";
            enabled = false;
          }
          {
            id = "volume";
            enabled = false;
          }
          {
            id = "brightness";
            enabled = false;
          }
          {
            id = "notifications";
            enabled = true;
          }
        ];
        islandSatelliteBackground = true;
        islandSatellitesEnabled = true;
        islandSatellitePosition = "edges";
        islandNotificationExpand = true;
        islandHighContrast = false;
        islandCornerRadius = 38;
        islandBatteryStyle = "solid";
        islandSatelliteTransparency = 1;
        islandInteractionMode = "hybrid";
        islandHoverOpenDelay = 150;
        islandHoverCloseDelay = 150;
        islandMediaClockVisible = true;
        islandPalette = "default";
        islandReserveThickness = 40;
        islandAlongOffset = 0;
        islandHomeClockDisplay = "time";
        islandSatelliteSwoopRadius = 15;
        islandSatelliteGothCorners = true;
        islandCompactThickness = 35;
        islandOuterGap = 4;
      }
    ];

    builtInPluginSettings = {
      dms_settings_search.trigger = "?";
      dms_clipboard_search.trigger = "cb";
      dms_power.trigger = "pw";
      dms_qr_generator.trigger = "qrg";
    };

    launcherPluginVisibility = {
      dms_settings_search.allowWithoutTrigger = false;
    };

    configVersion = 18;
  };
in
{
  xdg.configFile."DankMaterialShell/settings.json".text = builtins.toJSON settings;
}
