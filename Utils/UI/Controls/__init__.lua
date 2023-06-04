blueBorderColor = Turbine.UI.Color(0.15, 0.2, 0.3);                  -- blue inner border
controlColor = Turbine.UI.Color(.83, .69, .28);                      -- gold,  slightly yellow
control2Color = Turbine.UI.Color(0.88, 0.77, 0.1);                   -- gold,  almost yellow
controlSelectedColor = Turbine.UI.Color(0.9, 0.85, 0.65);            -- light gold
control2LightColor = Turbine.UI.Color(0.95, 0.85, 0.55);             -- light gold,  somewhat white
controlDisabledColor = Turbine.UI.Color(.79, .79, .79);              -- grey
control2DisabledColor = Turbine.UI.Color(162/255, 162/255, 162/255); -- lighter grey
whiteColor = Turbine.UI.Color(1, 1, 1);                              -- white
blackColor = Turbine.UI.Color(0, 0, 0);                              -- black
yellowColor = Turbine.UI.Color(1, 1, 0);                             -- yellow
dialogBackgroundColor = Turbine.UI.Color(0.92, 0, 0, 0);             -- default black dialog background, slightly transparent
highlightColor = Turbine.UI.Color(.92, 40/255, 67/255, 122/255);     -- bluish highlight color, slightly transparent
yellowGoldColor = Turbine.UI.Color(244/255, 255/255, 51/255);        -- yellow gold color

-- drop down assets
dropDownArrow = Turbine.UI.Graphic(0x41007e1a);
dropDownArrowDisabled = Turbine.UI.Graphic(string.gsub(Path.Utils, "%.", "/") .. "/UI/Controls/Resources/dropdown_arrow_closed_ghosted.tga");
dropDownArrowHighlight = Turbine.UI.Graphic(0x41007e1b);
dropDownArrowPressed = Turbine.UI.Graphic(0x41007e18);
dropDownArrowPressedHighlight = Turbine.UI.Graphic(0x41007e19);

import (Path.Utils .. ".UI.Controls.ComboBox");
import (Path.Utils .. ".UI.Controls.Slider");
import (Path.Utils .. ".UI.Controls.ShortcutButton");