import "Turbine";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";

import ("ZiegmaPlugs.Path");

import (Path.Settings);

import (Path.Utils .. ".LuaTable");
import (Path.Utils .. ".VindarPatch");
import (Path.Utils .. ".Misc");

SessionInstance = nil;

PatchDataLoad(Turbine.DataScope.Account, plugin:GetName() .. "_Settings", function(data)

    Settings = LoadDefaultSettings();

    if data then Settings = table.merge(Settings, data) end;

    import (Path.Plugin .. ".Locale." .. Settings.Locale.Short);
    Turbine.Shell.WriteLine(plugin:GetName() .. " " .. plugin:GetVersion() .." [" .. Settings.Locale.Short .. "] by " .. plugin:GetAuthor());

    AddListener(plugin, "Load", function()

        PluginUnload("LPEReloader");

        Settings.FirstLaunch = false;

        --Start session
        function start()
            SessionInstance:Start();
            UI.MainWindow.TimeSpan:SetWantsUpdates(true);
            UI.MainWindow.DeedContainer.Hint:SetVisible(false);
            UI.MainWindow.DeedContainer:SetWantsUpdates(true);
        end
        
        --Reset session
        function reset()
            SessionInstance = Session();
            UI.MainWindow.TimeSpan:SetWantsUpdates(false);
            UI.MainWindow.TimeSpan:SetText(Texts.UI.PressStart);
            UI.MainWindow.DeedContainer.Hint:SetVisible(true);
        end
    
        AddListener(UI.MainWindow.ButtonContainer.Buttons.Start, "Click", start);
        AddListener(UI.MainWindow.ButtonContainer.Buttons.Reset, "Click", reset);
        AddListener(UI.MainWindow.ButtonContainer.Buttons.Parser, "Click", function(sender, args)
            UI.ParserWindow:SetVisible(true);
            UI.ParserWindow:Activate();
        end);
        AddListener(UI.MainWindow.ButtonContainer.Buttons.Debug, "Click", function(sender, args)
            UI.DebugWindow:SetVisible(true);
            UI.DebugWindow:Activate();
        end);
    
        reset();

        UI.MainWindow.GroupContainer.Fill();

        AddListener(SessionInstance.LocalPlayer, "PartyChanged", function (sender, args)
            UI.MainWindow.GroupContainer.Fill();
            local party = SessionInstance.LocalPlayer:GetParty();
            if party then
                AddListener(party, "MemberAdded", UI.MainWindow.GroupContainer.Fill);
                AddListener(party, "MemberRemoved", UI.MainWindow.GroupContainer.Fill);
            end
        end);
    end);
    
    AddListener(plugin, "Unload", function(sender, args)
        Settings.UI.MainWindow.xPos, Settings.UI.MainWindow.yPos = UI.MainWindow:GetPosition();
        Settings.UI.MainWindowToggle.xPos, Settings.UI.MainWindowToggle.yPos = UI.MainWindowToggle:GetPosition();
        Settings.UI.AlertsWindow.xPos, Settings.UI.AlertsWindow.yPos = UI.AlertsWindow:GetPosition();
        Settings.UI.PlayerTrackerWindow.xPos, Settings.UI.PlayerTrackerWindow.yPos = UI.PlayerTrackerWindow:GetPosition();
        PatchDataSave(Turbine.DataScope.Account, sender:GetName() .. "_Settings", Settings, function() end);
    end);

    import (Path.Objects);
    import (Path.UI);
    import (Path.Parser);

end);