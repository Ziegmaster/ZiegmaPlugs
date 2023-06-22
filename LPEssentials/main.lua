import ("ZiegmaPlugs.Framework");

import (Framework.Path.Settings);

Locales = {"EN", "DE (Not Supported)", "FR (Not Supported)", "RU"};

Turbine.PluginData.Load(Turbine.DataScope.Account, Plugin:GetName() .. "_Settings", function(data)

    if data then Plugin.Settings = table.merge(Plugin.Settings, Framework.Utils.TableDecode(data)) end;

    import (Framework.Path.Plugin .. ".Locale." .. Plugin.Settings.Locale.Short);
    import (Framework.Path.Objects);
    import (Framework.Path.Parser);
    import (Framework.Path.Shell);
    import (Framework.Path.UI);

    Plugin.LocalPlayer = Turbine.Gameplay.LocalPlayer:GetInstance();
    Plugin.PlayerTracker = Objects.PlayerTracker();
    function Start() CurrentSession = Objects.Session() end
    function Stop() CurrentSession = nil end

    Plugin.Load = function(sender, args)
        Framework.Utils.PluginUnload("LPEReloader");
        Turbine.Shell.WriteLine(Plugin:GetName() .. " " .. Plugin:GetVersion() .." [" .. Plugin.Settings.Locale.Short .. "] by " .. Plugin:GetAuthor());
        Plugin.Settings.FirstLaunch = false;
    end;

    Plugin.Unload = function(sender, args)
        sender.Settings.UI.MainWindow.xPos, sender.Settings.UI.MainWindow.yPos = sender.UI.MainWindow:GetPosition();
        sender.Settings.UI.MainWindow.Toggle.xPos, sender.Settings.UI.MainWindow.Toggle.yPos = sender.UI.MainWindow.Toggle:GetPosition();
        sender.Settings.UI.AlertsWindow.xPos, sender.Settings.UI.AlertsWindow.yPos = sender.UI.AlertsWindow:GetPosition();
        Turbine.PluginData.Save(Turbine.DataScope.Account, sender:GetName() .. "_Settings", Framework.Utils.TableEncode(sender.Settings), function() end);
    end
end);