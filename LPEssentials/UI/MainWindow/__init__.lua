import (Framework.Path.UI .. ".MainWindow.Toggle");
import (Framework.Path.UI .. ".MainWindow.Header");
import (Framework.Path.UI .. ".MainWindow.MainPage");
import (Framework.Path.UI .. ".MainWindow.SettingsPage");

MainWindow = class (Turbine.UI.Window);

function MainWindow:Constructor()

    Turbine.UI.Window.Constructor(self);

    self:SetSize(Plugin.Settings.UI.MainWindow.Width, Plugin.Settings.UI.MainWindow.Height);
    self:SetPosition(Plugin.Settings.UI.MainWindow.xPos, Plugin.Settings.UI.MainWindow.yPos);
    self:SetVisible(Plugin.Settings.Flags.FirstLaunch == true or Plugin.Settings.Flags.FirstLaunch == "true");
    self:SetMouseVisible(true);
    self:SetWantsKeyEvents(true);
    self:Activate();
    self.HUDVisible = true;

    self.Toggle = MainWindowToggle(self);
    self.Header = MainWindowHeader(self);

    self.PageWrapper = Framework.UI.Controls.BorderedControl(
        Plugin.Settings.UI.MainWindow.Width,
        Plugin.Settings.UI.MainWindow.PageHeight,
        Plugin.Settings.UI.DefaultBorderWidth,
        Turbine.UI.Color(1, 0.2, 0.2, 0.3)
    )
    self.PageWrapper.BorderTop:SetVisible(false);
    self.PageWrapper:SetParent(self);
    self.PageWrapper:SetPosition(0, Plugin.Settings.UI.MainWindow.HeaderHeight - Plugin.Settings.UI.DefaultBorderWidth);
    self.PageWrapper:SetBackColor(Plugin.Settings.UI.WindowDefaultBackground);
    self.PageWrapper:SetMouseVisible(false);
    self.PageWrapper.Pages = {
        MainPage(self.PageWrapper),
        SettingsPage(self.PageWrapper),
    };

    --Post init title creation to correctly overlap page content
    self.Header.Title.Label = Turbine.UI.Label();
    self.Header.Title.Label:SetParent(self);
    self.Header.Title.Label:SetSize(430, Plugin.Settings.UI.MainWindow.HeaderFakeHeight);
    self.Header.Title.Label:SetPosition(20, Plugin.Settings.UI.DefaultBorderWidth);
    self.Header.Title.Label:SetFont(Framework.UI.Fonts.TrajanProBold30);
    self.Header.Title.Label:SetForeColor(Plugin.Settings.UI.DefaultFontColor);
    self.Header.Title.Label:SetText(Plugin:GetName());
    self.Header.Title.Label:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
    self.Header.Title.Label:SetMouseVisible(false);

    function self.GetToggle()
        return self.Toggle;
    end

    function self.MouseDown(sender, args)
        if Framework.Utils.IsMouseOver(self.Header.Title) then
            self.canDrag = true;

            local pos_x, pos_y   = self:GetPosition();
            local mx, my = Turbine.UI.Display.GetMousePosition();

            self.start_x = mx - pos_x;
            self.start_y = my - pos_y;
        end
    end

    function self.MouseUp(sender, args)
        self.canDrag = false;
    end

    function self.MouseMove(sender, args)
        if self.canDrag then
            local mx, my = Turbine.UI.Display.GetMousePosition();

            local pos_x = mx - self.start_x;
            local pos_y = my - self.start_y;

            local w, h = self:GetSize();

            if pos_x < 0 then pos_x = 0 end
            if pos_x > (Framework.Const.SCREEN_WIDTH - w) then pos_x = Framework.Const.SCREEN_WIDTH - w end

            if pos_y < 0 then pos_y = 0 end
            if pos_y > (Framework.Const.SCREEN_HEIGHT- h) then pos_y = Framework.Const.SCREEN_HEIGHT - h end

            self:SetPosition(pos_x, pos_y);
        end
    end

    function self.KeyDown(sender, args)
        if args.Action == Turbine.UI.Lotro.Action.Escape then
            if self:IsVisible() then self:Close() end;
        elseif args.Action == 0x100000B3 then
            self.HUDVisible = not self.HUDVisible;
            if not self.HUDVisible then
                self.IsVisibleBuffer = self:IsVisible();
                self:SetVisible(self.HUDVisible);
            else
                self:SetVisible(self.IsVisibleBuffer);
            end
        end
    end

    function self.Activated(sender, args)
        Plugin.UI.AlertsWindow:SettingsMode(self.PageWrapper.Pages[2]:IsVisible() and Plugin.Settings.UI.AlertsWindow.Enabled);
    end

    function self.Close(sender, args)
        Turbine.UI.Window.Close(self);
        Plugin.UI.AlertsWindow:SettingsMode(false);
    end

end

Plugin.UI.MainWindow = MainWindow();