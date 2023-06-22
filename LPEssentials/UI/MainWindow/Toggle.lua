MainWindowToggle = class(Turbine.UI.Window);

function MainWindowToggle:Constructor(window)

    Turbine.UI.Window.Constructor(self);

    self:SetSize(Plugin.Settings.UI.MainWindow.Toggle.Width, Plugin.Settings.UI.MainWindow.Toggle.Height);
    self:SetOpacity(0.6);
    self:SetPosition(Plugin.Settings.UI.MainWindow.Toggle.xPos, Plugin.Settings.UI.MainWindow.Toggle.yPos);
    self:SetBackground(Framework.Path.Resources .. "/coinbag.tga");
    self:SetVisible(true);
    self:SetEnabled(true);
    self:SetMouseVisible(true);
    self.DragBar = Framework.UI.Controls.DragBar(self, "LPE");
    self.DragBar:SetBarOnTop(true);
    self.DragBar:SetZOrder(2);

    self.MouseClick = function(sender, args)
        if args.Button == 1 then
            if window:IsVisible() then
                window:Close();
            else
                window:SetVisible(true);
                window:Activate();
            end
        end
    end

    self.MouseEnter = function(sender, args)
        self:SetOpacity(1.0);
    end

    self.MouseLeave = function(sender, args)
        self:SetOpacity(0.6);
    end

end