local function get_module_path(module_name)
    local file_path = module_name:gsub("%.", "/")

    for path in package.path:gmatch("[^;]+") do
        local full_path = path:gsub("%?", file_path)
        local file = io.open(full_path, "r")
        
        if file then
            file:close()
            return full_path
        end
    end
    
    return nil
end

-- provide some anno specific global functions
---@diagnostic disable-next-line: lowercase-global
dofile = system.dofile      -- run a script file
---@diagnostic disable-next-line: lowercase-global
require = system.require    -- require a module
---@diagnostic disable-next-line: lowercase-global
ll = system.ll              -- convert a 64-bit integer from string or number
---@diagnostic disable-next-line: lowercase-global
ull = system.ull            -- convert a unsigned 64-bit integer from string or number
---@diagnostic disable-next-line: lowercase-global
int64 = system.int64        -- convert a 64-bit integer from string or number
---@diagnostic disable-next-line: lowercase-global
uint64 = system.uint64      -- convert a unsigned 64-bit integer from string or number
---@diagnostic disable-next-line: lowercase-global
f = system.FmtString        -- formats a string by replacing {name} with values of matching variables

-- use it to print errors to script-console
---@diagnostic disable-next-line: lowercase-global
printError = function(...)
    local finalOutput = ""
    local seperator = ""
    for _,a in pairs({...}) do
        finalOutput = finalOutput .. seperator .. resultToString(a)
        seperator = ""
    end
    system.logError(finalOutput)
    
end

-- use to print normal output to script-console. overrides default print behavior
print = function(...)
    local finalOutput = ""
    local seperator = ""
    for _,a in pairs({...}) do
        finalOutput = finalOutput .. seperator .. resultToString(a)
        seperator = " "
    end
    system.log(finalOutput)
    system.print(finalOutput)
end

local originalCoroutineCreate = coroutine.create
--- extends the default coroutine creating with registration to game
---@diagnostic disable-next-line: duplicate-set-field
coroutine.create = function(f)
    local co = originalCoroutineCreate(f)
    system.registerCoroutine(co)
    return co
end

---resumes a coroutine but with automatically generating a traceback and returning it
---@param co thread a coroutine handle to resume (returned from coroutine.create(f))
---@return boolean 
--- - false: an error occurred and will be returned as second result. 3rd result is the traceback
--- - true: resume has been executed successfully. return values of the coroutine function follow as results
---@return any first return value if no error
---@return string in case of an error, this will be the traceback
function coroutine.xpcall(co)
    local output = {coroutine.resume(co)}
    if output[1] == false then
        return false, output[2], debug.traceback(co)
    end
    return table.unpack(output)
end

-- list all subelements of given object. If filter is set, only string that contain filter will be printed
---@diagnostic disable-next-line: lowercase-global
function dir(obj, filter)
    local output = {}
    for k,v in pairs(obj) do
        if (filter) then
            if (string.find(k, filter)) then
                table.insert(output, tostring(k) .. " --> " .. tostring(v))
            end
        else
            if type(v) == "string" then
                table.insert(output, tostring(k) .. " --> " .. v)
            else
                table.insert(output, tostring(k) .. " --> " .. tostring(v))
            end
        end
    end
    table.sort(output)
    return table.concat(output, "\n")
end

---used by the script system to generate readable output of command (always applied on the result of CScriptEngineLua::RunScript)
---@param result any whatever the result of the script was
---@return string a human readable string representation of the parameter
---@diagnostic disable-next-line: lowercase-global
function resultToString(result)
    if type(result) == "table" and not getmetatable(result) then
        return dir(result)
    end
    return tostring(result)
end

local function formatSignature(signature)
    if type(signature) == "string" then
        return signature
    end
    if signature.IsProperty then
        return signature.Alias .. ": " .. signature.ReturnType
    end

    local result = signature.Alias
    if signature.Arguments then
        result = result .. "("
        local seperator = ""
        for argName,argType in pairs(signature.Arguments) do
            result = result .. seperator .. argName .. ": " .. argType.Type
            seperator = ", "
        end  
        result = result .. ")"
    end
    if signature.ReturnType then
        result = result .. " : " .. signature.ReturnType;
    end
    return result
end

local json = require("json")

