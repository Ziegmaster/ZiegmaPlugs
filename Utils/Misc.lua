-- safely add a listener without overwriting any existing ones
function _G.AddListener(object, event, listener)
    if (object[event] == nil) then
        object[event] = listener;
    else
        if (type(object[event]) == "table") then
            table.insert(object[event], listener);
        else
            object[event] = {object[event], listener};
        end
    end
    return listener;
end

-- safely remove a listener without clobbering any extras
function _G.RemoveListener(object, event, listener)
    if (object[event] == listener) then
        object[event] = nil;
    else
        if (type(object[event]) == "table") then
            local size = table.getn(object[event]);
            for i = 1, size do
                if (object[event][i] == listener) then
                    table.remove(object[event], i);
                    break;
                end
            end
        end
    end
end

-- safely execute a listener whether it be an array of functions or a single one
function _G.ExecuteListener(object, event, args)
    if (type(object[event]) == "function") then
        object[event](object, args);
    else
        if (type(object[event]) == "table") then
            local size = table.getn(object[event]);
            for i = 1, size do
                if (type(object[event][i]) == "function") then
                    object[event][i](object, args);
                end
            end
        end
    end
end

local function format_any_value(obj, buffer)
    local _type = type(obj);
    if _type == "table" then
        buffer[#buffer + 1] = '{';
        for key, value in next, obj, nil do
            buffer[#buffer + 1] = '["' .. tostring(key) .. '"] = ';
            format_any_value(value, buffer);
            buffer[#buffer + 1] = ',"';
        end
        buffer[#buffer] = '}\n' -- note the overwrite
    elseif _type == "string" then
        buffer[#buffer + 1] = '"' .. obj .. '",';
    elseif _type == "boolean" or _type == "number" then
        buffer[#buffer + 1] = tostring(obj) .. ",";
    else
        buffer[#buffer + 1] = '"???' .. _type .. '???",';
    end
end

function _G.DumpObject(obj)
    if type(obj) == 'table' then
        local s = '{'
        for k,v in pairs(obj) do
            if type(k) == 'table' then k = DumpObject(k) end
            if type(k) == 'string' then k = '"'..k..'"' end
            s = s .. '\n['..k..'] = ' .. (type(v) == "string" and ('"' .. v .. '"') or DumpObject(v)) .. ','
        end
        return s .. '\n}'
    else
        return tostring(obj)
    end
end

function _G.FormatTime(time)
    local hours = time / 3600;
    local minutes = time % 3600 / 60;
    local seconds = time % 3600 % 60;
    return string.format("%2.2d:%2.2d:%2.2d", hours, minutes, seconds);
end

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