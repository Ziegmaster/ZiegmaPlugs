ShellCommand = Turbine.ShellCommand();

function ShellCommand:Execute(_, str)
    if str == nil or string.len(str) == 0 then
        return
    end
    if str == 'reload' then
        Turbine.PluginManager.LoadPlugin("LPEReloader");
    elseif str == 'dump' then
        Turbine.Shell.WriteLine(Framework.Utils.DumpObject(Plugin.PlayerTracker));
    end
end

Turbine.Shell.AddCommand('lpe', ShellCommand);