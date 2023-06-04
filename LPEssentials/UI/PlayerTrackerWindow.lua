PlayerTrackerWindow = class (Turbine.UI.Window);

function PlayerTrackerWindow:Constructor()

    Turbine.UI.Window.Constructor(self);

    self:SetSize(Settings.UI.PlayerTrackerWindow.Width, Settings.UI.PlayerTrackerWindow.Height);
    self:SetPosition(Settings.UI.PlayerTrackerWindow.xPos, Settings.UI.PlayerTrackerWindow.yPos);
    self:SetMouseVisible(true);

    self.DragBar = DragBar(self, "LPE Player tracker");
    self.DragBar:SetBarOnTop(true);

    function PlayerTrackerWindow:SetVisible(flag)
        Turbine.UI.Window.SetVisible(self, flag);
        self.DragBar:SetHUDVisible(flag);
    end

    self.DragBar.ToggleHUDVisibleBuffer = self.DragBar.ToggleHUDVisible;

    self.DragBar.ToggleHUDVisible = function()
        if Settings.UI.PlayerTrackerWindow.Enabled then self.DragBar:ToggleHUDVisibleBuffer() end;
    end

    self.DragBar.CreateHoverBoxBuffer = self.DragBar.CreateHoverBox;

    self.DragBar.CreateHoverBox = function()
        if not self:IsVisible() then self.DragBar:CreateHoverBoxBuffer() end;
    end;

    self.Background = Turbine.UI.Control();
    self.Background:SetParent(self);
    self.Background:SetSize(Settings.UI.PlayerTrackerWindow.Width, Settings.UI.PlayerTrackerWindow.Height);
    self.Background:SetPosition(0, 0);
    self.Background:SetBackColor(Turbine.UI.Color(0.74, 0, 0, 0));

    self.BorderTop = Turbine.UI.Control();
    self.BorderTop:SetParent(self);
    self.BorderTop:SetSize(Settings.UI.PlayerTrackerWindow.Width, 2);
    self.BorderTop:SetPosition(0, 0);
    self.BorderTop:SetBackColor(Turbine.UI.Color(.79, .79, .79));

    self.BorderHeader = Turbine.UI.Control();
    self.BorderHeader:SetParent(self);
    self.BorderHeader:SetSize(Settings.UI.PlayerTrackerWindow.Width, 2);
    self.BorderHeader:SetPosition(0, 40);
    self.BorderHeader:SetBackColor(Turbine.UI.Color(.79, .79, .79));

    self.BorderLeft = Turbine.UI.Control();
    self.BorderLeft:SetParent(self);
    self.BorderLeft:SetSize(2, Settings.UI.PlayerTrackerWindow.Height);
    self.BorderLeft:SetPosition(0, 0);
    self.BorderLeft:SetBackColor(Turbine.UI.Color(.79, .79, .79));

    self.BorderRight = Turbine.UI.Control();
    self.BorderRight:SetParent(self);
    self.BorderRight:SetSize(2, Settings.UI.PlayerTrackerWindow.Height);
    self.BorderRight:SetPosition(Settings.UI.PlayerTrackerWindow.Width - 2, 0);
    self.BorderRight:SetBackColor(Turbine.UI.Color(.79, .79, .79));

    self.BorderBottom = Turbine.UI.Control();
    self.BorderBottom:SetParent(self);
    self.BorderBottom:SetSize(Settings.UI.PlayerTrackerWindow.Width, 2);
    self.BorderBottom:SetPosition(0, Settings.UI.PlayerTrackerWindow.Height - 2);
    self.BorderBottom:SetBackColor(Turbine.UI.Color(.79, .79, .79));

    self.Title = Turbine.UI.Label();
    self.Title:SetParent(self);
    self.Title:SetPosition(0, 0);
    self.Title:SetSize(Settings.UI.PlayerTrackerWindow.Width, 40);
    self.Title:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
    self.Title:SetFont(Turbine.UI.Lotro.Font["TrajanProBold22"]);
    self.Title:SetFontStyle(Turbine.UI.FontStyle.Outline);
    self.Title:SetForeColor(Turbine.UI.Color(0.88, 0.77, 0.1));
    self.Title:SetText(Texts.UI.PlayerTracker.InterferingPlayers);

    self.scrollBar = Turbine.UI.Lotro.ScrollBar();
    self.scrollBar:SetOrientation(Turbine.UI.Orientation.Vertical);
    self.scrollBar:SetParent(self);
    self.scrollBar:SetSize(10, Settings.UI.PlayerTrackerWindow.Height - 40 - 4);
    self.scrollBar:SetPosition(Settings.UI.PlayerTrackerWindow.Width - 14, 42);
    self.scrollBar:SetZOrder(2000);

    -- list to contain the drop down items
    self.Body = Turbine.UI.ListBox();
    self.Body:SetParent(self);
    self.Body:SetOrientation(Turbine.UI.Orientation.Horizontal);
    self.Body:SetVerticalScrollBar(self.scrollBar);
    self.Body:SetMaxItemsPerLine(1);
    self.Body:SetMouseVisible(false);
    self.Body:SetSize(Settings.UI.PlayerTrackerWindow.Width - 4, Settings.UI.PlayerTrackerWindow.Height - 40 - 4);
    self.Body:SetPosition(2, 42);
end

function PlayerTrackerWindow:AddPlayer(playerName)
    local playerBadge = self:GetPlayerControl(playerName);
    if playerBadge == nil then
        playerBadge = Turbine.UI.Control();
        playerBadge.timestamp = Turbine.Engine.GetGameTime();
        playerBadge:SetSize(Settings.UI.PlayerTrackerWindow.Width, 30);
        playerBadge.Label = Turbine.UI.Label();
        playerBadge.Label:SetParent(playerBadge);
        playerBadge.Label:SetSize(Settings.UI.PlayerTrackerWindow.Width - 100 - 25, 30);
        playerBadge.Label:SetPosition(0, 4);
        playerBadge.Label:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
        playerBadge.Label:SetFont(0x420000f1);
        playerBadge.Label:SetText(playerName);
        playerBadge.playerAlias = ShortcutButton();
        playerBadge.playerAlias:SetParent(playerBadge);
        playerBadge.playerAlias:SetPosition(Settings.UI.PlayerTrackerWindow.Width - 100 - 25, 10);
        playerBadge.playerAlias:SetText(Texts.UI.PlayerTracker.InvitePlayer);
        playerBadge.playerAlias:SetShortcut(Turbine.UI.Lotro.ShortcutType.Alias, "/invite " .. playerName);
        playerBadge.Update = function()
            if Turbine.Engine.GetGameTime() - playerBadge.timestamp > 60 then
                playerBadge:SetWantsUpdates(false);
                self.Body:RemoveItem(playerBadge)
                playerBadge.playerAlias:Destroy();
                playerBadge = nil;
            end
        end
        playerBadge:SetWantsUpdates(true);
        self.Body:AddItem(playerBadge);
    else
        playerBadge.timestamp = Turbine.Engine.GetGameTime();
    end
end

function PlayerTrackerWindow:GetPlayerControl(playerName)
    for i = 1, self.Body:GetItemCount() do
        local playerControl = self.Body:GetItem(i);
        if playerControl.Label:GetText() == playerName then return playerControl end;
    end
    return nil;
end

UI.PlayerTrackerWindow = PlayerTrackerWindow();
UI.PlayerTrackerWindow:SetVisible(Settings.UI.PlayerTrackerWindow.Enabled);