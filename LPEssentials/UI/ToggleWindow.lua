MainWindowToggle = class (LPEWindow);

function MainWindowToggle:Constructor()
    
    LPEWindow.Constructor(self);

    self:SetSize(48, 48);
    self:SetOpacity(0.6);
    self:SetPosition(PluginSettings.UI.MainWindowToggle.xPos, PluginSettings.UI.MainWindowToggle.yPos);
    self:SetBackground(Resources .. "/coinbag.tga");
    self:SetVisible(true);
    self:SetEnabled(true);
    self:SetMouseVisible(true);
    self.DragBar = DragBar(self, "LPE");
    self.DragBar:SetBarOnTop(true);
    self.DragBar:SetZOrder(2);

    AddListener(self, "MouseClick", function(sender, args)
        if UI.MainWindow:IsVisible() then
            UI.MainWindow:Close();
        else
            UI.MainWindow:SetVisible(true);
            UI.MainWindow:Activate();
        end
    end);

    AddListener(self, "MouseEnter", function(sender, args)
        sender:SetOpacity(1.0);
    end);

    AddListener(self, "MouseLeave", function(sender, args)
        sender:SetOpacity(0.6);
    end);

end

UI.MainWindowToggle = MainWindowToggle();