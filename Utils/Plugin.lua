import "Turbine"
import "Turbine.UI"

function _G.PluginReload(pluginName)

	local status  = 0
	control = Turbine.UI.Control()

	function control:Update()
		if status == 1 then
			Turbine.PluginManager.UnloadScriptState( pluginName )
		elseif status == 10 then
			Turbine.PluginManager.LoadPlugin( pluginName )
			control = nil
		end
		status = status + 1
	end

	control:SetWantsUpdates( true )

end

function _G.PluginUnload(pluginName)

	local status  = 0
	control = Turbine.UI.Control()

	function control:Update()
		if status == 10 then
			Turbine.PluginManager.UnloadScriptState( pluginName )
			control = nil
		end
		status = status + 1
	end

	control:SetWantsUpdates( true )

end