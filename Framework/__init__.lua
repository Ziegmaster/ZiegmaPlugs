import "Turbine";
import "Turbine.Gameplay";
import "Turbine.UI";
import "Turbine.UI.Lotro";

_G.Plugin = plugin;
_G.Framework = {};

Framework.Const = {};
Framework.Const.SCREEN_WIDTH = Turbine.UI.Display.GetWidth();
Framework.Const.SCREEN_HEIGHT = Turbine.UI.Display.GetHeight();

Framework.Vendor = "ZiegmaPlugs";
Framework.SelfPath = Framework.Vendor .. ".Framework";

import (Framework.SelfPath .. ".Path");
import (Framework.SelfPath .. ".Utils");
import (Framework.SelfPath .. ".UI");