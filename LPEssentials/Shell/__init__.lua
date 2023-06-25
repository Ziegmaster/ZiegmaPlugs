ShellCommand = Turbine.ShellCommand();

function ShellCommand:Execute(_, str)
    if str == nil or string.len(str) == 0 then
        return
    end
    if str == 'help' then
        Turbine.Shell.WriteLine("<rgb=#FFBF00>" .. Plugin:GetName() .. "</rgb> commands:" ..
            "\n<rgb=#FFBF00>/lpe <rgb=#bfff00>reload</rgb></rgb>\nReload plugin (might be helpful if something got bugged)." ..
            "\n<rgb=#FFBF00>/lpe <rgb=#bfff00>restore</rgb></rgb>\nRestore plugin's default settings and reload."
        );
    elseif str == 'reload' then
        Turbine.PluginManager.LoadPlugin("LPEReloader");
    elseif str == 'restore' then
        Plugin.RestoreDefaults = true;
        Turbine.PluginManager.LoadPlugin("LPEReloader");
    end
end

Turbine.Shell.AddCommand('lpe', ShellCommand);