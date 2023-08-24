ShellCommand = Turbine.ShellCommand();

function ShellCommand:Execute(_, str)
    if str == nil or string.len(str) == 0 then
        return
    end
    if str == 'help' then
        Turbine.Shell.WriteLine(Texts.ShellCommands.Help);
    elseif str == 'reload' then
        Turbine.PluginManager.LoadPlugin("LPEReloader");
    elseif str == 'restore' then
        Plugin.RestoreDefaults = true;
        Turbine.PluginManager.LoadPlugin("LPEReloader");
    end
end

Turbine.Shell.AddCommand('lpe', ShellCommand);