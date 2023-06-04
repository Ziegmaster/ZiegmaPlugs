PluginOptions = class (Turbine.UI.Control);

function PluginOptions:Constructor()

    Turbine.UI.Control.Constructor(self);

    self:SetSize(400, 300);

    self.LocaleLabel = Turbine.UI.Label();
    self.LocaleLabel:SetParent(self);
    self.LocaleLabel:SetPosition(0, 0);
    self.LocaleLabel:SetSize(300, 40);
    self.LocaleLabel:SetFont(Turbine.UI.Lotro.Font["VerdanaBold16"]);
    self.LocaleLabel:SetText(Texts.UI.Options.LocaleLabel);

    self.locales = {"EN", "DE (Not Supported)", "FR (Not Supported)", "RU"};

    self.LocaleComboBox = ComboBox();
    self.LocaleComboBox:SetParent(self);
    self.LocaleComboBox:SetPosition(0, 40);
    self.LocaleComboBox:SetSize(300, 30);
    for i = 1, 4 do
        self.LocaleComboBox:AddItem(self.locales[i], i);
    end
    self.LocaleComboBox:ItemSelected(Settings.Locale.Index);
    self.LocaleComboBox.ItemChanged = function ()
        local selection = self.LocaleComboBox:GetSelection();
        local locale = self.LocaleComboBox.label:GetText();

        local index = (selection == 2 or selection == 3) and 1 or selection;  

        Settings.Locale.Index = index;
        Settings.Locale.Short = self.locales[index];
        Turbine.PluginManager.LoadPlugin("LPEReloader");
    end

    self.AccelerationCheckBox = Turbine.UI.Lotro.CheckBox();
    self.AccelerationCheckBox:SetParent(self);
    self.AccelerationCheckBox:SetPosition(0, 70);
    self.AccelerationCheckBox:SetSize(300, 40);
    self.AccelerationCheckBox:SetFont(Turbine.UI.Lotro.Font["Verdana16"]);
    self.AccelerationCheckBox:SetText(" " .. Texts.UI.Options.SimulateAcceleration);
    self.AccelerationCheckBox:SetChecked(Settings.Main.SimulateAcceleration);
    self.AccelerationCheckBox.CheckedChanged = function(sender, args)
        local isChecked = self.AccelerationCheckBox:IsChecked();
        Settings.Main.SimulateAcceleration = isChecked;
    end

    self.AnyDistCheckBox = Turbine.UI.Lotro.CheckBox();
    self.AnyDistCheckBox:SetParent(self);
    self.AnyDistCheckBox:SetPosition(0, 110);
    self.AnyDistCheckBox:SetSize(300, 40);
    self.AnyDistCheckBox:SetFont(Turbine.UI.Lotro.Font["Verdana16"]);
    self.AnyDistCheckBox:SetText(" " .. Texts.UI.Options.AnyDist);
    self.AnyDistCheckBox:SetChecked(Settings.Main.AnyDist);
    self.AnyDistCheckBox.CheckedChanged = function(sender, args)
        local isChecked = self.AnyDistCheckBox:IsChecked();
        Settings.Main.AnyDist = isChecked;
    end

    self.AlertsStyleButton = Turbine.UI.Lotro.Button();
    self.AlertsStyleButton:SetParent(self);
    self.AlertsStyleButton:SetPosition(0, 190);
    self.AlertsStyleButton:SetSize(100, 40);
    self.AlertsStyleButton:SetText(Texts.UI.Options.AlertsStyle);
    AddListener(self.AlertsStyleButton, "Click", function ()
        UI.AlertsSettingsWindow:SetVisible(true);
        UI.AlertsSettingsWindow:Activate();
        UI.AlertsWindow:SettingsMode(true);
    end);

    self.AlertsEnabledCheckBox = Turbine.UI.Lotro.CheckBox();
    self.AlertsEnabledCheckBox:SetParent(self);
    self.AlertsEnabledCheckBox:SetPosition(0, 150);
    self.AlertsEnabledCheckBox:SetSize(300, 40);
    self.AlertsEnabledCheckBox:SetFont(Turbine.UI.Lotro.Font["Verdana16"]);
    self.AlertsEnabledCheckBox:SetText(" " .. Texts.UI.Options.AlertsEnabled);
    self.AlertsEnabledCheckBox:SetChecked(Settings.UI.AlertsWindow.Enabled);
    self.AlertsStyleButton:SetEnabled(Settings.UI.AlertsWindow.Enabled);
    self.AlertsEnabledCheckBox.CheckedChanged = function(sender, args)
        local isChecked = self.AlertsEnabledCheckBox:IsChecked();
        if not isChecked then UI.AlertsSettingsWindow:Close() end;
        Settings.UI.AlertsWindow.Enabled = isChecked;
        UI.AlertsWindow:SetVisible(isChecked);
        self.AlertsStyleButton:SetEnabled(isChecked);
    end

    self.PlayerTrackerEnabledCheckBox = Turbine.UI.Lotro.CheckBox();
    self.PlayerTrackerEnabledCheckBox:SetParent(self);
    self.PlayerTrackerEnabledCheckBox:SetPosition(0, 220);
    self.PlayerTrackerEnabledCheckBox:SetSize(300, 40);
    self.PlayerTrackerEnabledCheckBox:SetFont(Turbine.UI.Lotro.Font["Verdana16"]);
    self.PlayerTrackerEnabledCheckBox:SetText(" " .. Texts.UI.Options.PlayerTrackerEnabled);
    self.PlayerTrackerEnabledCheckBox:SetChecked(Settings.UI.PlayerTrackerWindow.Enabled);
    self.PlayerTrackerEnabledCheckBox.CheckedChanged = function(sender, args)
        local isChecked = self.PlayerTrackerEnabledCheckBox:IsChecked();
        Settings.UI.PlayerTrackerWindow.Enabled = isChecked;
        UI.PlayerTrackerWindow:SetVisible(isChecked);
    end
    
