Plugin.Defaults = {};

Plugin.Defaults.PluginVersion = Plugin:GetVersion();

Plugin.Defaults.Locale = {
    Index = 1,
    Short = "EN",
};

Plugin.Defaults.Flags = {
    FirstLaunch = true;
    SimulateAcceleration = false;
    AnyDist = false;
};


Plugin.Defaults.UI = {};
Plugin.Defaults.UI.DefaultBorderWidth = 2;
Plugin.Defaults.UI.ElementsDefaultMargin = 5;
Plugin.Defaults.UI.WindowEdgeMargin = 20;
Plugin.Defaults.UI.DefaultFontColor = Turbine.UI.Color(220/255, 220/255, 1);
Plugin.Defaults.UI.DefaultBorderColor = Turbine.UI.Color(1, 0.2, 0.2, 0.3);
Plugin.Defaults.UI.WindowDefaultBackground = Turbine.UI.Color(0.94,0,0,0.02);

Plugin.Defaults.UI.MainWindow = {};
Plugin.Defaults.UI.MainWindow.Toggle = {};
Plugin.Defaults.UI.MainWindow.Toggle.Height = 48;
Plugin.Defaults.UI.MainWindow.Toggle.Width = 48;
Plugin.Defaults.UI.MainWindow.Toggle.xPos = Framework.Const.SCREEN_WIDTH - Plugin.Defaults.UI.MainWindow.Toggle.Width;
Plugin.Defaults.UI.MainWindow.Toggle.yPos = Framework.Const.SCREEN_HEIGHT - Plugin.Defaults.UI.MainWindow.Toggle.Height;
Plugin.Defaults.UI.MainWindow.Height = 600;
Plugin.Defaults.UI.MainWindow.Width = 800;
Plugin.Defaults.UI.MainWindow.xPos = Framework.Const.SCREEN_WIDTH/2 - Plugin.Defaults.UI.MainWindow.Width/2;
Plugin.Defaults.UI.MainWindow.yPos = Framework.Const.SCREEN_HEIGHT/2 - Plugin.Defaults.UI.MainWindow.Height/2;
Plugin.Defaults.UI.MainWindow.HeaderHeight = 32;
Plugin.Defaults.UI.MainWindow.HeaderFakeHeight = Plugin.Defaults.UI.MainWindow.HeaderHeight - Plugin.Defaults.UI.DefaultBorderWidth + Plugin.Defaults.UI.WindowEdgeMargin;
Plugin.Defaults.UI.MainWindow.PageHeight = 570;
Plugin.Defaults.UI.MainWindow.PageContentHeight = Plugin.Defaults.UI.MainWindow.PageHeight - Plugin.Defaults.UI.WindowEdgeMargin * 2;
Plugin.Defaults.UI.MainWindow.PageContentWidth = Plugin.Defaults.UI.MainWindow.Width - Plugin.Defaults.UI.WindowEdgeMargin * 2;

Plugin.Defaults.UI.MainWindow.GroupContainer = {};
Plugin.Defaults.UI.MainWindow.GroupContainer.PlayerSlot = {};
Plugin.Defaults.UI.MainWindow.GroupContainer.PlayerSlot.Height = 75;
Plugin.Defaults.UI.MainWindow.GroupContainer.PlayerSlot.Width = 250;
Plugin.Defaults.UI.MainWindow.GroupContainer.Height = 6 * Plugin.Defaults.UI.MainWindow.GroupContainer.PlayerSlot.Height + 5 * Plugin.Defaults.UI.ElementsDefaultMargin;
Plugin.Defaults.UI.MainWindow.GroupContainer.Width = Plugin.Defaults.UI.MainWindow.GroupContainer.PlayerSlot.Width;

Plugin.Defaults.UI.MainWindow.DeedContainer = {};
Plugin.Defaults.UI.MainWindow.DeedContainer.Height = Plugin.Defaults.UI.MainWindow.GroupContainer.Height;
Plugin.Defaults.UI.MainWindow.DeedContainer.Width = Plugin.Defaults.UI.MainWindow.PageContentWidth - Plugin.Defaults.UI.MainWindow.GroupContainer.Width - Plugin.Defaults.UI.ElementsDefaultMargin;
Plugin.Defaults.UI.MainWindow.DeedContainer.xPos = Plugin.Defaults.UI.MainWindow.GroupContainer.Width + Plugin.Defaults.UI.ElementsDefaultMargin;
Plugin.Defaults.UI.MainWindow.DeedContainer.yPos = Plugin.Defaults.UI.MainWindow.GroupContainer.yPos;
Plugin.Defaults.UI.MainWindow.DeedContainer.DeedSlot = {};
Plugin.Defaults.UI.MainWindow.DeedContainer.DeedSlot.Height = Plugin.Defaults.UI.MainWindow.GroupContainer.PlayerSlot.Height;
Plugin.Defaults.UI.MainWindow.DeedContainer.DeedSlot.Width = Plugin.Defaults.UI.MainWindow.DeedContainer.Width;

Plugin.Defaults.UI.MainWindow.Page1Footer = {};
Plugin.Defaults.UI.MainWindow.Page1Footer.ControlsWidth = (Plugin.Defaults.UI.MainWindow.PageContentWidth - Plugin.Defaults.UI.ElementsDefaultMargin * 2) / 3;
Plugin.Defaults.UI.MainWindow.Page1Footer.ControlsHeight = Plugin.Defaults.UI.MainWindow.PageContentHeight - Plugin.Defaults.UI.MainWindow.GroupContainer.Height - Plugin.Defaults.UI.ElementsDefaultMargin;
Plugin.Defaults.UI.MainWindow.Page1Footer.ControlsYPos = Plugin.Defaults.UI.MainWindow.GroupContainer.Height + Plugin.Defaults.UI.ElementsDefaultMargin;


Plugin.Defaults.UI.AlertsWindow = {};
Plugin.Defaults.UI.AlertsWindow.Enabled = true;
Plugin.Defaults.UI.AlertsWindow.Height = 160;
Plugin.Defaults.UI.AlertsWindow.Width = 600;
Plugin.Defaults.UI.AlertsWindow.xPos = (Framework.Const.SCREEN_WIDTH - Plugin.Defaults.UI.AlertsWindow.Width) / 2;
Plugin.Defaults.UI.AlertsWindow.yPos = (Framework.Const.SCREEN_HEIGHT - Plugin.Defaults.UI.AlertsWindow.Height) / 2 - 200;
Plugin.Defaults.UI.AlertsWindow.BackgroundOpacity = 0.6;
Plugin.Defaults.UI.AlertsWindow.Font = 49;
Plugin.Defaults.UI.AlertsWindow.TextRed = 0.1;
Plugin.Defaults.UI.AlertsWindow.TextGreen = 1.0;
Plugin.Defaults.UI.AlertsWindow.TextBlue = 0.1;
Plugin.Defaults.UI.AlertsWindow.TextAlpha = 1.0;