local function inspectClass(metaT)
    -- might be a LuaBridge type
    local t = {}
    local typeDesc = {}

    -- first find type name
    for k,v in pairs(metaT) do
        if type(k) == "userdata" then
            if tostring(k) == "userdata: 0x0000000000000071" then
                t[":type name:"] = v
                local jsonDesc = rdgs.IntrospectionHelper.getClassDefinition(v)
                if jsonDesc and #jsonDesc > 0 then
                    typeDesc = json.decode(jsonDesc)
                end
                break
            end
        end
    end

    -- now resolve all members
    for k,v in pairs(metaT) do
        local key = tostring(k)
        if type(k) == "userdata" then
            if key == "userdata: 0x00000000000006e7" then
                for name,_ in pairs(v) do
                    if not t[":properties:"] then t[":properties:"] = {} end
                    if typeDesc[name] then
                        t[":properties:"][name] = typeDesc[name]
                    else
                        t[":properties:"][name] = { Alias = name }
                    end
                end
            elseif key == "userdata: 0x00000000000005e7" then
                for name,_ in pairs(v) do
                    if not t[":properties:"] then t[":properties:"] = {} end
                    t[":properties:"][name] = name
                    if typeDesc[name] then
                        t[":properties:"][name] = typeDesc[name]
                    else
                        t[":properties:"][name] = { Alias = name }
                    end
                end
            elseif key == "userdata: 0x0000000000000071" then
                t[":type name:"] = v
            elseif key == "userdata: 0x00000000000000c7" then
                t[":exceptions:"] = v
            elseif key == "userdata: 0x0000000000000c07" then
                t[":const type:"] = v
            elseif key == "userdata: 0x0000000000000c1a" then
                t[":type:"] = v
            elseif key == "userdata: 0x0000000000000c2b" then
                t[":options:"] = v
            elseif key == "userdata: 0x000000000000057a" then
                t[":static type:"] = v
            elseif key == "userdata: 0x0000000000000dad" then
                t[":parent:"] = v
            elseif key == "userdata: 0x00000000000081ca" then
                t[":index fallback:"] = v
            elseif key == "userdata: 0x0000000000008107" then
                t[":new index fallback:"] = v
            else
                t[key] = tostring(v)
            end
        elseif type(k) == "string" then
            if key == "__call" then
                if not t[":constructors:"] then t[":constructors:"] = {} end
                table.insert(t[":constructors:"], typeDesc[key] or "constructor")
            elseif string.sub(key, 1, 2) == "__" then
                if not t[":metafunctions:"] then t[":metafunctions:"] = {} end
                t[":metafunctions:"][key] = tostring(v)
            else
                local td = typeDesc[key]
                if td then
                    if td.IsProperty then
                        if not t[":properties:"] then t[":properties:"] = {} end
                        t[":properties:"][td.Alias] = td
                    else
                        if not t[":functions:"] then t[":functions:"] = {} end
                        t[":functions:"][td.Alias] = td
                    end
                else
                    t[key] = tostring(v)
                end
            end
        else
            t[key] = tostring(v)
        end
    end

    if t[":type:"] then
        local fqname = rdgs.IntrospectionHelper.getFQClassName(t[":type:"])
        t = inspect(t[":type:"])
        t.isClass = true
        t.fullQualifiedName = fqname
    else
        t.isClass = false
    end

    if t[":type name:"] then
        local metaMetaT = getmetatable(metaT)
        if metaMetaT then
            if metaMetaT["__name"] == "GlobalPropertyMT" then
                metaT = getmetatable(metaT.get())
            end
        end
        if not t.isClass then
            t.fullQualifiedName = rdgs.IntrospectionHelper.getFQClassName(metaT)
        end
    end

    return t
end

---used by autoComplete to list all methods/elements
---@diagnostic disable-next-line: lowercase-global
function inspect(obj)
    if type(obj) == "table" or type(obj) == "userdata" then
        local metaT = getmetatable(obj)
        if metaT then
            if metaT["__name"] == "GlobalPropertyMT" then
                obj = obj.get()
                metaT = getmetatable(obj)
                if not metaT then
                    return obj
                end
            end
            return inspectClass(metaT)
        end
        local maybeClass = inspectClass(obj)
        if maybeClass[":type:"] then
            return maybeClass
        end
    end
    return { [":type:"]=type(obj), fullQualifiedName=type(obj) }
