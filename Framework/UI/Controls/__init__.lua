Framework.UI.Controls = {};
Framework.UI.Controls.Colors = {};
Framework.UI.Controls.Assets = {};

Framework.UI.Controls.Colors.blueBorderColor = Turbine.UI.Color(0.15, 0.2, 0.3);                  -- blue inner border
Framework.UI.Controls.Colors.controlColor = Turbine.UI.Color(.83, .69, .28);                      -- gold,  slightly yellow
Framework.UI.Controls.Colors.control2Color = Turbine.UI.Color(0.88, 0.77, 0.1);                   -- gold,  almost yellow
Framework.UI.Controls.Colors.controlSelectedColor = Turbine.UI.Color(0.9, 0.85, 0.65);            -- light gold
Framework.UI.Controls.Colors.control2LightColor = Turbine.UI.Color(0.95, 0.85, 0.55);             -- light gold,  somewhat white
Framework.UI.Controls.Colors.controlDisabledColor = Turbine.UI.Color(.79, .79, .79);              -- grey
Framework.UI.Controls.Colors.control2DisabledColor = Turbine.UI.Color(162/255, 162/255, 162/255); -- lighter grey
Framework.UI.Controls.Colors.whiteColor = Turbine.UI.Color(1, 1, 1);                              -- white
Framework.UI.Controls.Colors.blackColor = Turbine.UI.Color(0, 0, 0);                              -- black
Framework.UI.Controls.Colors.yellowColor = Turbine.UI.Color(1, 1, 0);                             -- yellow
Framework.UI.Controls.Colors.dialogBackgroundColor = Turbine.UI.Color(0.92, 0, 0, 0);             -- default black dialog background, slightly transparent
Framework.UI.Controls.Colors.highlightColor = Turbine.UI.Color(.92, 40/255, 67/255, 122/255);     -- bluish highlight color, slightly transparent
Framework.UI.Controls.Colors.yellowGoldColor = Turbine.UI.Color(244/255, 255/255, 51/255);        -- yellow gold color

-- drop down assets
Framework.UI.Controls.Assets.dropDownArrow = Turbine.UI.Graphic(0x41007e1a);
Framework.UI.Controls.Assets.dropDownArrowDisabled = Turbine.UI.Graphic(string.gsub(Framework.SelfPath, "%.", "/") .. "/UI/Controls/Resources/dropdown_arrow_closed_ghosted.tga");
Framework.UI.Controls.Assets.dropDownArrowHighlight = Turbine.UI.Graphic(0x41007e1b);
Framework.UI.Controls.Assets.dropDownArrowPressed = Turbine.UI.Graphic(0x41007e18);
Framework.UI.Controls.Assets.dropDownArrowPressedHighlight = Turbine.UI.Graphic(0x41007e19);

import (Framework.SelfPath .. ".UI.Controls.ComboBox");
import (Framework.SelfPath .. ".UI.Controls.Slider");
import (Framework.SelfPath .. ".UI.Controls.ShortcutButton");
import (Framework.SelfPath .. ".UI.Controls.BorderedControls");