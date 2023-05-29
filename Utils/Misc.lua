function table.invert(t)
    local s={}
    for k,v in pairs(t) do
        s[v]=k
    end
    return s
end

function table.length(t)
    local count = 0
    for _ in pairs(t) do count = count + 1 end
    return count
end
  

function table.indexOf(array, value)
    for i, v in ipairs(array) do
        if v == value then
            return i;
        end
    end
    return nil;
end

function table.equal(t1,t2,ignore_mt)
    local ty1 = type(t1)
    local ty2 = type(t2)
    if ty1 ~= ty2 then return false end
    -- non-table types can be directly compared
    if ty1 ~= 'table' and ty2 ~= 'table' then return t1 == t2 end
    -- as well as tables which have the metamethod __eq
    local mt = getmetatable(t1)
    if not ignore_mt and mt and mt.__eq then return t1 == t2 end
    for k1,v1 in pairs(t1) do
        local v2 = t2[k1]
        if v2 == nil or not table.equal(v1,v2) then return false end
    end
    for k2,v2 in pairs(t2) do
        local v1 = t1[k2]
        if v1 == nil or not table.equal(v1,v2) then return false end
    end
    return true
end

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

_G.DumpObject = function(obj)
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

local function format_table_keys(obj)
    local result = {};
    if _type == "table" then
        for key, value in next, obj, nil do
            result["#" .. string.gsub(tostring(value),",",".")] = format_table_keys(value);
        end
        return result;
    end
    return obj;
end

_G.FormatTime = function(time)
    local hours = time / 3600;
    local minutes = time % 3600 / 60;
    local seconds = time % 3600 % 60;
    return string.format("%2.2d:%2.2d:%2.2d", hours, minutes, seconds);
end


local function table_clone_internal(t, copies)
    if type(t) ~= "table" then return t end
    
    copies = copies or {}
    if copies[t] then return copies[t] end
  
    local copy = {}
    copies[t] = copy
  
    for k, v in pairs(t) do
      copy[table_clone_internal(k, copies)] = table_clone_internal(v, copies)
    end
  
    setmetatable(copy, table_clone_internal(getmetatable(t), copies))
  
    return copy
end
  
local function table_clone(t)
    -- We need to implement this with a helper function to make sure that
    -- user won't call this function with a second parameter as it can cause
    -- unexpected troubles
    return table_clone_internal(t)
end
  
function table.merge(...)
    local tables_to_merge = {...}
    assert(#tables_to_merge > 1, "There should be at least two tables to merge them");
  
    for k, t in ipairs(tables_to_merge) do
        assert(type(t) == "table", string.format("Expected a table as function parameter %d", k))
    end
  
    local result = table_clone(tables_to_merge[1]);
  
    for i = 2, #tables_to_merge do
        local from = tables_to_merge[i];
        for k, v in pairs(from) do
            if type(v) == "table" then
                result[k] = result[k] or {}
                assert(type(result[k]) == "table", string.format("Expected a table: '%s'", k))
                result[k] = table.merge(result[k], v)
            else
                result[k] = v
            end
        end
    end
  
    return result
end