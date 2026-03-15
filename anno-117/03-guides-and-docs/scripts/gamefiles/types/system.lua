---@meta
---waits for a future. The future is returned by functions marked with async. 
---@param asyncFunc rdgs.CAsyncFunction | rdgs.ScriptEvent event or async 
function await(asyncFunc) end
---waits for many futures. All futures need to be finished to continue 
---@param ... rdgs.CAsyncFunction | rdgs.ScriptEvent one or more events or async functions
function await_all(...) end
---waits for many futures. Continues if at least one future has finished
---@param ... rdgs.CAsyncFunction | rdgs.ScriptEvent one or more events or async functions
function await_any(...) end

---These methods are bound to rdgs::CScriptEngineLua. Not all methods found in namespace system are bound methods. The script core/scriptsystem.lua is defining the rest of it.
---@meta system

---shortcut of the command system.startScript
---@see system.startScript
---@param scriptName string filename of the script to start
function run(scriptName) end

---@class system
system = {}

---call if a test passed a expect-check successfully
---@param header string title of what is expected
---@param file string path of the file the expect was written in
---@param line integer line where the expect is located.
function system.AssertSucceded(header, file, line) end

---if an expect failed, you need to inform dtest by using this method. A good practice is to provide the stack trace in description
---@param header string title of what is expected
---@param description string discription of the failure. Should include expression and value. A stack trace would be helpful.
---@param category string
---@param file string path of the file the expect was written in
---@param line integer line where the expect is located.
function system.AssertFailed(header, description, category, file, line) end

---starts a coroutine running the script path is pointing to
---@param path string
function system.run(path) end

---logs a debug text to game logging
---@param debugText string
function system.log(debugText) end

---logs a info text to game logging
---@param infoText string
function system.logInfo(infoText) end

---logs a error text to game logging
---@param errorText string
function system.logError(errorText) end

---used to replace Luas print method. Reroutes the output to game logging
---@param text string
function system.print(text) end

---triggers games assert handling
---@param text string
---@param file string path of the file containing the assert
---@param line integer code line
---@param functionName string name of the function that contains the assert
function system.assert(text, file, line, functionName) end

--- wait for game start (ui loaded and game ready)
---@return rdgs.CAsyncFunction future can be used to wait asynchronous on
function system.sleepUILoaded() end

--- wait for next metagame tick after a timeout
---@param delay? integer | { delta: integer, deltaTicks: integer, absolute: integer } an integer delay defines how many ms to wait, while a table gives more options @see system.sleep.
--- Populate deltaTicks to wait for an amount of ticks.
--- Set absolute to wait until an absolute meta ticks time is reached.
--- If no parameter is given, sleep waits for one tick.
---@return rdgs.CAsyncFunction future can be used to wait asynchronous on
function system.sleep(delay) end
--- wait for next pause persistent meta tick after a timeout
---@param delay? integer | { delta: integer, deltaTicks: integer, absolute: integer } an integer delay defines how many ms to wait, while a table gives more options @see system.sleep
--- deltaTicks has for sleepPP the same meaning as delta.
--- Set absolute to wait until an absolute meta ticks time is reached.
--- If no parameter is given, sleep waits for one tick
---@return rdgs.CAsyncFunction future can be used to wait asynchronous on
function system.sleepPP(delay) end

--- internally used by game to register all coroutines
---@param coroutine thread a coroutine
function system.registerCoroutine(coroutine) end

---mimics the Lua 5.1 require function
---@param path string module filename
function system.require(path) end

---executes a script file
---@param path string filename of a scipt to execute
function system.dofile(path) end

---converts a string or number to int64
---@param input string|number|rdtime a string containing an int64 as decimal or hexadecimal or any number
function system.ll(input) end

---converts a string or number to uint64
---@param input string|number|rdtime a string containing an unsigned int64 as decimal or hexadecimal or any number
function system.ull(input) end

---converts a string or number to int64
---@param input string|number|rdtime a string containing an int64 as decimal or hexadecimal or any number
function system.int64(input) end

---converts a string or number to uint64
---@param input string|number|rdtime a string containing an unsigned int64 as decimal or hexadecimal or any number
function system.uint64(input) end

---parses a string to uint64
---@param pattern string may contain 1..more
function system.FmtString(pattern) end
