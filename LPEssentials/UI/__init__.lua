_G.UI={};

UI.PlayerColors = {
    Turbine.UI.Color( 0.8, 0.0, 0.55, 1.0 ),
    Turbine.UI.Color( 0.8, 1.0, 1.0, 0.0 ),
    Turbine.UI.Color( 0.8, 0.9, 0.1, 0.1 ),
    Turbine.UI.Color( 0.8, 0.1, 0.9, 0.1 ),
    Turbine.UI.Color( 0.8, 0.0, 1.0, 0.9 ),
    Turbine.UI.Color( 0.8, 0.9, 0.1, 0.6 ),
}

UI.Fonts = {
    "Arial12",
    {
        "Courier12",
        0x42000028
    },
    "BookAntiqua12",
    "BookAntiqua14",
    "BookAntiqua16",
    "BookAntiqua18",
    "BookAntiqua20",
    "BookAntiqua22",
    "BookAntiqua24",
    "BookAntiqua26",
    "BookAntiqua28",
    "BookAntiqua32",
    "BookAntiqua36",
    "BookAntiquaBold12",
    "BookAntiquaBold14",
    "BookAntiquaBold18",
    "BookAntiquaBold19",
    "BookAntiquaBold22",
    "BookAntiquaBold24",
    {
        "FixedSys14",
        0x42000027
    },
    "FixedSys15",
    "LucidaConsole12",
    "TrajanPro13",
    "TrajanPro14",
    "TrajanPro15",
    "TrajanPro16",
    "TrajanPro18",
    "TrajanPro19",
    "TrajanPro20",
    "TrajanPro21",
    "TrajanPro23",
    "TrajanPro24",
    "TrajanPro25",
    "TrajanPro26",
    "TrajanPro28",
    "TrajanProBold16",
    "TrajanProBold22",
    "TrajanProBold24",
    "TrajanProBold25",
    "TrajanProBold30",
    "TrajanProBold36",
    "Verdana10",
    "Verdana12",
    "Verdana14",
    "Verdana16",
    "Verdana18",
    "Verdana20",
    "Verdana22",
    "Verdana23",
    "VerdanaBold16",
    {
        "TimesRoman18",
        0x4200000e
    },
    {
        "TimesRoman20",
        0x420000f1
    },
    {
        "TimesRoman22",
        0x420000f4
    },
    {
        "TimesRoman26",
        0x42000169
    },
    {
        "TimesRoman28",
        0x42000168
    },
    {
        "TimesRoman30",
        0x4200016a
    },
    {
        "TimesRoman36",
        0x4200016b
    },
    {
        "TimesRomanBold20",
        0x4200000f
    },
    {
        "TimesRomanBold22",
        0x42000010
    },
}

LPEWindow = class (Turbine.UI.Window);

function LPEWindow:Constructor()

    Turbine.UI.Window.Constructor(self);
    
end

LPELotroWindow = class (Turbine.UI.Lotro.Window);

function LPELotroWindow:Constructor()
    
    Turbine.UI.Lotro.Window.Constructor(self);

    self.HUDVisible = true;

    self:SetWantsKeyEvents(true);
    self.KeyDown = function(sender, args)
        if args.Action == Turbine.UI.Lotro.Action.Escape then
            if self:IsVisible() then self:Close() end;
        elseif args.Action == 0x100000B3 then
            self:ToggleUI();
        end
    end

end

function LPELotroWindow:ToggleUI()

    self.HUDVisible = not self.HUDVisible;
    
    if not self.HUDVisible then
        self.IsVisibleBuffer = self:IsVisible();
        self:SetVisible(self.HUDVisible);
    else
        self:SetVisible(self.IsVisibleBuffer);
    end

end

LPELotroGoldWindow = class (Turbine.UI.Lotro.GoldWindow);

function LPELotroGoldWindow:Constructor()
    
    Turbine.UI.Lotro.GoldWindow.Constructor(self);

    self.HUDVisible = true;

    self:SetWantsKeyEvents(true);
    self.KeyDown = function(sender, args)
        if args.Action == Turbine.UI.Lotro.Action.Escape then
            if self:IsVisible() then self:Close() end;
        elseif args.Action == 0x100000B3 then
            self:ToggleUI();
        end
    end

end

function LPELotroGoldWindow:ToggleUI()

    self.HUDVisible = not self.HUDVisible;
    
    if not self.HUDVisible then
        self.IsVisibleBuffer = self:IsVisible();
        self:SetVisible(self.HUDVisible);
    else
        self:SetVisible(self.IsVisibleBuffer);
    end

end

import (Path.Utils .. ".UI");
import (Path.UI .. ".DebugWindow");
import (Path.UI .. ".ParserWindow");
import (Path.UI .. ".MainWindow");
import (Path.UI .. ".ToggleWindow");
import (Path.UI .. ".AlertsWindow");
import (Path.UI .. ".PlayerTrackerWindow");
import (Path.UI .. ".PluginOptions");