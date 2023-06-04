local function ParseDefeatMessage(msg)
    local slayer, prey = string.match(msg, Texts.Parser.DefeatSearchPattern);
    for i, player in pairs(SessionInstance.PlayerGroup) do
        if slayer == Texts.Parser.LocalPlayerAlias or slayer == player:GetName() then
            return slayer, prey, true;
        end
    end
    return slayer, prey, false;
end

AddListener(Turbine.Chat,"Received",function(sender, args)
    --ChatType 1 Error ?
    --ChatType 4 Info (Entered channel)
    --ChatType 5 Info (e.g. Flies follow)
    --ChatType 14 = LP gain e.t.c.
    --ChatType 16 = LFF
    --ChatType 38 = World
    --ChatType 21 = Deeds & Quests?
    --ChatType 25 = RP or Emote
    --ChatType 34 = Combat effect log
    --ChatType 36 = Loot log (Personal)
    --ChatType 37 = Loot log (Group)
    --ChatType 20 = Defeat log
    if args.ChatType == 20 and SessionInstance.StartTime then
        local slayer, prey, isFellow = ParseDefeatMessage(args.Message);
        --Checking if slayer is someone in your party.
        if isFellow then
            local deeds = SessionInstance.Bestiary.CreatureDeeds[prey];
            local output = args.Message .. "\n";
            if deeds then
                local alert = "";
                output = output .. Texts.Parser.DeedsFound;
                for j, deed in pairs(deeds) do
                    output = output .. "\n" .. deed.Name .. " - ";
                    local playersProgressed, localPlayerProgressed = deed:IncrementProgress();
                    if playersProgressed then
                        SessionInstance:UpdateDeedQueue(deed);
                        output = output .. Texts.Parser.ProgressAchieved;
                        if localPlayerProgressed then
                            local lprogress = deed:GetLocalProgress();
                            if string.len(alert) > 0 then alert = alert .. "\n" end;
                            alert = alert .. deed.Name .. "   " .. lprogress.Progress .. "/" .. lprogress.Objective;
                        end
                    else
                        output = output .. Texts.Parser.ProgressDenied;
                    end
                end
                if string.len(alert) > 0 then UI.AlertsWindow:ShowAlert(alert) end;
                UI.ParserWindow.Label:SetText(output);
                UI.DebugWindow.Label:SetText(DumpObject(deeds));
            else
                UI.ParserWindow.Label:SetText(output .. Texts.Parser.NoDeeds);
            end
        else
            local deeds = SessionInstance.Bestiary.CreatureDeeds[prey];
            if deeds then UI.PlayerTrackerWindow:AddPlayer(slayer) end;
        end
    end
end);