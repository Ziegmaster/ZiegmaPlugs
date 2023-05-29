import "Turbine";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";

import ("ZiegmaPlugs." .. plugin:GetName() .. ".Routing");
import (UtilsDirectory);
import (SettingsDirectory);

_G.PluginSettings = LoadDefaultSettings();
_G.SessionInstance = nil;

PatchDataLoad(Turbine.DataScope.Account, plugin:GetName() .. "_Settings", function(data)

    if data then PluginSettings = table.merge(PluginSettings, data) end;

    import (PluginDirectory .. ".Locale." .. PluginSettings.Locale.Short);
    Turbine.Shell.WriteLine(plugin:GetName() .. " " .. plugin:GetVersion() .." [" .. PluginSettings.Locale.Short .. "] by " .. plugin:GetAuthor());

    AddListener(plugin, "Load", function()

        PluginUnload("LPEReloader");

        PluginSettings.FirstLaunch = false;

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
        PluginSettings.UI.MainWindow.xPos, PluginSettings.UI.MainWindow.yPos = UI.MainWindow:GetPosition();
        PluginSettings.UI.MainWindowToggle.xPos, PluginSettings.UI.MainWindowToggle.yPos = UI.MainWindowToggle:GetPosition();
        PluginSettings.UI.AlertsWindow.xPos, PluginSettings.UI.AlertsWindow.yPos = UI.AlertsWindow:GetPosition();
        PluginSettings.UI.PlayerTrackerWindow.xPos, PluginSettings.UI.PlayerTrackerWindow.yPos = UI.PlayerTrackerWindow:GetPosition();
        PatchDataSave(Turbine.DataScope.Account, sender:GetName() .. "_Settings", PluginSettings, function() end);
    end);

    import (ObjectsDirectory);
    import (UIDirectory);
    import (ParserDirectory);

end);