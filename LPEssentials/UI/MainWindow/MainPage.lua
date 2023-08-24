MainPage = class(Turbine.UI.Control);

function MainPage:Constructor(container)

    Turbine.UI.Control.Constructor(self);

    self:SetParent(container);
    self:SetSize(Plugin.Settings.UI.MainWindow.PageContentWidth, Plugin.Settings.UI.MainWindow.PageContentHeight);
    self:SetPosition(Plugin.Settings.UI.WindowEdgeMargin, Plugin.Settings.UI.WindowEdgeMargin);
    
    self.GroupContainer = Turbine.UI.Control();
    self.GroupContainer:SetParent(self);
    self.GroupContainer:SetSize(Plugin.Settings.UI.MainWindow.GroupContainer.Width, Plugin.Settings.UI.MainWindow.GroupContainer.Height);
    self.GroupContainer:SetVisible(false);
    self.GroupContainer.PlayerSlots = {};
    
    for i = 1, 6 do
        local player_slot = Framework.UI.Controls.BorderedControl(
            Plugin.Settings.UI.MainWindow.GroupContainer.PlayerSlot.Width,
            Plugin.Settings.UI.MainWindow.GroupContainer.PlayerSlot.Height,
            Plugin.Settings.UI.DefaultBorderWidth,
            Turbine.UI.Color(1, 0.2, 0.2, 0.3)
        );
        player_slot:SetParent(self.GroupContainer);
        player_slot:SetPosition(0, (i - 1) * Plugin.Settings.UI.MainWindow.GroupContainer.PlayerSlot.Height + (i - 1) * Plugin.Settings.UI.ElementsDefaultMargin);
        player_slot.PlayerColor = Framework.UI.Controls.BorderedControl(
            18,
            Plugin.Settings.UI.MainWindow.GroupContainer.PlayerSlot.Height - 4,
            Plugin.Settings.UI.DefaultBorderWidth,
            Turbine.UI.Color(1, 0.2, 0.2, 0.3)
        );
        player_slot.PlayerColor.BorderLeft:SetVisible(false);
        player_slot.PlayerColor.BorderTop:SetVisible(false);
        player_slot.PlayerColor.BorderBottom:SetVisible(false);
        player_slot.PlayerColor:SetParent(player_slot);
        player_slot.PlayerColor:SetPosition(2, 2);
        player_slot.PlayerColor:SetBackColor(Framework.UI.PlayerColors[i]);
        player_slot.PlayerName = Turbine.UI.Label();
        player_slot.PlayerName:SetFont(Framework.UI.Fonts.VerdanaBold16);
        player_slot.PlayerName:SetForeColor(Plugin.Settings.UI.DefaultFontColor);
        player_slot.PlayerName:SetParent(player_slot);
        player_slot.PlayerName:SetSize(Plugin.Settings.UI.MainWindow.GroupContainer.PlayerSlot.Width - Plugin.Settings.UI.DefaultBorderWidth * 4 - 20, 20);
        player_slot.PlayerName:SetPosition(24, 4);
        player_slot.PlayerName:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
        player_slot.EffectDisplay = Turbine.UI.Lotro.EffectDisplay();
        player_slot.EffectDisplay:SetParent(player_slot);
        player_slot.EffectDisplay:SetSize(24, 24);
        player_slot.EffectDisplay:SetPosition(24, 26);
        player_slot.EffectDisplay:SetVisible(false);
        player_slot.EffectDisplay:SetZOrder(1);
        player_slot.EffectTimer = Turbine.UI.Label();
        player_slot.EffectTimer:SetFont(Framework.UI.Fonts.VerdanaBold16);
        player_slot.EffectTimer:SetForeColor(Plugin.Settings.UI.DefaultFontColor);
        player_slot.EffectTimer:SetParent(player_slot);
        player_slot.EffectTimer:SetSize(70, 20);
        player_slot.EffectTimer:SetPosition(48, 28);
        player_slot.EffectTimer:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
        player_slot.EffectTimer:SetZOrder(1);
        player_slot.EffectTimer:SetVisible(false);
        player_slot.DistanceTrack = Turbine.UI.Label();
        player_slot.DistanceTrack:SetFont(Framework.UI.Fonts.VerdanaBold16);
        player_slot.DistanceTrack:SetForeColor(Plugin.Settings.UI.DefaultFontColor);
        player_slot.DistanceTrack:SetText(Texts.UI.TFA);
        player_slot.DistanceTrack:SetParent(player_slot);
        player_slot.DistanceTrack:SetSize(Plugin.Settings.UI.MainWindow.GroupContainer.PlayerSlot.Width - Plugin.Settings.UI.DefaultBorderWidth * 4 - 20, 20);
        player_slot.DistanceTrack:SetPosition(24, Plugin.Settings.UI.MainWindow.GroupContainer.PlayerSlot.Height - 24);
        player_slot.DistanceTrack:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
        player_slot.DistanceTrack:SetZOrder(1);
        player_slot.DistanceTrack:SetVisible(false);
    
        table.insert(self.GroupContainer.PlayerSlots, player_slot);
    end
    
    self.GroupContainer.Fill = function()
        for i=1, 6 do
            local player = CurrentSession.PlayerGroup[i];
            local player_slot = self.GroupContainer.PlayerSlots[i];
            if player then
                player_slot.PlayerName:SetText(player:GetName());
                player_slot.PlayerColor:SetVisible(true);
                for j, deed_slot in pairs(self.DeedContainer.Objects) do
                    deed_slot.PlayersProgress[i]:SetBackColor(Framework.UI.PlayerColors[i]);
                end
            else
                player_slot.PlayerColor:SetVisible(false);
                player_slot.PlayerName:SetText(nil);
                player_slot.EffectDisplay:SetEffect(nil);
                player_slot.EffectDisplay:SetVisible(false);
                player_slot.EffectTimer:SetText(nil);
                player_slot.EffectTimer:SetVisible(false);
                player_slot.DistanceTrack:SetVisible(false);
                for j, deed_slot in pairs(self.DeedContainer.Objects) do
                    deed_slot.PlayersProgress[i]:SetBackColor(nil);
                end
            end
        end
    end
    
    self.GroupContainer.Update = function ()
        for i=1, 6 do
            local player_slot = self.GroupContainer.PlayerSlots[i];
            local effect = Plugin.PlayerTracker.TrackSlots[i].AccelerationEffect;
            if Plugin.PlayerTracker.TrackSlots[i].AccelerationTime > 0 then
                player_slot.EffectDisplay:SetEffect(effect);
                player_slot.EffectDisplay:SetVisible(true);
                player_slot.EffectTimer:SetText(Framework.Utils.FormatTime(Plugin.PlayerTracker.TrackSlots[i].AccelerationTime));
                player_slot.EffectTimer:SetVisible(true);
            else
                player_slot.EffectDisplay:SetEffect(nil);
                player_slot.EffectDisplay:SetVisible(false);
                player_slot.EffectTimer:SetText("");
                player_slot.EffectTimer:SetVisible(false);
            end
            player_slot.DistanceTrack:SetVisible(Plugin.PlayerTracker.TrackSlots[i].TFA);
        end
    end
    
    self.DeedContainer = Framework.UI.Controls.BorderedControl(
        Plugin.Settings.UI.MainWindow.DeedContainer.Width,
        Plugin.Settings.UI.MainWindow.DeedContainer.Height,
        Plugin.Settings.UI.DefaultBorderWidth,
        Turbine.UI.Color(1, 0.2, 0.2, 0.3)
    );
    self.DeedContainer:SetParent(self);
    self.DeedContainer:SetPosition(Plugin.Settings.UI.MainWindow.DeedContainer.xPos, Plugin.Settings.UI.MainWindow.DeedContainer.yPos);
    self.DeedContainer:SetWantsUpdates(false);
    self.DeedContainer:SetVisible(false);
    self.DeedContainer.Objects = {};
    
    self.DeedContainer.Update = function(sender, args)
        if CurrentSession then
            for index, deed_slot in pairs(sender.Objects) do
                local deed = CurrentSession.DeedQueue[index];
                if deed then
                    local level = type(deed.Level) ~= "table" and deed.Level or table.concat(deed.Level, "|");
                    deed_slot.DeedName:SetText("[" .. level .. "] " .. deed.Name);
                    deed_slot.DeedLocation:SetText(deed.Location);
                    for i, player in pairs(CurrentSession.PlayerGroup) do
                        local progress = deed.PlayersProgress[player:GetName()];
                        if progress then
                            deed_slot.PlayersProgress[i].Label:SetText(progress[#progress] .. "/" .. deed.Objective * #progress);
                        else
                            deed_slot.PlayersProgress[i].Label:SetText("");
                        end
                    end
                    deed_slot:SetVisible(true);
                else
                    deed_slot:SetVisible(false);
                end
            end
        end
    end
    
    for i = 1, 6 do
        local deed_slot = Framework.UI.Controls.BorderedControl(
            Plugin.Settings.UI.MainWindow.DeedContainer.DeedSlot.Width,
            Plugin.Settings.UI.MainWindow.DeedContainer.DeedSlot.Height,
            Plugin.Settings.UI.DefaultBorderWidth,
            Turbine.UI.Color(1, 0.2, 0.2, 0.3)
        );
        deed_slot.BorderTop:SetVisible(false);
        deed_slot.BorderBottom:SetVisible(false);
        deed_slot:SetParent(self.DeedContainer);
        deed_slot:SetVisible(false);
        deed_slot:SetPosition(0, (i - 1) * Plugin.Settings.UI.MainWindow.DeedContainer.DeedSlot.Height + (i - 1) * Plugin.Settings.UI.ElementsDefaultMargin);
        deed_slot.DeedName = Turbine.UI.Label();
        deed_slot.DeedName:SetParent(deed_slot);
        deed_slot.DeedName:SetSize(Plugin.Settings.UI.MainWindow.DeedContainer.DeedSlot.Width/6*4, Plugin.Settings.UI.MainWindow.DeedContainer.DeedSlot.Height/2);
        deed_slot.DeedName:SetPosition(Plugin.Settings.UI.ElementsDefaultMargin, 0);
        deed_slot.DeedName:SetFont(Framework.UI.Fonts.VerdanaBold16);
        deed_slot.DeedName:SetForeColor(Plugin.Settings.UI.DefaultFontColor);
        deed_slot.DeedName:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
        deed_slot.DeedLocation = Turbine.UI.Label();
        deed_slot.DeedLocation:SetParent(deed_slot);
        deed_slot.DeedLocation:SetSize(Plugin.Settings.UI.MainWindow.DeedContainer.DeedSlot.Width/6*2, Plugin.Settings.UI.MainWindow.DeedContainer.DeedSlot.Height/2);
        deed_slot.DeedLocation:SetPosition(Plugin.Settings.UI.MainWindow.DeedContainer.DeedSlot.Width/6*4 - Plugin.Settings.UI.ElementsDefaultMargin, 0);
        deed_slot.DeedLocation:SetFont(Framework.UI.Fonts.VerdanaBold16);
        deed_slot.DeedLocation:SetForeColor(Plugin.Settings.UI.DefaultFontColor);
        deed_slot.DeedLocation:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleRight);
        deed_slot.PlayersProgress = {};
        for j=1, 6 do
            local player_progress = Framework.UI.Controls.BorderedControl(
                Plugin.Settings.UI.MainWindow.DeedContainer.DeedSlot.Width/6,
                Plugin.Settings.UI.MainWindow.DeedContainer.DeedSlot.Height/2,
                Plugin.Settings.UI.DefaultBorderWidth,
                Turbine.UI.Color(1, 0.2, 0.2, 0.3)
            );
            player_progress.BorderRight:SetVisible(false);
            player_progress:SetParent(deed_slot);
            player_progress:SetPosition(Plugin.Settings.UI.MainWindow.DeedContainer.DeedSlot.Width/6 * (j - 1), Plugin.Settings.UI.MainWindow.DeedContainer.DeedSlot.Height/2);
            player_progress.Label = Turbine.UI.Label();
            player_progress.Label:SetParent(player_progress);
            player_progress.Label:SetSize(player_progress:GetSize());
            player_progress.Label:SetFont(Framework.UI.Fonts.VerdanaBold16);
            player_progress.Label:SetForeColor(Plugin.Settings.UI.DefaultFontColor);
            player_progress.Label:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
            table.insert(deed_slot.PlayersProgress, player_progress);
        end
        table.insert(self.DeedContainer.Objects, deed_slot);
    end
    
    self.DevMessage = Framework.UI.Controls.BorderedControl(
        Plugin.Settings.UI.MainWindow.PageContentWidth,
        Plugin.Settings.UI.MainWindow.GroupContainer.Height,
        Plugin.Settings.UI.DefaultBorderWidth,
        Turbine.UI.Color(1, 0.2, 0.2, 0.3)
    );
    self.DevMessage:SetParent(self);
    self.DevMessage.Label = Turbine.UI.Label();
    self.DevMessage.Label:SetParent(self.DevMessage);
    self.DevMessage.Label:SetSize(
        Plugin.Settings.UI.MainWindow.PageContentWidth - Plugin.Settings.UI.WindowEdgeMargin * 2,
        Plugin.Settings.UI.MainWindow.GroupContainer.Height - Plugin.Settings.UI.WindowEdgeMargin * 2
    );
    self.DevMessage.Label:SetPosition(Plugin.Settings.UI.WindowEdgeMargin, Plugin.Settings.UI.WindowEdgeMargin);
    self.DevMessage.Label:SetTextAlignment(Turbine.UI.ContentAlignment.TopLeft);
    self.DevMessage.Label:SetFont(Framework.UI.Fonts.VerdanaBold16);
    self.DevMessage.Label:SetForeColor(Plugin.Settings.UI.DefaultFontColor);
    self.DevMessage.Label:SetText(Texts.UI.DevMessage);
    
    self.TimeSpan = Framework.UI.Controls.BorderedControl(
        Plugin.Settings.UI.MainWindow.Page1Footer.ControlsWidth,
        Plugin.Settings.UI.MainWindow.Page1Footer.ControlsHeight,
        Plugin.Settings.UI.DefaultBorderWidth,
        Turbine.UI.Color(1, 0.2, 0.2, 0.3)
    );
    self.TimeSpan:SetParent(self);
    self.TimeSpan:SetPosition(0, Plugin.Settings.UI.MainWindow.Page1Footer.ControlsYPos);
    self.TimeSpan.Label = Turbine.UI.Label();
    self.TimeSpan.Label:SetParent(self.TimeSpan);
    self.TimeSpan.Label:SetSize(self.TimeSpan:GetSize());
    self.TimeSpan.Label:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
    self.TimeSpan.Label:SetFont(Framework.UI.Fonts.TrajanProBold30);
    self.TimeSpan.Label:SetForeColor(Plugin.Settings.UI.DefaultFontColor);
    self.TimeSpan.Label:SetText(Framework.Utils.FormatTime(0));
    self.TimeSpan.Label.Update = function ()
        self.TimeSpan.Label:SetText(Framework.Utils.FormatTime(Turbine.Engine.GetGameTime() - CurrentSession.StartTime)); 
    end
    
    self.StartButton = Framework.UI.Controls.BorderedControl(
        Plugin.Settings.UI.MainWindow.Page1Footer.ControlsWidth,
        Plugin.Settings.UI.MainWindow.Page1Footer.ControlsHeight,
        Plugin.Settings.UI.DefaultBorderWidth,
        Turbine.UI.Color(1, 0.2, 0.2, 0.3)
    );
    self.StartButton:SetParent(self);
    self.StartButton:SetPosition(
        Plugin.Settings.UI.MainWindow.Page1Footer.ControlsWidth + Plugin.Settings.UI.ElementsDefaultMargin,
        Plugin.Settings.UI.MainWindow.Page1Footer.ControlsYPos
    );
    self.StartButton:SetBackColor(Turbine.UI.Color(0.18,0.42,0.18));
    self.StartButton.Label = Turbine.UI.Label();
    self.StartButton.Label:SetParent(self.StartButton);
    self.StartButton.Label:SetSize(self.StartButton:GetSize());
    self.StartButton.Label:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
    self.StartButton.Label:SetFont(Framework.UI.Fonts.TrajanProBold30);
    self.StartButton.Label:SetForeColor(Plugin.Settings.UI.DefaultFontColor);
    self.StartButton.Label:SetText(Texts.UI.Start);
    self.StartButton.Label:SetMouseVisible(false);
    self.StartButton.MouseClick = function (args)
        if CurrentSession then
            Stop();
            self.TimeSpan.Label:SetWantsUpdates(false);
            self.StartButton.Label:SetText(Texts.UI.Start);
            self.StartButton:SetBackColor(Turbine.UI.Color(0.18,0.42,0.18));
            self.GroupContainer:SetVisible(false);
            self.DeedContainer:SetVisible(false);
            self.DevMessage:SetVisible(true);
        else
            Start();
            self.TimeSpan.Label:SetWantsUpdates(true);
            self.StartButton.Label:SetText(Texts.UI.Stop);
            self.StartButton:SetBackColor(Turbine.UI.Color(0.7, 0.1, 0.1));
            self.DevMessage:SetVisible(false);
            self.GroupContainer:Fill();
            self.GroupContainer:SetWantsUpdates(true);
            self.GroupContainer:SetVisible(true);
            self.DeedContainer:SetWantsUpdates(true);
            self.DeedContainer:SetVisible(true);
            self.LPCounter.PointsLabel2:SetText(0);
        end
    end
    
    self.StartButton.MouseEnter = function (args)
        if CurrentSession then
            self.StartButton:SetBackColor(Turbine.UI.Color(0.7, 0, 0));
        else
            self.StartButton:SetBackColor(Turbine.UI.Color(0.08,0.42,0.13));
        end
    end
    
    self.StartButton.MouseLeave = function (args)
        if CurrentSession then
            self.StartButton:SetBackColor(Turbine.UI.Color(0.7, 0.1, 0.1));
        else
            self.StartButton:SetBackColor(Turbine.UI.Color(0.18,0.42,0.18));
        end
    end
    
    
    self.LPCounter = Framework.UI.Controls.BorderedControl(
        Plugin.Settings.UI.MainWindow.Page1Footer.ControlsWidth,
        Plugin.Settings.UI.MainWindow.Page1Footer.ControlsHeight,
        Plugin.Settings.UI.DefaultBorderWidth,
        Turbine.UI.Color(1, 0.2, 0.2, 0.3)
    );
    self.LPCounter:SetParent(self);
    self.LPCounter:SetPosition(
        (Plugin.Settings.UI.MainWindow.Page1Footer.ControlsWidth + Plugin.Settings.UI.ElementsDefaultMargin) * 2,
        Plugin.Settings.UI.MainWindow.Page1Footer.ControlsYPos
    );

    self.LPCounter.PointsIcon = Turbine.UI.Control();
    self.LPCounter.PointsIcon:SetParent(self.LPCounter);
    self.LPCounter.PointsIcon:SetSize(32, 32);
    self.LPCounter.PointsIcon:SetStretchMode(1);
    self.LPCounter.PointsIcon:SetSize(Plugin.Settings.UI.MainWindow.Page1Footer.ControlsHeight * 0.6, Plugin.Settings.UI.MainWindow.Page1Footer.ControlsHeight * 0.6);
    self.LPCounter.PointsIcon:SetPosition(Plugin.Settings.UI.MainWindow.Page1Footer.ControlsHeight * 0.2, Plugin.Settings.UI.MainWindow.Page1Footer.ControlsHeight * 0.2);
    self.LPCounter.PointsIcon:SetBackground(Framework.Path.Resources .. "/lpicon.tga");
    self.LPCounter.PointsIcon:SetBackColorBlendMode(Turbine.UI.BlendMode.AlphaBlend);

    self.LPCounter.PointsLabel1 = Turbine.UI.Label();
    self.LPCounter.PointsLabel1:SetParent(self.LPCounter);
    self.LPCounter.PointsLabel1:SetSize(Plugin.Settings.UI.MainWindow.Page1Footer.ControlsHeight * 1.2, Plugin.Settings.UI.MainWindow.Page1Footer.ControlsHeight * 0.8);
    self.LPCounter.PointsLabel1:SetPosition(Plugin.Settings.UI.MainWindow.Page1Footer.ControlsHeight * 0.7, Plugin.Settings.UI.MainWindow.Page1Footer.ControlsHeight * 0.1);
    self.LPCounter.PointsLabel1:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
    self.LPCounter.PointsLabel1:SetFont(Framework.UI.Fonts.TrajanProBold30);
    self.LPCounter.PointsLabel1:SetForeColor(Plugin.Settings.UI.DefaultFontColor);
    self.LPCounter.PointsLabel1:SetText('LP :');

    self.LPCounter.PointsLabel2 = Turbine.UI.Label();
    self.LPCounter.PointsLabel2:SetParent(self.LPCounter);
    self.LPCounter.PointsLabel2:SetSize(Plugin.Settings.UI.MainWindow.Page1Footer.ControlsWidth - Plugin.Settings.UI.MainWindow.Page1Footer.ControlsHeight * 1.9, Plugin.Settings.UI.MainWindow.Page1Footer.ControlsHeight * 0.8);
    self.LPCounter.PointsLabel2:SetPosition(Plugin.Settings.UI.MainWindow.Page1Footer.ControlsHeight * 1.9, Plugin.Settings.UI.MainWindow.Page1Footer.ControlsHeight * 0.1);
    self.LPCounter.PointsLabel2:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
    self.LPCounter.PointsLabel2:SetFont(Framework.UI.Fonts.TrajanProBold30);
    self.LPCounter.PointsLabel2:SetForeColor(Plugin.Settings.UI.DefaultFontColor);
    self.LPCounter.PointsLabel2:SetText(0);
end