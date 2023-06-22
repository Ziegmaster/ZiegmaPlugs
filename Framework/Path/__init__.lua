Framework.Path = {};

--Global plugin folder pointers
Framework.Path.Plugin = Framework.Vendor .. "." .. plugin:GetName();
Framework.Path.Settings = Framework.Path.Plugin .. ".Settings";
Framework.Path.Parser = Framework.Path.Plugin .. ".Parser";
Framework.Path.UI = Framework.Path.Plugin .. ".UI";
Framework.Path.Objects = Framework.Path.Plugin .. ".Objects";
Framework.Path.Locale = Framework.Path.Plugin .. ".Locale";
Framework.Path.Shell = Framework.Path.Plugin .. ".Shell";

--String format path for plugin image resources
Framework.Path.Resources = string.gsub(Framework.Path.Plugin, "%.", "/") .. "/Resources";