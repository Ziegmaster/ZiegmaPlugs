SettingsPage = class(Framework.UI.Controls.BorderedControl);

function SettingsPage:Constructor(container)

    Framework.UI.Controls.BorderedControl.Constructor(self,
        Plugin.Settings.UI.MainWindow.PageContentWidth,
        Plugin.Settings.UI.MainWindow.PageContentHeight,
        Plugin.Settings.UI.DefaultBorderWidth,
        Plugin.Settings.UI.DefaultBorderColor
    );

    self:SetParent(container);
    self:SetPosition(Plugin.Settings.UI.WindowEdgeMargin, Plugin.Settings.UI.WindowEdgeMargin);
    self:SetVisible(false);
    self.BorderCenter = Turbine.UI.Control();
    self.BorderCenter:SetParent(self);
    self.BorderCenter:SetSize(Plugin.Settings.UI.DefaultBorderWidth, Plugin.Settings.UI.MainWindow.PageContentHeight);
    self.BorderCenter:SetPosition((Plugin.Settings.UI.MainWindow.PageContentWidth - Plugin.Settings.UI.DefaultBorderWidth)/2, 0);
    self.BorderCenter:SetBackColor(Plugin.Settings.UI.DefaultBorderColor);
    
    self.LocaleLabel = Turbine.UI.Label();
    self.LocaleLabel:SetParent(self);
    self.LocaleLabel:SetPosition(0, 10);
    self.LocaleLabel:SetSize((Plugin.Settings.UI.MainWindow.PageContentWidth - Plugin.Settings.UI.DefaultBorderWidth) / 2, 30);
    self.LocaleLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
    self.LocaleLabel:SetFont(Framework.UI.Fonts.TrajanProBold22);
    self.LocaleLabel:SetText(Texts.UI.Settings.LocaleLabel);
    self.LocaleLabel:SetForeColor(Turbine.UI.Color(0.95, 0.85, 0.55));
    
    self.LocaleComboBox = Framework.UI.Controls.ComboBox();
    self.LocaleComboBox:SetParent(self);
    self.LocaleComboBox:SetPosition(Plugin.Settings.UI.WindowEdgeMargin, 40);
    self.LocaleComboBox:SetSize((Plugin.Settings.UI.MainWindow.PageContentWidth - Plugin.Settings.UI.DefaultBorderWidth) / 2 - Plugin.Settings.UI.WindowEdgeMargin * 2 - 4, 30);
    for i = 1, 4 do
        self.LocaleComboBox:AddItem(Locales[i], i);
    end
    self.LocaleComboBox:ItemSelected(Plugin.Settings.Locale.Index);
    self.LocaleComboBox.ItemChanged = function ()
        local selection = self.LocaleComboBox:GetSelection();
        local locale = self.LocaleComboBox.label:GetText();
    
        local index = (selection == 2 or selection == 3) and 1 or selection;  
    
        Plugin.Settings.Locale.Index = index;
        Plugin.Settings.Locale.Short = Locales[index];
        Turbine.PluginManager.LoadPlugin("LPEReloader");
    end
    
    self.AccelerationCheckBox = Turbine.UI.Lotro.CheckBox();
    self.AccelerationCheckBox:SetParent(self);
    self.AccelerationCheckBox:SetPosition(Plugin.Settings.UI.WindowEdgeMargin, 80);
    self.AccelerationCheckBox:SetSize((Plugin.Settings.UI.MainWindow.PageContentWidth - Plugin.Settings.UI.DefaultBorderWidth) / 2 - Plugin.Settings.UI.WindowEdgeMargin * 2, 40);
    self.AccelerationCheckBox:SetFont(Turbine.UI.Lotro.Font["Verdana16"]);
    self.AccelerationCheckBox:SetText(" " .. Texts.UI.Settings.SimulateAcceleration);
    self.AccelerationCheckBox:SetChecked(Plugin.Settings.Flags.SimulateAcceleration);
    self.AccelerationCheckBox.CheckedChanged = function(sender, args)
        local isChecked = self.AccelerationCheckBox:IsChecked();
        Plugin.Settings.Flags.SimulateAcceleration = isChecked;
    end
    
    self.AnyDistCheckBox = Turbine.UI.Lotro.CheckBox();
    self.AnyDistCheckBox:SetParent(self);
    self.AnyDistCheckBox:SetPosition(Plugin.Settings.UI.WindowEdgeMargin, 120);
    self.AnyDistCheckBox:SetSize((Plugin.Settings.UI.MainWindow.PageContentWidth - Plugin.Settings.UI.DefaultBorderWidth) / 2 - Plugin.Settings.UI.WindowEdgeMargin * 2, 40);
    self.AnyDistCheckBox:SetFont(Turbine.UI.Lotro.Font["Verdana16"]);
    self.AnyDistCheckBox:SetText(" " .. Texts.UI.Settings.AnyDist);
    self.AnyDistCheckBox:SetChecked(Plugin.Settings.Flags.AnyDist);
    self.AnyDistCheckBox.CheckedChanged = function(sender, args)
        local isChecked = self.AnyDistCheckBox:IsChecked();
        Plugin.Settings.Flags.AnyDist = isChecked;
    end
    
    self.AlertsEnabledCheckBox = Turbine.UI.Lotro.CheckBox();
    self.AlertsEnabledCheckBox:SetParent(self);
    self.AlertsEnabledCheckBox:SetPosition(Plugin.Settings.UI.WindowEdgeMargin, 160);
    self.AlertsEnabledCheckBox:SetSize((Plugin.Settings.UI.MainWindow.PageContentWidth - Plugin.Settings.UI.DefaultBorderWidth) / 2 - Plugin.Settings.UI.WindowEdgeMargin * 2, 40);
    self.AlertsEnabledCheckBox:SetFont(Turbine.UI.Lotro.Font["Verdana16"]);
    self.AlertsEnabledCheckBox:SetText(" " .. Texts.UI.Settings.AlertsEnabled);
    self.AlertsEnabledCheckBox:SetChecked(Plugin.Settings.UI.AlertsWindow.Enabled);
    self.AlertsEnabledCheckBox.CheckedChanged = function(sender, args)
        local isChecked = self.AlertsEnabledCheckBox:IsChecked();
        Plugin.Settings.UI.AlertsWindow.Enabled = isChecked;
        Plugin.UI.AlertsWindow:SettingsMode(isChecked);
        Plugin.UI.AlertsWindow:SetVisible(isChecked);
    end
    
    self.AlertsLabel = Turbine.UI.Label();
    self.AlertsLabel:SetParent(self);
    self.AlertsLabel:SetPosition((Plugin.Settings.UI.MainWindow.PageContentWidth - Plugin.Settings.UI.DefaultBorderWidth) / 2, 10);
    self.AlertsLabel:SetSize((Plugin.Settings.UI.MainWindow.PageContentWidth - Plugin.Settings.UI.DefaultBorderWidth) / 2, 30);
    self.AlertsLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
    self.AlertsLabel:SetFont(Framework.UI.Fonts.TrajanProBold22);
    self.AlertsLabel:SetText(Texts.UI.Settings.AlertsLabel);
    self.AlertsLabel:SetForeColor(Turbine.UI.Color(0.95, 0.85, 0.55));
    
    self.ExampleButton1 = Turbine.UI.Lotro.GoldButton();
    self.ExampleButton1:SetParent(self);
    self.ExampleButton1:SetSize(100, 30);
    self.ExampleButton1:SetPosition((Plugin.Settings.UI.MainWindow.PageContentWidth - Plugin.Settings.UI.DefaultBorderWidth) / 2 + Plugin.Settings.UI.WindowEdgeMargin, 45);
    self.ExampleButton1:SetText(Texts.UI.Settings.AlertExample1);
    self.ExampleButton1.Click = function ()
        Plugin.UI.AlertsWindow:SetMessage(Texts.UI.Settings.AlertExample1Text);
        Plugin.UI.AlertsWindow:ShowAlert();
    end
    
    self.ExampleButton2 = Turbine.UI.Lotro.GoldButton();
    self.ExampleButton2:SetParent(self);
    self.ExampleButton2:SetSize(100, 30);
    self.ExampleButton2:SetPosition(100 + (Plugin.Settings.UI.MainWindow.PageContentWidth - Plugin.Settings.UI.DefaultBorderWidth) / 2 + Plugin.Settings.UI.WindowEdgeMargin * 2, 45);
    self.ExampleButton2:SetText(Texts.UI.Settings.AlertExample2);
    self.ExampleButton2.Click = function ()
        Plugin.UI.AlertsWindow:SetMessage(Texts.UI.Settings.AlertExample2Text);
        Plugin.UI.AlertsWindow:ShowAlert();
    end
    
    self.ExampleButton3 = Turbine.UI.Lotro.GoldButton();
    self.ExampleButton3:SetParent(self);
    self.ExampleButton3:SetSize(100, 30);
    self.ExampleButton3:SetPosition(200 + (Plugin.Settings.UI.MainWindow.PageContentWidth - Plugin.Settings.UI.DefaultBorderWidth) / 2 + Plugin.Settings.UI.WindowEdgeMargin * 3, 45);
    self.ExampleButton3:SetText(Texts.UI.Settings.AlertExample3);
    self.ExampleButton3.Click = function ()
        Plugin.UI.AlertsWindow:SetMessage(Texts.UI.Settings.AlertExample3Text);
        Plugin.UI.AlertsWindow:ShowAlert();
    end
    
    self.AlertsWindowWidthSlider = Framework.UI.Controls.Slider();
    self.AlertsWindowWidthSlider:SetParent(self);
    self.AlertsWindowWidthSlider:SetSize((Plugin.Settings.UI.MainWindow.PageContentWidth - Plugin.Settings.UI.DefaultBorderWidth) / 2 - Plugin.Settings.UI.WindowEdgeMargin, 60);
    self.AlertsWindowWidthSlider:SetPosition((Plugin.Settings.UI.MainWindow.PageContentWidth - Plugin.Settings.UI.DefaultBorderWidth + Plugin.Settings.UI.WindowEdgeMargin) / 2, 75);
    self.AlertsWindowWidthSlider:SetText(Texts.UI.Settings.AlertsWindowWidth);
    self.AlertsWindowWidthSlider:SetMin(100);
    self.AlertsWindowWidthSlider:SetMax(Turbine.UI.Display:GetWidth());
    self.AlertsWindowWidthSlider:SetValue(Plugin.Settings.UI.AlertsWindow.Width);
    self.AlertsWindowWidthSlider.ValueChanged = function (sender, args)
        Plugin.UI.AlertsWindow:SetWidth(args.value);
    end
    
    self.AlertsWindowHeightSlider = Framework.UI.Controls.Slider();
    self.AlertsWindowHeightSlider:SetParent(self);
    self.AlertsWindowHeightSlider:SetSize((Plugin.Settings.UI.MainWindow.PageContentWidth - Plugin.Settings.UI.DefaultBorderWidth) / 2 - Plugin.Settings.UI.WindowEdgeMargin, 60);
    self.AlertsWindowHeightSlider:SetPosition((Plugin.Settings.UI.MainWindow.PageContentWidth - Plugin.Settings.UI.DefaultBorderWidth + Plugin.Settings.UI.WindowEdgeMargin) / 2, 125);
    self.AlertsWindowHeightSlider:SetText(Texts.UI.Settings.AlertsWindowHeight);
    self.AlertsWindowHeightSlider:SetMin(20);
    self.AlertsWindowHeightSlider:SetMax(Turbine.UI.Display:GetHeight());
    self.AlertsWindowHeightSlider:SetValue(Plugin.Settings.UI.AlertsWindow.Height);
    self.AlertsWindowHeightSlider.ValueChanged = function (sender, args)
        Plugin.UI.AlertsWindow:SetHeight(args.value);
    end
    
    self.AlertsBackgroundOpacitySlider = Framework.UI.Controls.Slider();
    self.AlertsBackgroundOpacitySlider:SetParent(self);
    self.AlertsBackgroundOpacitySlider:SetSize((Plugin.Settings.UI.MainWindow.PageContentWidth - Plugin.Settings.UI.DefaultBorderWidth) / 2 - Plugin.Settings.UI.WindowEdgeMargin, 60);
    self.AlertsBackgroundOpacitySlider:SetPosition((Plugin.Settings.UI.MainWindow.PageContentWidth - Plugin.Settings.UI.DefaultBorderWidth + Plugin.Settings.UI.WindowEdgeMargin) / 2, 175);
    self.AlertsBackgroundOpacitySlider:SetZOrder(-1);
    self.AlertsBackgroundOpacitySlider:SetText(Texts.UI.Settings.AlertsBackgroundOpacity);
    self.AlertsBackgroundOpacitySlider:SetFormat("%.f %%");
    self.AlertsBackgroundOpacitySlider:SetMin(0);
    self.AlertsBackgroundOpacitySlider:SetMax(100);
    self.AlertsBackgroundOpacitySlider:SetValue(Plugin.Settings.UI.AlertsWindow.BackgroundOpacity * 100);
    self.AlertsBackgroundOpacitySlider.ValueChanged = function (sender, args)
        args.value = args.value / 100;
        Plugin.UI.AlertsWindow.Background:SetBackColor(Turbine.UI.Color(args.value, 0, 0, 0));
        Plugin.Settings.UI.AlertsWindow.BackgroundOpacity = args.value;
    end
    
    self.TextLabel = Turbine.UI.Label();
    self.TextLabel:SetParent(self);
    self.TextLabel:SetSize((Plugin.Settings.UI.MainWindow.PageContentWidth - Plugin.Settings.UI.DefaultBorderWidth) / 2, 30);
    self.TextLabel:SetPosition((Plugin.Settings.UI.MainWindow.PageContentWidth - Plugin.Settings.UI.DefaultBorderWidth) / 2, 225);
    self.TextLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
    self.TextLabel:SetFont(Turbine.UI.Lotro.Font["TrajanProBold22"]);
    self.TextLabel:SetForeColor(Turbine.UI.Color(0.95, 0.85, 0.55));
    self.TextLabel:SetText(Texts.UI.Settings.AlertsFontLabel);
    
    self.FontComboBox = Framework.UI.Controls.ComboBox();
    self.FontComboBox:SetParent(self);
    self.FontComboBox:SetPosition((Plugin.Settings.UI.MainWindow.PageContentWidth + Plugin.Settings.UI.DefaultBorderWidth) / 2 + Plugin.Settings.UI.WindowEdgeMargin, 255);
    self.FontComboBox:SetSize((Plugin.Settings.UI.MainWindow.PageContentWidth - Plugin.Settings.UI.DefaultBorderWidth) / 2 - Plugin.Settings.UI.WindowEdgeMargin * 2 - 4, 30);
    for index, value in ipairs(Framework.UI.FontArray) do
        self.FontComboBox:AddItem(value[1], index);
    end
    self.FontComboBox:ItemSelected(Plugin.Settings.UI.AlertsWindow.Font);
    self.FontComboBox.ItemChanged = function ()
        Plugin.UI.AlertsWindow:SetFont(self.FontComboBox:GetSelection());
        Plugin.Settings.UI.AlertsWindow.Font = self.FontComboBox:GetSelection();
    end
    
    self.AlertsTextRedSlider = Framework.UI.Controls.Slider();
    self.AlertsTextRedSlider:SetParent(self);
    self.AlertsTextRedSlider:SetSize((Plugin.Settings.UI.MainWindow.PageContentWidth - Plugin.Settings.UI.DefaultBorderWidth) / 2 - Plugin.Settings.UI.WindowEdgeMargin, 60);
    self.AlertsTextRedSlider:SetPosition((Plugin.Settings.UI.MainWindow.PageContentWidth - Plugin.Settings.UI.DefaultBorderWidth + Plugin.Settings.UI.WindowEdgeMargin) / 2, 305);
    self.AlertsTextRedSlider.label:SetForeColor(Turbine.UI.Color(1, 0, 0));
    self.AlertsTextRedSlider:SetText(Texts.UI.Settings.Red);
    self.AlertsTextRedSlider:SetMin(0);
    self.AlertsTextRedSlider:SetMax(255);
    self.AlertsTextRedSlider:SetValue(Plugin.Settings.UI.AlertsWindow.TextRed * 255);
    self.AlertsTextRedSlider.ValueChanged = function (sender, args)
        local color = Plugin.UI.AlertsWindow.Label:GetForeColor();
        color.R = args.value / 255;
        Plugin.Settings.UI.AlertsWindow.TextRed = color.R;
        Plugin.UI.AlertsWindow.Label:SetForeColor(color);
    end
    
    self.AlertsTextGreenSlider = Framework.UI.Controls.Slider();
    self.AlertsTextGreenSlider:SetParent(self);
    self.AlertsTextGreenSlider:SetSize((Plugin.Settings.UI.MainWindow.PageContentWidth - Plugin.Settings.UI.DefaultBorderWidth) / 2 - Plugin.Settings.UI.WindowEdgeMargin, 60);
    self.AlertsTextGreenSlider:SetPosition((Plugin.Settings.UI.MainWindow.PageContentWidth - Plugin.Settings.UI.DefaultBorderWidth + Plugin.Settings.UI.WindowEdgeMargin) / 2, 355);
    self.AlertsTextGreenSlider.label:SetForeColor(Turbine.UI.Color(0, 1, 0));
    self.AlertsTextGreenSlider:SetText(Texts.UI.Settings.Green);
    self.AlertsTextGreenSlider:SetMin(0);
    self.AlertsTextGreenSlider:SetMax(255);
    self.AlertsTextGreenSlider:SetValue(Plugin.Settings.UI.AlertsWindow.TextGreen * 255);
    self.AlertsTextGreenSlider.ValueChanged = function (sender, args)
        local color = Plugin.UI.AlertsWindow.Label:GetForeColor();
        color.G = args.value / 255;
        Plugin.Settings.UI.AlertsWindow.TextGreen = color.G;
        Plugin.UI.AlertsWindow.Label:SetForeColor(color);
    end
    
    self.AlertsTextBlueSlider = Framework.UI.Controls.Slider();
    self.AlertsTextBlueSlider:SetParent(self);
    self.AlertsTextBlueSlider:SetSize((Plugin.Settings.UI.MainWindow.PageContentWidth - Plugin.Settings.UI.DefaultBorderWidth) / 2 - Plugin.Settings.UI.WindowEdgeMargin, 60);
    self.AlertsTextBlueSlider:SetPosition((Plugin.Settings.UI.MainWindow.PageContentWidth - Plugin.Settings.UI.DefaultBorderWidth + Plugin.Settings.UI.WindowEdgeMargin) / 2, 405);
    self.AlertsTextBlueSlider.label:SetForeColor(Turbine.UI.Color(0, 0, 1));
    self.AlertsTextBlueSlider:SetText(Texts.UI.Settings.Blue);
    self.AlertsTextBlueSlider:SetMin(0);
    self.AlertsTextBlueSlider:SetMax(255);
    self.AlertsTextBlueSlider:SetValue(Plugin.Settings.UI.AlertsWindow.TextBlue * 255);
    self.AlertsTextBlueSlider.ValueChanged = function (args)
        local color = Plugin.UI.AlertsWindow.Label:GetForeColor();
        color.B = args.value / 255;
        Plugin.Settings.UI.AlertsWindow.TextBlue = color.B;
        Plugin.UI.AlertsWindow.Label:SetForeColor(color);
    end
    
    self.AlertsTextAlphaSlider = Framework.UI.Controls.Slider();
    self.AlertsTextAlphaSlider:SetParent(self);
    self.AlertsTextAlphaSlider:SetSize((Plugin.Settings.UI.MainWindow.PageContentWidth - Plugin.Settings.UI.DefaultBorderWidth) / 2 - Plugin.Settings.UI.WindowEdgeMargin, 60);
    self.AlertsTextAlphaSlider:SetPosition((Plugin.Settings.UI.MainWindow.PageContentWidth - Plugin.Settings.UI.DefaultBorderWidth + Plugin.Settings.UI.WindowEdgeMargin) / 2, 455);
    self.AlertsTextAlphaSlider:SetFormat("%.f %%");
    self.AlertsTextAlphaSlider:SetText(Texts.UI.Settings.Alpha);
    self.AlertsTextAlphaSlider:SetMin(0);
    self.AlertsTextAlphaSlider:SetMax(100);
    self.AlertsTextAlphaSlider:SetValue(Plugin.Settings.UI.AlertsWindow.TextAlpha * 100);
    self.AlertsTextAlphaSlider.ValueChanged = function (args)
        local color = Plugin.UI.AlertsWindow.Label:GetForeColor();
        color.A = args.value / 100;
        Plugin.Settings.UI.AlertsWindow.TextAlpha = color.A;
        Plugin.UI.AlertsWindow.Label:SetForeColor(color);
    end

end