end

---returns a json representation of the type info (i.e. for code completion)
---@diagnostic disable-next-line: lowercase-global
function getTypeInfo(t)
    local info = inspect(t)
    -- strip data (not json compatible)
    info[":const type:"] = nil
    info[":static type:"] = nil
    return json.encode(info)
end

---returns reduced table of the json representation (deprecated)
---@deprecated
---@diagnostic disable-next-line: lowercase-global
function getTypeInfoDeprecated(t)
    local info = inspect(t)
    info[":metafunctions:"] = nil
    info[":const type:"] = nil
    info[":static type:"] = nil
    if info[":type:"] == "table" then
        info = t
    else
        info[":type:"] = nil
        info["fullQualifiedName"] = nil
        info["isClass"] = nil
        if info[":functions:"] then
            for name,func in pairs(info[":functions:"]) do
                info[name] = formatSignature(func)
            end
            info[":functions:"] = nil
        end
        if info[":properties:"] then
            for name,prop in pairs(info[":properties:"]) do
                info[name] = formatSignature(prop)
            end
            info[":properties:"] = nil
        end
    end
    return dir(info)
end

---@diagnostic disable-next-line: lowercase-global
function filterMetaTables(val, key, metaTable)
    if type(key) == "string" then
        return not string.find(key, "__*.")
    else
        return false
    end
end

---@diagnostic disable-next-line: lowercase-global
function help(obj)
    local info = inspect(obj)
    if not info then return "no info found" end

    local output = ""
    if not info.isClass then
        output = output .. "object of "
    end
    if info.fullQualifiedName then output = output .. "type " .. info.fullQualifiedName .. "\n" end
    local constructors = info[":constructors:"]
    if constructors then
        output = output .. "Constructors:"
        for _,signature in table.pairsSortedByKey(constructors) do
            output = output .. "\n- " .. formatSignature(signature)
        end
        output = output .. "\n"
    end
    local functions = info[":functions:"]
    if functions then
        output = output .. "Functions:"
        for _,signature in table.pairsSortedByKey(functions) do
            output = output .. "\n- " .. formatSignature(signature)
        end
        output = output .. "\n"
    end
    local properties = info[":properties:"]
    if properties then
        output = output .. "Properties:"
        for _,signature in table.pairsSortedByKey(properties) do
            output = output .. "\n+ " .. formatSignature(signature)
        end
        output = output .. "\n"
    end
    return output
end

---@diagnostic disable-next-line: lowercase-global
function findClass(class)
    for k,v in pairs(_G['rdgs']) do
        if v == class then
            print("found " .. help(v))
            return
        end
    end
    print("nothing found")
end

---return a copy of the table containing the entry where filterIter returned true
---@param t table self reference of the table
---@param filterIter function that accepts the key and value of the entry. Third param is the self reference of the table
---@return table
table.filter = function(t, filterIter)
    local filteredCopy = {}

    for k, v in pairs(t) do
        if filterIter(v, k, t) then
            filteredCopy[k] = v
        end
    end

    return filteredCopy
end

---for sorted iteration on table
---@param t table self reference of the table
---@return function iterator to sorted entries in table
table.pairsSortedByKey = function(t)
    local keys = {}

    for n in pairs(t) do
        table.insert(keys, n)
    end

    table.sort(keys)

    local i = 0
    local iter = function()
        i = i + 1
        local key = keys[i]
        if key == nil then 
            return nil
        else 
            return key, t[key]
        end
    end
    return iter
end

---flattens a table to a single line. If array, keys are suppressed.
---@param t any
---@return string flattened table as string
---@diagnostic disable-next-line: lowercase-global
function flatten(t)
    local content = ""
    if type(t) == "table" then
        if t[1] then
            local sep = ""
            for _,val in ipairs(t) do
                content = content .. sep .. tostring(val)
                sep = ", "
            end
        else
            local content = ""
            local sep = ""
            for key,val in pairs(t) do
                content = content .. sep ..tostring(key) .. '=' .. tostring(val)
                sep = ", "
            end
        end
    else
        content = tostring(t)
    end

    return content
end
