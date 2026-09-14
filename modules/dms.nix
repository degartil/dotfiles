{ pkgs, ... }:
let
  settings = {

    currentThemeName = "dynamic";
    currentThemeCategory = "dynamic";

    controlCenterShowMicPercent = true;

    showWorkspaceName = true;
    showWorkspacePadding = true;
    showOccupiedWorkspacesOnly = true;

    mediaUseAlbumArtAccent = true;

    appDrawerSectionViewModes = {
      apps = "list";
    };

    launcherUseOverlayLayer = true;
    spotlightBarShowModeChips = true;

    launcherLogoMode = "os";
    launcherLogoColorOverride = "primary";

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
            id = "launcherButton";
            enabled = true;
          }
          {
            id = "privacyIndicator";
            enabled = true;
          }
        ];

        centerWidgets = [
          {
            id = "workspaceSwitcher";
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
            id = "notificationButton";
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

        autoHide = true;
        autoHideDelay = 250;

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

        island = false;
      }
    ];

    builtInPluginSettings = {
      dms_settings_search.trigger = "?";
      dms_clipboard_search.trigger = "cb";
      dms_power.trigger = "pw";
      dms_qr_generator.trigger = "qrg";
    };

    configVersion = 18;
  };
in
{
  xdg.configFile."DankMaterialShell/settings.json".text = builtins.toJSON settings;
}
