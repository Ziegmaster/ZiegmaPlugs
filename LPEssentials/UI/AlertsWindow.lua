AlertsWindow = class (Turbine.UI.Window);

function AlertsWindow:Constructor()

    Turbine.UI.Window.Constructor(self);

    self:SetZOrder(-2000);

    self:SetSize(PluginSettings.UI.AlertsWindow.Width, PluginSettings.UI.AlertsWindow.Height);
    self:SetPosition(PluginSettings.UI.AlertsWindow.xPos, PluginSettings.UI.AlertsWindow.yPos);

    self.DragBar = DragBar(self, "LPE Alerts");
    self.DragBar:SetBarOnTop(true);

    function AlertsWindow:SetVisible(flag)
        Turbine.UI.Window.SetVisible(self, flag);
        self.DragBar:SetHUDVisible(flag);
    end

    self.DragBar.ToggleHUDVisibleBuffer = self.DragBar.ToggleHUDVisible;

    self.DragBar.ToggleHUDVisible = function()
        if PluginSettings.UI.AlertsWindow.Enabled then self.DragBar:ToggleHUDVisibleBuffer() end;
    end

    self.Background = Turbine.UI.Control();
    self.Background:SetParent(self);
    self.Background:SetSize(PluginSettings.UI.AlertsWindow.Width, PluginSettings.UI.AlertsWindow.Height);
    self.Background:SetPosition(0, 0);

    self.Alert = Turbine.UI.Label();
    self.Alert:SetParent(self);
    self.Alert:SetPosition(0, 0);
    self.Alert:SetSize(PluginSettings.UI.AlertsWindow.Width, PluginSettings.UI.AlertsWindow.Height);
    self.Alert:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
    self:SetFont(tonumber(PluginSettings.UI.AlertsWindow.Font));
    self.Alert:SetFontStyle(Turbine.UI.FontStyle.Outline);
    self.Alert:SetForeColor(Turbine.UI.Color(
        tonumber(PluginSettings.UI.AlertsWindow.TextAlpha),
        tonumber(PluginSettings.UI.AlertsWindow.TextRed),
        tonumber(PluginSettings.UI.AlertsWindow.TextGreen),
        tonumber(PluginSettings.UI.AlertsWindow.TextBlue)
    ));
end

function AlertsWindow:SetWidth(width)
    Turbine.UI.Window.SetWidth(self, width);
    self.Background:SetWidth(width);
    self.Alert:SetWidth(width);
    PluginSettings.UI.AlertsWindow.Width = width;
    local x, y = UI.AlertsWindow:GetPosition();
    x = (Turbine.UI.Display:GetWidth() - width) / 2;
    UI.AlertsWindow:SetPosition(x, y);
    PluginSettings.UI.AlertsWindow.xPos = x;
    self.DragBar:Refresh();
end

function AlertsWindow:SetHeight(height)
    Turbine.UI.Window.SetHeight(self, height);
    self.Background:SetHeight(height);
    self.Alert:SetHeight(height);
    PluginSettings.UI.AlertsWindow.Height = height;
    local x, y = UI.AlertsWindow:GetPosition();
    y = (Turbine.UI.Display:GetHeight() - height) / 2;
    UI.AlertsWindow:SetPosition(x, y);
    PluginSettings.UI.AlertsWindow.yPos = y;
    self.DragBar:Refresh();
end

function AlertsWindow:SetFont(index)
    local font = UI.Fonts[index]; 
    if (type(font) == "table") then
        self.Alert:SetFont(font[2]);
    else
        self.Alert:SetFont(Turbine.UI.Lotro.Font[font]);
    end
    self.Alert:SetText(self.Alert:GetText());
end

function AlertsWindow:ShowAlert(string)
    self.timestamp = Turbine.Engine.GetGameTime();
    self.Alert:SetText(string);
    self.Background:SetBackColor(Turbine.UI.Color(tonumber(PluginSettings.UI.AlertsWindow.BackgroundOpacity), 0, 0, 0));
    if not self.isConfiguring then
        self.Alert.Update = function()
            local hide = Turbine.Engine.GetGameTime() - self.timestamp > 5;
            if hide then
                self:HideAlert();
                self.Alert:SetWantsUpdates(false);
            end
        end
        self.Alert:SetWantsUpdates(true);
    end
end

function AlertsWindow:HideAlert()
    self.Alert:SetText("");
    self.Background:SetBackColor(Turbine.UI.Color(0, 0, 0, 0));
end

function AlertsWindow:SettingsMode(flag)
    self.isConfiguring = flag;
    if self.isConfiguring then AlertsWindow:ShowAlert(Texts.UI.Options.AlertExample1Text);
    else self:HideAlert() end
end

UI.AlertsWindow = AlertsWindow();
UI.AlertsWindow:SetVisible(PluginSettings.UI.AlertsWindow.Enabled);