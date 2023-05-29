MainWindow = class (LPELotroGoldWindow);

function MainWindow:Constructor()

    LPELotroGoldWindow.Constructor(self);

    self:SetSize(PluginSettings.UI.MainWindow.Width, PluginSettings.UI.MainWindow.Height);
    self:SetPosition(PluginSettings.UI.MainWindow.xPos, PluginSettings.UI.MainWindow.yPos);
    self:SetText("LPEssentials");
    self:SetResizable(false);
    self:SetVisible(PluginSettings.FirstLaunch);

    self.Icon = Turbine.UI.Control();
    self.Icon:SetParent(self);
    self.Icon:SetSize(32, 32);
    self.Icon:SetStretchMode(1);
    self.Icon:SetSize(34, 34);
    self.Icon:SetPosition(222, 0);
    self.Icon:SetBackground(Resources .. "/lpicon.tga");
    self.Icon:SetBackColorBlendMode(Turbine.UI.BlendMode.AlphaBlend);

    self.ButtonContainer = Turbine.UI.Control();
    self.ButtonContainer:SetParent(self);
    self.ButtonContainer:SetSize(PluginSettings.UI.MainWindow.ButtonContainer.Width, PluginSettings.UI.MainWindow.ButtonContainer.Height);
    self.ButtonContainer:SetPosition(PluginSettings.UI.MainWindow.ButtonContainer.xPos, PluginSettings.UI.MainWindow.ButtonContainer.yPos);
    self.ButtonContainer.Buttons = {};

    self.ButtonContainer.Buttons.Parser = Turbine.UI.Lotro.GoldButton();
    self.ButtonContainer.Buttons.Parser:SetSize(PluginSettings.UI.MainWindow.ButtonContainer.ButtonWidth, PluginSettings.UI.MainWindow.ButtonContainer.ButtonHeight);
    self.ButtonContainer.Buttons.Parser:SetPosition(0, 0);
    self.ButtonContainer.Buttons.Parser:SetParent(self.ButtonContainer);
    self.ButtonContainer.Buttons.Parser:SetText(Texts.UI.Buttons.Parser);

    self.ButtonContainer.Buttons.Start = Turbine.UI.Lotro.GoldButton();
    self.ButtonContainer.Buttons.Start:SetSize(PluginSettings.UI.MainWindow.ButtonContainer.ButtonWidth, PluginSettings.UI.MainWindow.ButtonContainer.ButtonHeight);
    self.ButtonContainer.Buttons.Start:SetPosition(0, PluginSettings.UI.MainWindow.ButtonContainer.ButtonHeight + PluginSettings.UI.ElementsDefaultMargin);
    self.ButtonContainer.Buttons.Start:SetParent(self.ButtonContainer);
    self.ButtonContainer.Buttons.Start:SetText(Texts.UI.Buttons.Start);

    self.ButtonContainer.Buttons.Debug = Turbine.UI.Lotro.GoldButton();
    self.ButtonContainer.Buttons.Debug:SetSize(PluginSettings.UI.MainWindow.ButtonContainer.ButtonWidth, PluginSettings.UI.MainWindow.ButtonContainer.ButtonHeight);
    self.ButtonContainer.Buttons.Debug:SetPosition(PluginSettings.UI.MainWindow.ButtonContainer.ButtonWidth + PluginSettings.UI.ElementsDefaultMargin * 2, 0);
    self.ButtonContainer.Buttons.Debug:SetParent(self.ButtonContainer);
    self.ButtonContainer.Buttons.Debug:SetText(Texts.UI.Buttons.Debug);

    self.ButtonContainer.Buttons.Reset = Turbine.UI.Lotro.GoldButton();
    self.ButtonContainer.Buttons.Reset:SetSize(PluginSettings.UI.MainWindow.ButtonContainer.ButtonWidth, PluginSettings.UI.MainWindow.ButtonContainer.ButtonHeight);
    self.ButtonContainer.Buttons.Reset:SetPosition(PluginSettings.UI.MainWindow.ButtonContainer.ButtonWidth + PluginSettings.UI.ElementsDefaultMargin * 2, PluginSettings.UI.MainWindow.ButtonContainer.ButtonHeight + PluginSettings.UI.ElementsDefaultMargin);
    self.ButtonContainer.Buttons.Reset:SetParent(self.ButtonContainer);
    self.ButtonContainer.Buttons.Reset:SetText(Texts.UI.Buttons.Reset);

    self.TimeSpan = Turbine.UI.Lotro.TextBox();
    self.TimeSpan:SetSize(PluginSettings.UI.MainWindow.TimeSpan.Width, PluginSettings.UI.MainWindow.TimeSpan.Height);
    self.TimeSpan:SetPosition(PluginSettings.UI.MainWindow.TimeSpan.xPos, PluginSettings.UI.MainWindow.TimeSpan.yPos);
    self.TimeSpan:SetReadOnly(true);
    self.TimeSpan:SetSelectable(false);
    self.TimeSpan:SetParent(self);
    self.TimeSpan:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);

    self.TimeSpan.Update = function(sender, args)
        sender:SetText(FormatTime(Turbine.Engine.GetGameTime() - SessionInstance.StartTime));
    end

    self.GroupContainer = Turbine.UI.Control();
    self.GroupContainer:SetParent(self);
    self.GroupContainer:SetSize(PluginSettings.UI.MainWindow.GroupContainer.Width, PluginSettings.UI.MainWindow.GroupContainer.Height);
    self.GroupContainer:SetPosition(PluginSettings.UI.MainWindow.GroupContainer.xPos, PluginSettings.UI.MainWindow.GroupContainer.yPos);
    self.GroupContainer.Players = {};

    for i = 1, 6 do
        local badge = Turbine.UI.Lotro.TextBox();
        badge:SetParent(self.GroupContainer);
        badge:SetSize(PluginSettings.UI.MainWindow.GroupContainer.PlayerBadge.Width, PluginSettings.UI.MainWindow.GroupContainer.PlayerBadge.Height);
        badge:SetPosition(0, (i - 1) * PluginSettings.UI.MainWindow.GroupContainer.PlayerBadge.Height + (i - 1) * PluginSettings.UI.ElementsDefaultMargin);
        badge:SetReadOnly(true);
        badge:SetSelectable(false);
        badge.EffectDisplay = Turbine.UI.Lotro.EffectDisplay();
        badge.EffectDisplay:SetParent(badge);
        badge.EffectDisplay:SetSize(20, 20);
        badge.EffectDisplay:SetPosition(4, PluginSettings.UI.MainWindow.GroupContainer.PlayerBadge.Height - 24);
        badge.EffectDisplay:SetVisible(false);
        badge.EffectDisplay:SetZOrder(1);
        badge.EffectTimer = Turbine.UI.Label();
        badge.EffectTimer:SetFont(Turbine.UI.Lotro.Font["VerdanaBold16"]);
        badge.EffectTimer:SetParent(badge);
        badge.EffectTimer:SetSize(70, 20);
        badge.EffectTimer:SetPosition(28, PluginSettings.UI.MainWindow.GroupContainer.PlayerBadge.Height - 24);
        badge.EffectTimer:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
        badge.EffectTimer:SetZOrder(1);
        badge.EffectTimer:SetVisible(false);
        badge.DistanceTrack = Turbine.UI.Label();
        badge.DistanceTrack:SetFont(Turbine.UI.Lotro.Font["VerdanaBold16"]);
        badge.DistanceTrack:SetText(Texts.UI.TFA);
        badge.DistanceTrack:SetParent(badge);
        badge.DistanceTrack:SetSize(40, 20);
        badge.DistanceTrack:SetPosition(100, PluginSettings.UI.MainWindow.GroupContainer.PlayerBadge.Height - 24);
        badge.DistanceTrack:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleRight);
        badge.DistanceTrack:SetZOrder(1);
        badge.DistanceTrack:SetVisible(false);

        badge.Update = function(sender, args)
            local player = SessionInstance.PlayerGroup[i];
            if player then
                if player:GetRace() == 0 then
                    badge.DistanceTrack:SetVisible(true);
                else
                    badge.DistanceTrack:SetVisible(false);
                end
                local trackEffect = badge.EffectDisplay:GetEffect();
                if not trackEffect then
                    local effectList = player:GetEffects();
                    for index = 1, effectList:GetCount() do
                        local effect = effectList:Get(index);
                        if effect:GetName() == Texts.UI.EffectTracker.SlayerDeedAcceleration then
                            badge.EffectDisplay:SetEffect(effect);
                            badge.EffectDisplay:SetVisible(true);
                            badge.EffectTimer:SetVisible(true);
                            return;
                        end
                    end
                else
                    local effectTime = trackEffect:GetDuration() - (Turbine.Engine.GetGameTime() - trackEffect:GetStartTime());
                    if effectTime > 0 then
                        badge.EffectTimer:SetText(FormatTime(effectTime));
                    else
                        badge.EffectDisplay:SetEffect(nil);
                        badge.EffectDisplay:SetVisible(false);
                        badge.EffectTimer:SetText(nil);
                        badge.EffectTimer:SetVisible(false);
                    end
                end
            end
        end

        badge:SetWantsUpdates(true);
        table.insert(self.GroupContainer.Players, badge);
    end

    self.GroupContainer.Fill = function()
        SessionInstance:SetGroup();
        for i=1, 6 do
            local player = SessionInstance.PlayerGroup[i];
            local badge = UI.MainWindow.GroupContainer.Players[i];
            --Turbine.Shell.WriteLine(DumpObject(player));
            if player then
                badge:SetText(player:GetName());
                badge:SetBackColor(UI.PlayerColors[i]);
                for j, deedBadge in pairs(UI.MainWindow.DeedContainer.Objects) do
                    deedBadge.PlayerProgress[i]:SetBackColor(UI.PlayerColors[i]);
                end
            else
                badge:SetText(nil);
                badge:SetBackColor(nil);
                badge.EffectDisplay:SetEffect(nil);
                badge.EffectDisplay:SetVisible(false);
                badge.EffectTimer:SetText(nil);
                badge.EffectTimer:SetVisible(false);
                badge.DistanceTrack:SetVisible(false);
                for j, deedBadge in pairs(UI.MainWindow.DeedContainer.Objects) do
                    deedBadge.PlayerProgress[i]:SetBackColor(nil);
                end
            end
        end
    end

    self.DeedContainer = Turbine.UI.Control();
    self.DeedContainer:SetParent(self);
    self.DeedContainer:SetSize(PluginSettings.UI.MainWindow.DeedContainer.Width, PluginSettings.UI.MainWindow.DeedContainer.Height);
    self.DeedContainer:SetPosition(PluginSettings.UI.MainWindow.DeedContainer.xPos, PluginSettings.UI.MainWindow.DeedContainer.yPos);
    self.DeedContainer:SetWantsUpdates(false);
    self.DeedContainer.Objects = {};
    self.DeedContainer.Hint = Turbine.UI.Label();
    self.DeedContainer.Hint:SetSize(self.DeedContainer:GetSize());
    self.DeedContainer.Hint:SetParent(self.DeedContainer);
    self.DeedContainer.Hint:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
    self.DeedContainer.Hint:SetFont(Turbine.UI.Lotro.Font["VerdanaBold16"]);
    self.DeedContainer.Hint:SetText(Texts.UI.Hint);

    self.DeedContainer.Update = function(sender, args)
        for index, deedBadge in pairs(sender.Objects) do
            local deed = SessionInstance.DeedQueue[index];
            if deed then
                local level = type(deed.Level) ~= "table" and deed.Level or table.concat(deed.Level, "|");
                deedBadge.DeedName:SetText("[" .. level .. "] " .. deed.Name);
                deedBadge.DeedLocation:SetText(deed.Location);
                for i, player in pairs(SessionInstance.PlayerGroup) do
                    local progress = deed.PlayerProgress[player:GetName()];
                    if progress then
                        deedBadge.PlayerProgress[i]:SetText(progress[#progress] .. "/" .. deed.Objective * #progress);
                    else
                        deedBadge.PlayerProgress[i]:SetText("");
                    end
                end
                deedBadge:SetVisible(true);
            else
                deedBadge:SetVisible(false);
            end
        end
    end

    for i = 1, 6 do
        local badge = Turbine.UI.Control();
        badge:SetParent(self.DeedContainer);
        badge:SetVisible(false);
        badge:SetSize(PluginSettings.UI.MainWindow.DeedContainer.DeedBadge.Width, PluginSettings.UI.MainWindow.DeedContainer.DeedBadge.Height);
        badge:SetPosition(0, (i - 1) * PluginSettings.UI.MainWindow.DeedContainer.DeedBadge.Height + (i - 1) * PluginSettings.UI.ElementsDefaultMargin);
        badge.DeedName = Turbine.UI.TextBox();
        badge.DeedName:SetReadOnly(true);
        badge.DeedName:SetSelectable(false);
        badge.DeedName:SetParent(badge);
        badge.DeedName:SetSize(PluginSettings.UI.MainWindow.DeedContainer.DeedBadge.Width/6*4, PluginSettings.UI.MainWindow.DeedContainer.DeedBadge.Height/2);
        badge.DeedName:SetPosition(0,0);
        badge.DeedName:SetFont(Turbine.UI.Lotro.Font["VerdanaBold16"]);
        badge.DeedName:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
        badge.DeedLocation = Turbine.UI.TextBox();
        badge.DeedLocation:SetReadOnly(true);
        badge.DeedLocation:SetSelectable(false);
        badge.DeedLocation:SetParent(badge);
        badge.DeedLocation:SetSize(PluginSettings.UI.MainWindow.DeedContainer.DeedBadge.Width/6*2, PluginSettings.UI.MainWindow.DeedContainer.DeedBadge.Height/2);
        badge.DeedLocation:SetPosition(PluginSettings.UI.MainWindow.DeedContainer.DeedBadge.Width/6*4, 0);
        badge.DeedLocation:SetFont(Turbine.UI.Lotro.Font["VerdanaBold16"]);
        badge.DeedLocation:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleRight);
        badge.PlayerProgress = {};
        for j=1, 6 do
            local playerProgress = Turbine.UI.Lotro.TextBox();
            playerProgress:SetParent(badge);
            playerProgress:SetSize(PluginSettings.UI.MainWindow.DeedContainer.DeedBadge.Width/6, PluginSettings.UI.MainWindow.DeedContainer.DeedBadge.Height/2);
            playerProgress:SetFont(Turbine.UI.Lotro.Font["Verdana14"]);
            playerProgress:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleCenter);
            playerProgress:SetPosition(PluginSettings.UI.MainWindow.DeedContainer.DeedBadge.Width/6 * (j - 1), PluginSettings.UI.MainWindow.DeedContainer.DeedBadge.Height/2);
            playerProgress:SetReadOnly(true);
            playerProgress:SetSelectable(false);
            table.insert(badge.PlayerProgress, playerProgress);
        end
        table.insert(self.DeedContainer.Objects, badge);
    end
    
end

UI.MainWindow = MainWindow();