end

AlertsSettingsWindow = class (LPELotroWindow);

function AlertsSettingsWindow:Constructor()
    
    LPELotroWindow.Constructor(self);

    AddListener(self, "Closed", function ()
        UI.AlertsWindow:SettingsMode(false);
    end);

    self:SetText(Texts.UI.Options.AlertsStyleTitle);
    self:SetSize(390, 460);
    self:SetResizable(false);
    self:SetPosition((Turbine.UI.Display:GetWidth() - self:GetWidth()) / 2, (Turbine.UI.Display:GetHeight() - self:GetHeight()) / 2);

    self.ExampleButton1 = Turbine.UI.Lotro.Button();
    self.ExampleButton1:SetParent(self);
    self.ExampleButton1:SetSize(100, 30);
    self.ExampleButton1:SetText(Texts.UI.Options.AlertExample1);
    self.ExampleButton1:SetPosition(25, 40);
    AddListener(self.ExampleButton1, "Click", function ()
        UI.AlertsWindow:ShowAlert(Texts.UI.Options.AlertExample1Text);
    end);

    self.ExampleButton2 = Turbine.UI.Lotro.Button();
    self.ExampleButton2:SetParent(self);
    self.ExampleButton2:SetSize(100, 30);
    self.ExampleButton2:SetText(Texts.UI.Options.AlertExample2);
    self.ExampleButton2:SetPosition(145, 40);
    AddListener(self.ExampleButton2, "Click", function ()
        UI.AlertsWindow:ShowAlert(Texts.UI.Options.AlertExample2Text);
    end);

    self.ExampleButton3 = Turbine.UI.Lotro.Button();
    self.ExampleButton3:SetParent(self);
    self.ExampleButton3:SetSize(100, 30);
    self.ExampleButton3:SetText(Texts.UI.Options.AlertExample3);
    self.ExampleButton3:SetPosition(265, 40);
    AddListener(self.ExampleButton3, "Click", function ()
        UI.AlertsWindow:ShowAlert(Texts.UI.Options.AlertExample3Text);
    end);

    self.AlertsWindowWidthSlider = Slider();
    self.AlertsWindowWidthSlider:SetParent(self);
    self.AlertsWindowWidthSlider:SetSize(366, 60);
    self.AlertsWindowWidthSlider:SetPosition(12, 70);
    self.AlertsWindowWidthSlider:SetText(Texts.UI.Options.AlertsWindowWidth);
    self.AlertsWindowWidthSlider:SetMin(100);
    self.AlertsWindowWidthSlider:SetMax(Turbine.UI.Display:GetWidth());
    self.AlertsWindowWidthSlider:SetValue(Settings.UI.AlertsWindow.Width);
    AddListener(self.AlertsWindowWidthSlider, "ValueChanged", function (args)
        UI.AlertsWindow:SetWidth(args.value);
    end);

    self.AlertsWindowHeightSlider = Slider();
    self.AlertsWindowHeightSlider:SetParent(self);
    self.AlertsWindowHeightSlider:SetSize(366, 60);
    self.AlertsWindowHeightSlider:SetPosition(12, 130);
    self.AlertsWindowHeightSlider:SetText(Texts.UI.Options.AlertsWindowHeight);
    self.AlertsWindowHeightSlider:SetMin(20);
    self.AlertsWindowHeightSlider:SetMax(Turbine.UI.Display:GetHeight());
    self.AlertsWindowHeightSlider:SetValue(Settings.UI.AlertsWindow.Height);
    AddListener(self.AlertsWindowHeightSlider, "ValueChanged", function (args)
        UI.AlertsWindow:SetHeight(args.value);
    end);
    
    self.AlertsBackgroundOpacitySlider = Slider();
    self.AlertsBackgroundOpacitySlider:SetParent(self);
    self.AlertsBackgroundOpacitySlider:SetSize(366, 60);
    self.AlertsBackgroundOpacitySlider:SetPosition(12, 190);
    self.AlertsBackgroundOpacitySlider:SetZOrder(-1);
    self.AlertsBackgroundOpacitySlider:SetText(Texts.UI.Options.AlertsBackgroundOpacity);
    self.AlertsBackgroundOpacitySlider:SetFormat("%.f %%");
    self.AlertsBackgroundOpacitySlider:SetMin(0);
    self.AlertsBackgroundOpacitySlider:SetMax(100);
    self.AlertsBackgroundOpacitySlider:SetValue(Settings.UI.AlertsWindow.BackgroundOpacity * 100);
    AddListener(self.AlertsBackgroundOpacitySlider, "ValueChanged", function (args)
        args.value = args.value / 100;
        UI.AlertsWindow.Background:SetBackColor(Turbine.UI.Color(args.value, 0, 0, 0));
        Settings.UI.AlertsWindow.BackgroundOpacity = args.value;
    end);

    self.TextLabel = Turbine.UI.Label();
    self.TextLabel:SetParent(self);
    self.TextLabel:SetSize(390, 30);
    self.TextLabel:SetPosition(0, 240);
    self.TextLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
    self.TextLabel:SetFont(Turbine.UI.Lotro.Font["TrajanProBold22"]);
    self.TextLabel:SetForeColor(Turbine.UI.Color(0.95, 0.85, 0.55));
    self.TextLabel:SetText(Texts.UI.Options.AlertsFontLabel);

    self.FontComboBox = ComboBox();
    self.FontComboBox:SetParent(self);
    self.FontComboBox:SetPosition(25, 270);
    self.FontComboBox:SetSize(340, 30);
    for index, value in next, UI.Fonts do
        if (type(value) == "table") then
            self.FontComboBox:AddItem(value[1], index);
        else
            self.FontComboBox:AddItem(value, index);
        end
    end
    self.FontComboBox:ItemSelected(Settings.UI.AlertsWindow.Font);
    self.FontComboBox.ItemChanged = function ()
        UI.AlertsWindow:SetFont(self.FontComboBox:GetSelection());
        Settings.UI.AlertsWindow.Font = self.FontComboBox:GetSelection();
    end

    self.AlertsTextRedSlider = Slider();
    self.AlertsTextRedSlider:SetParent(self);
    self.AlertsTextRedSlider:SetSize(180, 60);
    self.AlertsTextRedSlider:SetPosition(12, 320);
    self.AlertsTextRedSlider.label:SetForeColor(Turbine.UI.Color(1, 0, 0));
    self.AlertsTextRedSlider:SetText(Texts.UI.Options.Red);
    self.AlertsTextRedSlider:SetMin(0);
    self.AlertsTextRedSlider:SetMax(255);
    self.AlertsTextRedSlider:SetValue(Settings.UI.AlertsWindow.TextRed * 255);
    AddListener(self.AlertsTextRedSlider, "ValueChanged", function (args)
        local color = UI.AlertsWindow.Alert:GetForeColor();
        color.R = args.value / 255;
        Settings.UI.AlertsWindow.TextRed = color.R;
        UI.AlertsWindow.Alert:SetForeColor(color);
    end);

    self.AlertsTextGreenSlider = Slider();
    self.AlertsTextGreenSlider:SetParent(self);
    self.AlertsTextGreenSlider:SetSize(180, 60);
    self.AlertsTextGreenSlider:SetPosition(196, 320);
    self.AlertsTextGreenSlider.label:SetForeColor(Turbine.UI.Color(0, 1, 0));
    self.AlertsTextGreenSlider:SetText(Texts.UI.Options.Green);
    self.AlertsTextGreenSlider:SetMin(0);
    self.AlertsTextGreenSlider:SetMax(255);
    self.AlertsTextGreenSlider:SetValue(Settings.UI.AlertsWindow.TextGreen * 255);
    AddListener(self.AlertsTextGreenSlider, "ValueChanged", function (args)
        local color = UI.AlertsWindow.Alert:GetForeColor();
        color.G = args.value / 255;
        Settings.UI.AlertsWindow.TextGreen = color.G;
        UI.AlertsWindow.Alert:SetForeColor(color);
    end);

    self.AlertsTextBlueSlider = Slider();
    self.AlertsTextBlueSlider:SetParent(self);
    self.AlertsTextBlueSlider:SetSize(180, 60);
    self.AlertsTextBlueSlider:SetPosition(12, 380);
    self.AlertsTextBlueSlider.label:SetForeColor(Turbine.UI.Color(0, 0, 1));
    self.AlertsTextBlueSlider:SetText(Texts.UI.Options.Blue);
    self.AlertsTextBlueSlider:SetMin(0);
    self.AlertsTextBlueSlider:SetMax(255);
    self.AlertsTextBlueSlider:SetValue(Settings.UI.AlertsWindow.TextBlue * 255);
    AddListener(self.AlertsTextBlueSlider, "ValueChanged", function (args)
        local color = UI.AlertsWindow.Alert:GetForeColor();
        color.B = args.value / 255;
        Settings.UI.AlertsWindow.TextBlue = color.B;
        UI.AlertsWindow.Alert:SetForeColor(color);
    end);

    self.AlertsTextAlphaSlider = Slider();
    self.AlertsTextAlphaSlider:SetParent(self);
    self.AlertsTextAlphaSlider:SetSize(180, 60);
    self.AlertsTextAlphaSlider:SetPosition(196, 380);
    self.AlertsTextAlphaSlider:SetFormat("%.f %%");
    self.AlertsTextAlphaSlider:SetText(Texts.UI.Options.Alpha);
    self.AlertsTextAlphaSlider:SetMin(0);
    self.AlertsTextAlphaSlider:SetMax(100);
    self.AlertsTextAlphaSlider:SetValue(Settings.UI.AlertsWindow.TextAlpha * 100);
    AddListener(self.AlertsTextAlphaSlider, "ValueChanged", function (args)
        local color = UI.AlertsWindow.Alert:GetForeColor();
        color.A = args.value / 100;
        Settings.UI.AlertsWindow.TextAlpha = color.A;
        UI.AlertsWindow.Alert:SetForeColor(color);
    end);

end

UI.PluginOptions = PluginOptions();
UI.AlertsSettingsWindow = AlertsSettingsWindow();

plugin.GetOptionsPanel = function(self) return UI.PluginOptions end;