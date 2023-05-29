_G.VendorDirectory = "ZiegmaPlugs";

_G.UtilsDirectory = VendorDirectory .. ".Utils";
_G.PluginDirectory = VendorDirectory .. "." .. plugin:GetName();

_G.SettingsDirectory = PluginDirectory .. ".Settings";
_G.ParserDirectory = PluginDirectory .. ".Parser";
_G.UIDirectory = PluginDirectory .. ".UI";
_G.ObjectsDirectory = PluginDirectory .. ".Objects";
_G.DeedsDirectory = ObjectsDirectory .. ".Deeds";

_G.Resources = string.gsub(PluginDirectory, "%.", "/") .. "/Resources";