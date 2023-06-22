import (Framework.SelfPath .. ".UI.Deusdictum.Elements.DeltaButtonWindow");
import (Framework.SelfPath .. ".UI.Deusdictum.Elements.DeltaButtonControl");

Framework.UI.Controls.DeltaButton = function( tResources, bfZoneTest, ctlAttachTo )
	if Framework.UI.Controls.DeltaButtonControl ~= nil and ctlAttachTo ~= nil then
		return Framework.UI.Controls.DeltaButtonWindow( tResources, bfZoneTest, ctlAttachTo );
	elseif Framework.UI.Controls.DeltaButtonWindow ~= nil and ctlAttachTo == nil then
		return Framework.UI.Controls.DeltaButtonControl( tResources, bfZoneTest );
	end

	return nil;
end