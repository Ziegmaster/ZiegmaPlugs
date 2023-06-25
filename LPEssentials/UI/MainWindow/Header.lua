MainWindowHeader = class(Turbine.UI.Control);

function MainWindowHeader:Constructor(window)

    Turbine.UI.Control.Constructor(self);

    self:SetParent(window);
    self:SetSize(Plugin.Settings.UI.MainWindow.Width, Plugin.Settings.UI.MainWindow.HeaderHeight);
    self:SetPosition(0, 0);
    self:SetZOrder(2);
    self:SetMouseVisible(false);

    self.Title = Framework.UI.Controls.BorderedControl(
        430,
        Plugin.Settings.UI.MainWindow.HeaderFakeHeight,
        Plugin.Settings.UI.DefaultBorderWidth,
        Plugin.Settings.UI.DefaultBorderColor
    )
    self.Title:SetParent(window);
    self.Title:SetPosition(20, 0);
    self.Title:SetBackColor(Plugin.Settings.UI.WindowDefaultBackground);
    self.Title:SetMouseVisible(false);

    self.Main = Framework.UI.Controls.BorderedControl(
        100,
        Plugin.Settings.UI.MainWindow.HeaderHeight,
        Plugin.Settings.UI.DefaultBorderWidth,
        Plugin.Settings.UI.DefaultBorderColor
    );
    self.Main.BorderBottom:SetVisible(false);
    self.Main:SetParent(self);
    self.Main:SetSize(100, Plugin.Settings.UI.MainWindow.HeaderHeight);
    self.Main:SetPosition(460, 0);
    self.Main:SetBackColor(Plugin.Settings.UI.WindowDefaultBackground);
    self.Main:SetMouseVisible(true);

    self.Main.MouseClick = function (sender, args)
        if args.Button == 1 and not self:GetParent().PageWrapper.Pages[1]:IsVisible() then
            self.Settings.BorderBottom:SetVisible(true);
            self.Main.BorderBottom:SetVisible(false);
            self:GetParent().PageWrapper.Pages[2]:SetVisible(false);
            self:GetParent().PageWrapper.Pages[1]:SetVisible(true);
            Plugin.UI.AlertsWindow:SettingsMode(false);
        end
    end

    self.Main.MouseEnter = function(sender, args)
        if not Plugin.UI.MainWindow.PageWrapper.Pages[1]:IsVisible() then
            self.Main.Label:SetForeColor(Turbine.UI.Color(0.9,0.9,0));
        end
    end

    self.Main.MouseLeave = function (sender, args)
        self.Main.Label:SetForeColor(Plugin.Settings.UI.DefaultFontColor);
    end

    self.Main.Label = Turbine.UI.Label();
    self.Main.Label:SetParent(self.Main);
    self.Main.Label:SetSize(self.Main:GetSize());
    self.Main.Label:SetFont(Framework.UI.Fonts.VerdanaBold16);
    self.Main.Label:SetForeColor(Plugin.Settings.UI.DefaultFontColor);
    self.Main.Label:SetText(Texts.UI.MainWindowHeader.Main);
    self.Main.Label:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
    self.Main.Label:SetMouseVisible(false);

    self.Settings = Framework.UI.Controls.BorderedControl(
        100,
        Plugin.Settings.UI.MainWindow.HeaderHeight,
        Plugin.Settings.UI.DefaultBorderWidth,
        Plugin.Settings.UI.DefaultBorderColor
    )
    self.Settings:SetParent(self);
    self.Settings:SetPosition(570, 0);
    self.Settings:SetBackColor(Plugin.Settings.UI.WindowDefaultBackground);
    self.Settings:SetMouseVisible(true);

    self.Settings.MouseClick = function(sender, args)
        if args.Button == 1 and not self:GetParent().PageWrapper.Pages[2]:IsVisible() then
            self.Main.BorderBottom:SetVisible(true);
            self.Settings.BorderBottom:SetVisible(false);
            self:GetParent().PageWrapper.Pages[1]:SetVisible(false);
            self:GetParent().PageWrapper.Pages[2]:SetVisible(true);
            Plugin.UI.AlertsWindow:SettingsMode(Plugin.Settings.UI.AlertsWindow.Enabled);
        end
    end

    self.Settings.MouseEnter = function(sender, args)
        if not Plugin.UI.MainWindow.PageWrapper.Pages[2]:IsVisible() then
            self.Settings.Label:SetForeColor(Turbine.UI.Color(0.9,0.9,0));
        end
    end

    self.Settings.MouseLeave = function (sender, args)
        self.Settings.Label:SetForeColor(Plugin.Settings.UI.DefaultFontColor);
    end

    self.Settings.Label = Turbine.UI.Label();
    self.Settings.Label:SetParent(self.Settings);
    self.Settings.Label:SetSize(self.Settings:GetSize());
    self.Settings.Label:SetFont(Framework.UI.Fonts.VerdanaBold16);
    self.Settings.Label:SetForeColor(Plugin.Settings.UI.DefaultFontColor);
    self.Settings.Label:SetText(Texts.UI.MainWindowHeader.Settings);
    self.Settings.Label:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
    self.Settings.Label:SetMouseVisible(false);

    self.Close = Framework.UI.Controls.BorderedControl(
        100,
        Plugin.Settings.UI.MainWindow.HeaderHeight,
        Plugin.Settings.UI.DefaultBorderWidth,
        Plugin.Settings.UI.DefaultBorderColor
    )
    self.Close:SetParent(self);
    self.Close:SetPosition(680, 0);
    self.Close:SetBackColor(Plugin.Settings.UI.WindowDefaultBackground);
    self.Close:SetMouseVisible(true);

    self.Close.MouseClick = function(sender, args)
        if args.Button == 1 then
            self:GetParent():Close();
        end
    end

    self.Close.MouseEnter = function(sender, args)
        self.Close:SetBackColor(Turbine.UI.Color(0.7, 0.05, 0.05));
    end

    self.Close.MouseLeave = function (sender, args)
        self.Close:SetBackColor(Plugin.Settings.UI.WindowDefaultBackground);
    end

    self.Close.Label = Turbine.UI.Label();
    self.Close.Label:SetParent(self.Close);
    self.Close.Label:SetSize(self.Close:GetSize());
    self.Close.Label:SetFont(Framework.UI.Fonts.VerdanaBold16);
    self.Close.Label:SetForeColor(Plugin.Settings.UI.DefaultFontColor);
    self.Close.Label:SetText(Texts.UI.MainWindowHeader.Close);
    self.Close.Label:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
    self.Close.Label:SetMouseVisible(false);

    self.LowBorder1 = Turbine.UI.Control();
    self.LowBorder1:SetParent(self);
    self.LowBorder1:SetSize(22, Plugin.Settings.UI.DefaultBorderWidth);
    self.LowBorder1:SetPosition(0, Plugin.Settings.UI.MainWindow.HeaderHeight - Plugin.Settings.UI.DefaultBorderWidth);
    self.LowBorder1:SetBackColor(Plugin.Settings.UI.DefaultBorderColor);
    self.LowBorder2 = Turbine.UI.Control();
    self.LowBorder2:SetParent(self);
    self.LowBorder2:SetSize(Plugin.Settings.UI.ElementsDefaultMargin * 2 + 2, Plugin.Settings.UI.DefaultBorderWidth);
    self.LowBorder2:SetPosition(448, 30);
    self.LowBorder2:SetBackColor(Plugin.Settings.UI.DefaultBorderColor);
    self.LowBorder3 = Turbine.UI.Control();
    self.LowBorder3:SetParent(self);
    self.LowBorder3:SetSize(Plugin.Settings.UI.ElementsDefaultMargin * 2, Plugin.Settings.UI.DefaultBorderWidth);
    self.LowBorder3:SetPosition(560, Plugin.Settings.UI.MainWindow.HeaderHeight - Plugin.Settings.UI.DefaultBorderWidth);
    self.LowBorder3:SetBackColor(Plugin.Settings.UI.DefaultBorderColor);
    self.LowBorder4 = Turbine.UI.Control();
    self.LowBorder4:SetParent(self);
    self.LowBorder4:SetSize(Plugin.Settings.UI.ElementsDefaultMargin * 2, Plugin.Settings.UI.DefaultBorderWidth);
    self.LowBorder4:SetPosition(670, Plugin.Settings.UI.MainWindow.HeaderHeight - Plugin.Settings.UI.DefaultBorderWidth);
    self.LowBorder4:SetBackColor(Plugin.Settings.UI.DefaultBorderColor);
    self.LowBorder5 = Turbine.UI.Control();
    self.LowBorder5:SetParent(self);
    self.LowBorder5:SetSize(20, Plugin.Settings.UI.DefaultBorderWidth);
    self.LowBorder5:SetPosition(780, Plugin.Settings.UI.MainWindow.HeaderHeight - Plugin.Settings.UI.DefaultBorderWidth);
    self.LowBorder5:SetBackColor(Plugin.Settings.UI.DefaultBorderColor);

end