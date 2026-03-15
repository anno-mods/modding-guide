if not system then
    system = {}
end

-- create a shortcut to start a script
run = system.run

--- Waits until ui is loaded an game is ready (main menu entered)
function system.waitUILoaded()
    await(system.sleepUILoaded())
end

--- Waits until metatick has continued for delayInMs
---@param delay integer | { delta: integer, deltaTicks: integer, absolute: integer } an integer delay defines how many ms to wait, while a table gives more options @see system.sleep
function system.wait(delay)
    await(system.sleep(delay))
end

--- Waits until pause persistent metatick has continued for delayInMs
---@param delay integer | { delta: integer, deltaTicks: integer, absolute: integer } an integer delay defines how many ms to wait, while a table gives more options @see system.sleep
function system.waitPP(delay)
    await(system.sleepPP(delay))
end

---Extracts from a valid traceback the line, file and function of the given entryIndex. If
---entryIndex is not found or traceback is not valid, 'unknown',0,'unknown' will be returned
---@param aTraceback string the return values of a call to debug.traceback()
---@param entryIndex integer selects the line of the traceback (zero based)
---@return string name
---@return number? line
---@return string functionName
function system.extractFileLineFunction(aTraceback, entryIndex)
    local count = 0
    if aTraceback and type(aTraceback) == "string" then
        for tracebackLine in aTraceback:gmatch("[^\r\n]+") do
            local file, line, where = tracebackLine:match('^%s*(.+):(%d+): in (.*)')
            if file and line then
                if count == entryIndex then
                    local functionName = where:match("function \'(.*)\'")
                    if functionName then
                        return file, tonumber(line), functionName
                    end
                    return file, tonumber(line), where
                else
                    count = count + 1
                end
            end
        end
    end
    return "unknown", 0, "unknown"
end
