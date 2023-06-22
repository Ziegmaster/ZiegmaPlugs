-- safely add a listener without overwriting any existing ones
function Framework.Utils.AddListener(object, event, listener)
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
function Framework.Utils.RemoveListener(object, event, listener)
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
function Framework.Utils.ExecuteListener(object, event, args)
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

function Framework.Utils.DumpObject(obj)
    if type(obj) == 'table' then
        local s = '{'
        for k,v in pairs(obj) do
            if type(k) == 'table' then k = Framework.Utils.DumpObject(k) end
            if type(k) == 'string' then k = '"'..k..'"' end
            s = s .. '\n['..k..'] = ' .. (type(v) == "string" and ('"' .. v .. '"') or Framework.Utils.DumpObject(v)) .. ','
        end
        return s .. '\n}'
    else
        return tostring(obj)
    end
end

function Framework.Utils.FormatTime(time)
    local hours = time / 3600;
    local minutes = time % 3600 / 60;
    local seconds = time % 3600 % 60;
    return string.format("%2.2d:%2.2d:%2.2d", hours, minutes, seconds);
end

function Framework.Utils.PluginReload(pluginName)

	local status  = 0
	_C = Turbine.UI.Control()

	function _C:Update()
		if status == 1 then
			Turbine.PluginManager.UnloadScriptState( pluginName )
		elseif status == 10 then
			Turbine.PluginManager.LoadPlugin( pluginName )
			_C = nil
		end
		status = status + 1
	end

	_C:SetWantsUpdates( true )

end

function Framework.Utils.PluginUnload(pluginName)

	local status  = 0;
	_C = Turbine.UI.Control();

	function _C:Update()
		if status == 10 then
			Turbine.PluginManager.UnloadScriptState( pluginName )
			_C = nil
		end
		status = status + 1
	end

	_C:SetWantsUpdates( true )

end

function Framework.Utils.TableEncode( tbl )
    if type( tbl ) == "number" then
        local text = tostring( tbl )

        return "#" .. string.gsub( text, ",", "." )
    elseif type( tbl ) == "string" then
        return "$" .. tbl
    elseif type( tbl ) == "table" then
        local new = {}

        for k, v in pairs( tbl ) do
            new[ Framework.Utils.TableEncode( k ) ] = Framework.Utils.TableEncode( v )
        end

        return new
    else
        return tbl
    end
end

function Framework.Utils.TableDecode( tbl )
    if type( tbl ) == "string" then
        local prefix = string.sub( tbl, 1, 1 )

        if prefix == "$" then
            return string.sub( tbl, 2 )
        elseif prefix == "#" then
            return loadstring( "return " .. string.sub( tbl, 2 ) )()
        else
            return tbl
        end
    elseif type( tbl ) == "table" then
        local new = {}

        for k, v in pairs( tbl ) do
            new[ Framework.Utils.TableDecode( k ) ] = Framework.Utils.TableDecode( v )
        end

        return new
    else
        return tbl
    end
end

function Framework.Utils.IsMouseOver(object)
    if not object:IsVisible() then return false end

    local x, y = object:GetMousePosition()

    local pos_x, pos_y   = object:GetPosition()
    local size_x, size_y = object:GetSize()

    if x + pos_x >= pos_x and x + pos_x <= pos_x + size_x and y + pos_y >= pos_y and y + pos_y <= pos_y + size_y then
        return true
    else
        return false
    end
end