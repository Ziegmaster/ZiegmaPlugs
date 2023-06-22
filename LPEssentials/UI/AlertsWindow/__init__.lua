AlertsWindow = class (Turbine.UI.Window);

function AlertsWindow:Constructor()

    Turbine.UI.Window.Constructor(self);

    self:SetZOrder(-2000);
    self:SetSize(Plugin.Settings.UI.AlertsWindow.Width, Plugin.Settings.UI.AlertsWindow.Height);
    self:SetPosition(Plugin.Settings.UI.AlertsWindow.xPos, Plugin.Settings.UI.AlertsWindow.yPos);

    self.DragBar = Framework.UI.Controls.DragBar(self, "LPE Alerts");
    self.DragBar:SetBarOnTop(true);
    self.DragBar.ToggleHUDVisibleBuffer = self.DragBar.ToggleHUDVisible;
    self.DragBar.ToggleHUDVisible = function()
        if Plugin.Settings.UI.AlertsWindow.Enabled then self.DragBar:ToggleHUDVisibleBuffer() end;
    end

    self.Background = Turbine.UI.Control();
    self.Background:SetParent(self);
    self.Background:SetSize(Plugin.Settings.UI.AlertsWindow.Width, Plugin.Settings.UI.AlertsWindow.Height);
    self.Background:SetPosition(0, 0);
    self.Background:SetBackColor(Turbine.UI.Color(tonumber(Plugin.Settings.UI.AlertsWindow.BackgroundOpacity), 0, 0, 0));
    self.Background:SetVisible(false);

    self.Label = Turbine.UI.Label();
    self.Label:SetParent(self);
    self.Label:SetPosition(0, 0);
    self.Label:SetSize(Plugin.Settings.UI.AlertsWindow.Width, Plugin.Settings.UI.AlertsWindow.Height);
    self.Label:SetFont(Framework.UI.FontArray[Plugin.Settings.UI.AlertsWindow.Font][2]);
    self.Label:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
    self.Label:SetFontStyle(Turbine.UI.FontStyle.Outline);
    self.Label:SetForeColor(Turbine.UI.Color(
        tonumber(Plugin.Settings.UI.AlertsWindow.TextAlpha),
        tonumber(Plugin.Settings.UI.AlertsWindow.TextRed),
        tonumber(Plugin.Settings.UI.AlertsWindow.TextGreen),
        tonumber(Plugin.Settings.UI.AlertsWindow.TextBlue)
    ));
    self.Label:SetText(Texts.UI.Settings.AlertExample1Text);
    self.Label:SetVisible(false);

    function self:SetVisible(flag)
        self.Background:SetVisible(flag);
        self.Label:SetVisible(flag);
        self.DragBar:SetHUDVisible(flag);
    end

    function self:SetWidth(width)
        Turbine.UI.Window.SetWidth(self, width);
        self.Background:SetWidth(width);
        self.Label:SetWidth(width);
        Plugin.Settings.UI.AlertsWindow.Width = width;
        local x, y = Plugin.UI.AlertsWindow:GetPosition();
        x = (Turbine.UI.Display:GetWidth() - width) / 2;
        Plugin.UI.AlertsWindow:SetPosition(x, y);
        Plugin.Settings.UI.AlertsWindow.xPos = x;
        self.DragBar:Refresh();
    end
    
    function self:SetHeight(height)
        Turbine.UI.Window.SetHeight(self, height);
        self.Background:SetHeight(height);
        self.Label:SetHeight(height);
        Plugin.Settings.UI.AlertsWindow.Height = height;
        local x, y = Plugin.UI.AlertsWindow:GetPosition();
        y = (Turbine.UI.Display:GetHeight() - height) / 2;
        Plugin.UI.AlertsWindow:SetPosition(x, y);
        Plugin.Settings.UI.AlertsWindow.yPos = y;
        self.DragBar:Refresh();
    end
    
    function self:SetFont(index)
        self.Label:SetFont(Framework.UI.FontArray[index][2]);
        self.Label:SetText(self.Label:GetText());
    end
    
    function self:SetMessage(message)
        self.Label:SetText(message);
    end
    
    function self:ShowAlert()
        self:SetVisible(true);
        local timestamp = Turbine.Engine.GetGameTime();
        if not self.isConfiguring then
            self.Label.Update = function()
                local hide = Turbine.Engine.GetGameTime() - timestamp > 5;
                if hide then
                    self:HideAlert();
                    self.Label:SetWantsUpdates(false);
                end
            end
            self.Label:SetWantsUpdates(true);
        end
    end
    
    function self:HideAlert()
        self:SetVisible(false);
    end

    function self:SettingsMode(flag)
        self.isConfiguring = flag;
        if self.isConfiguring then self:ShowAlert(Texts.UI.Settings.AlertExample1Text);
        else self:HideAlert() end
    end
end

Plugin.UI.AlertsWindow = AlertsWindow();