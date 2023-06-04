_G.Path = {};

--Global vendor folder pointers

Path.Vendor = "ZiegmaPlugs";
Path.Plugin = Path.Vendor .. "." .. plugin:GetName();
Path.Utils = Path.Vendor .. ".Utils";

--Global plugin folder pointers

Path.Settings = Path.Plugin .. ".Settings";
Path.Parser = Path.Plugin .. ".Parser";
Path.UI = Path.Plugin .. ".UI";
Path.Objects = Path.Plugin .. ".Objects";

--String format path for image resources
Path.Resources = string.gsub(Path.Plugin, "%.", "/") .. "/Resources";