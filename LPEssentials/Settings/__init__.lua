Plugin.Settings = {};

Plugin.Settings.Locale = {
    Index = 1,
    Short = "EN",
};

Plugin.Settings.Flags = {
    FirstLaunch = true;
    SimulateAcceleration = false;
    AnyDist = false;
};


Plugin.Settings.UI = {};
Plugin.Settings.UI.DefaultBorderWidth = 2;
Plugin.Settings.UI.ElementsDefaultMargin = 5;
Plugin.Settings.UI.WindowEdgeMargin = 20;
Plugin.Settings.UI.DefaultBorderColor = Turbine.UI.Color(1, 0.2, 0.2, 0.3);
Plugin.Settings.UI.WindowDefaultBackground = Turbine.UI.Color(0.94,0,0,0.02);

Plugin.Settings.UI.MainWindow = {};
Plugin.Settings.UI.MainWindow.Toggle = {};
Plugin.Settings.UI.MainWindow.Toggle.Height = 48;
Plugin.Settings.UI.MainWindow.Toggle.Width = 48;
Plugin.Settings.UI.MainWindow.Toggle.xPos = Framework.Const.SCREEN_WIDTH - Plugin.Settings.UI.MainWindow.Toggle.Width;
Plugin.Settings.UI.MainWindow.Toggle.yPos = Framework.Const.SCREEN_HEIGHT - Plugin.Settings.UI.MainWindow.Toggle.Height;
Plugin.Settings.UI.MainWindow.Height = 600;
Plugin.Settings.UI.MainWindow.Width = 800;
Plugin.Settings.UI.MainWindow.xPos = Framework.Const.SCREEN_WIDTH/2 - Plugin.Settings.UI.MainWindow.Width/2;
Plugin.Settings.UI.MainWindow.yPos = Framework.Const.SCREEN_HEIGHT/2 - Plugin.Settings.UI.MainWindow.Height/2;
Plugin.Settings.UI.MainWindow.HeaderHeight = 32;
Plugin.Settings.UI.MainWindow.HeaderFakeHeight = Plugin.Settings.UI.MainWindow.HeaderHeight - Plugin.Settings.UI.DefaultBorderWidth + Plugin.Settings.UI.WindowEdgeMargin;
Plugin.Settings.UI.MainWindow.PageHeight = 570;
Plugin.Settings.UI.MainWindow.PageContentHeight = Plugin.Settings.UI.MainWindow.PageHeight - Plugin.Settings.UI.WindowEdgeMargin * 2;
Plugin.Settings.UI.MainWindow.PageContentWidth = Plugin.Settings.UI.MainWindow.Width - Plugin.Settings.UI.WindowEdgeMargin * 2;

Plugin.Settings.UI.MainWindow.GroupContainer = {};
Plugin.Settings.UI.MainWindow.GroupContainer.PlayerSlot = {};
Plugin.Settings.UI.MainWindow.GroupContainer.PlayerSlot.Height = 75;
Plugin.Settings.UI.MainWindow.GroupContainer.PlayerSlot.Width = 250;
Plugin.Settings.UI.MainWindow.GroupContainer.Height = 6 * Plugin.Settings.UI.MainWindow.GroupContainer.PlayerSlot.Height + 5 * Plugin.Settings.UI.ElementsDefaultMargin;
Plugin.Settings.UI.MainWindow.GroupContainer.Width = Plugin.Settings.UI.MainWindow.GroupContainer.PlayerSlot.Width;

Plugin.Settings.UI.MainWindow.DeedContainer = {};
Plugin.Settings.UI.MainWindow.DeedContainer.Height = Plugin.Settings.UI.MainWindow.GroupContainer.Height;
Plugin.Settings.UI.MainWindow.DeedContainer.Width = Plugin.Settings.UI.MainWindow.PageContentWidth - Plugin.Settings.UI.MainWindow.GroupContainer.Width - Plugin.Settings.UI.ElementsDefaultMargin;
Plugin.Settings.UI.MainWindow.DeedContainer.xPos = Plugin.Settings.UI.MainWindow.GroupContainer.Width + Plugin.Settings.UI.ElementsDefaultMargin;
Plugin.Settings.UI.MainWindow.DeedContainer.yPos = Plugin.Settings.UI.MainWindow.GroupContainer.yPos;
Plugin.Settings.UI.MainWindow.DeedContainer.DeedSlot = {};
Plugin.Settings.UI.MainWindow.DeedContainer.DeedSlot.Height = Plugin.Settings.UI.MainWindow.GroupContainer.PlayerSlot.Height;
Plugin.Settings.UI.MainWindow.DeedContainer.DeedSlot.Width = Plugin.Settings.UI.MainWindow.DeedContainer.Width;

Plugin.Settings.UI.MainWindow.Page1Footer = {};
Plugin.Settings.UI.MainWindow.Page1Footer.ControlsWidth = (Plugin.Settings.UI.MainWindow.PageContentWidth - Plugin.Settings.UI.ElementsDefaultMargin * 2) / 3;
Plugin.Settings.UI.MainWindow.Page1Footer.ControlsHeight = Plugin.Settings.UI.MainWindow.PageContentHeight - Plugin.Settings.UI.MainWindow.GroupContainer.Height - Plugin.Settings.UI.ElementsDefaultMargin;
Plugin.Settings.UI.MainWindow.Page1Footer.ControlsYPos = Plugin.Settings.UI.MainWindow.GroupContainer.Height + Plugin.Settings.UI.ElementsDefaultMargin;


Plugin.Settings.UI.AlertsWindow = {};
Plugin.Settings.UI.AlertsWindow.Enabled = true;
Plugin.Settings.UI.AlertsWindow.Height = 160;
Plugin.Settings.UI.AlertsWindow.Width = 600;
Plugin.Settings.UI.AlertsWindow.xPos = (Framework.Const.SCREEN_WIDTH - Plugin.Settings.UI.AlertsWindow.Width) / 2;
Plugin.Settings.UI.AlertsWindow.yPos = (Framework.Const.SCREEN_HEIGHT - Plugin.Settings.UI.AlertsWindow.Height) / 2 - 200;
Plugin.Settings.UI.AlertsWindow.BackgroundOpacity = 0.6;
Plugin.Settings.UI.AlertsWindow.Font = 49;
Plugin.Settings.UI.AlertsWindow.TextRed = 0.1;
Plugin.Settings.UI.AlertsWindow.TextGreen = 1.0;
Plugin.Settings.UI.AlertsWindow.TextBlue = 0.1;
Plugin.Settings.UI.AlertsWindow.TextAlpha = 1.0;