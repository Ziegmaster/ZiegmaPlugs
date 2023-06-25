local function parse_defeat_message(msg)
    local slayer, prey = string.match(msg, Texts.Parser.DefeatSearchPattern);
    for i, player in pairs(CurrentSession.PlayerGroup) do
        if slayer == Texts.Parser.LocalPlayerAlias or slayer == player:GetName() then
            return slayer, prey, true;
        end
    end
    return slayer, prey, false;
end

local function parse_lp_message(msg)
    return string.match(msg, Texts.Parser.LPSearchPattern);
end

Framework.Utils.AddListener(Turbine.Chat, "Received", function(sender, args)
    if args.ChatType == Turbine.ChatType.Death and CurrentSession then
        local slayer, prey, is_fellow = parse_defeat_message(args.Message);
        --Checking if slayer is someone in your party.
        if is_fellow then
            local deeds = CurrentSession.Bestiary.CreatureDeeds[prey];
            if deeds then
                local message = "";
                for j, deed in pairs(deeds) do
                    local players_progressed, local_player_progressed = deed:IncrementProgress();
                    if players_progressed then
                        CurrentSession:UpdateDeedQueue(deed);
                        if local_player_progressed then
                            local lprogress = deed:GetLocalProgress();
                            if string.len(message) > 0 then message = message .. "\n" end;
                            message = message .. deed.Name .. "   " .. lprogress.Progress .. "/" .. lprogress.Objective;
                        end
                    end
                end
                if string.len(message) > 0 then
                    Plugin.UI.AlertsWindow:SetMessage(message);
                    Plugin.UI.AlertsWindow:ShowAlert();
                end
            end
        end
    end
    if args.ChatType == Turbine.ChatType.Advancement and CurrentSession then
        local lp_earned = parse_lp_message(args.Message);
        if lp_earned then
            local lp_current = tonumber(Plugin.UI.MainWindow.PageWrapper.Pages[1].LPCounter.PointsLabel2:GetText());
            Plugin.UI.MainWindow.PageWrapper.Pages[1].LPCounter.PointsLabel2:SetText(lp_current + lp_earned);
        end
    end
end);