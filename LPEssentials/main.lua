import ("ZiegmaPlugs.Framework");

import (Framework.Path.Settings);

Locales = {"EN", "DE (Not Supported)", "FR (Not Supported)", "RU"};

Turbine.PluginData.Load(Turbine.DataScope.Account, Plugin:GetName() .. "_Settings", function(settings)

    if settings then
        Plugin.Settings = table.merge(Plugin.Defaults, Framework.Utils.TableDecode(settings));
    else
        Plugin.Settings = Plugin.Defaults;
    end;

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
        Turbine.Shell.WriteLine(
            "<rgb=#FFBF00>" .. Plugin:GetName() .. "</rgb> <rgb=#00FFFF>" ..
            Plugin:GetVersion() .." [<rgb=#bfff00>" .. Plugin.Settings.Locale.Short .. "</rgb>]</rgb> by " ..
            Plugin:GetAuthor()
        );
    end;

    Plugin.Unload = function(sender, args)
        if not sender.RestoreDefaults then
            sender.Settings.UI.MainWindow.xPos, sender.Settings.UI.MainWindow.yPos = sender.UI.MainWindow:GetPosition();
            sender.Settings.UI.MainWindow.Toggle.xPos, sender.Settings.UI.MainWindow.Toggle.yPos = sender.UI.MainWindow.Toggle:GetPosition();
            sender.Settings.UI.AlertsWindow.xPos, sender.Settings.UI.AlertsWindow.yPos = sender.UI.AlertsWindow:GetPosition();
            sender.Settings.Locale.PrevShort = sender.Settings.Locale.Short;
        else
            sender.Settings = sender.Defaults;
        end
        Turbine.PluginData.Save(Turbine.DataScope.Account, sender:GetName() .. "_Settings", Framework.Utils.TableEncode(sender.Settings), function() end);
    end

    Plugin.Settings.Flags.FirstLaunch = false;
end);