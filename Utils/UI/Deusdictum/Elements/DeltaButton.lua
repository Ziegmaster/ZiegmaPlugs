pcall( function( ) import (Path.Utils .. ".UI.Deusdictum.Elements.DeltaButtonWindow"); end );
pcall( function( ) import (Path.Utils .. ".UI.Deusdictum.DeltaButtonControl"); end );

_G.DeltaButton = function( tResources, bfZoneTest, ctlAttachTo )
	if DeltaButtonControl ~= nil and ctlAttachTo ~= nil then
		return DeltaButtonWindow( tResources, bfZoneTest, ctlAttachTo );
	elseif DeltaButtonWindow ~= nil and ctlAttachTo == nil then
		return DeltaButtonControl( tResources, bfZoneTest );
	end

	return nil;
end