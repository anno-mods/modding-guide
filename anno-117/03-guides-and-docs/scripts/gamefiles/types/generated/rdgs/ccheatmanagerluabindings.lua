---@meta rdgs.CCheatManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CCheatManager
---@field GlobalCheats rdgs.CGlobalCheats		
---@field AICheats rdgs.CAIGlobalCheatHandler		
local CCheatManager = {}
Cheat = CCheatManager
---@param self rdgs.CCheatManager
---@param id integer
function CCheatManager.IncreaseCheatCount(self, id ) end
---@param self rdgs.CCheatManager
---@param cheatName string
---@return integer
function CCheatManager.GetCheatCount(self, cheatName ) end
---@param self rdgs.CCheatManager
---@param cheatName string
function CCheatManager.TriggerCheatByName(self, cheatName ) end
---@param self rdgs.CCheatManager
---@param id integer
function CCheatManager.TriggerCheat(self, id ) end
---@param self rdgs.CCheatManager
---@param cheatName string
---@param args string
function CCheatManager.TriggerCheatByNameWithArgs(self, cheatName , args ) end
---@param self rdgs.CCheatManager
---@param id integer
---@param args string
function CCheatManager.TriggerCheatWithArgs(self, id , args ) end
---@param self rdgs.CCheatManager
---@param category integer
function CCheatManager.SetCheatCategory(self, category ) end
---@param self rdgs.CCheatManager
function CCheatManager.ToggleInGameDebugCheatPage(self) end
---Adds a cheat to the system. Name must be unique. Command should be the console command without TextSource.TextSourceRoots\nAdd for every argument an ascending index in curly brackets.\nExample MyManager.CrazyFunction({0}, {1})
---@param self rdgs.CCheatManager
---@param category rdgs.CheatCategories
---@param name string
---@param command string
---@param shortcut string
---@param comment string
---@param worksInMultiplayer boolean
---@param quickAccessCheatOverlay boolean
---@param contexts std.initializer_list
---@return integer
function CCheatManager.AddCheat(self, category , name , command , shortcut , comment , worksInMultiplayer , quickAccessCheatOverlay , contexts ) end
---Adds a cheat to the system. Name must be unique. Command should be the console command without TextSource.TextSourceRoots\nAdd for every argument an ascending index in curly brackets.\nExample MyManager.CrazyFunction({0}, {1})
---@param self rdgs.CCheatManager
---@param category rdgs.CheatCategories
---@param name string
---@param command string
---@param shortcut string
---@param comment string
---@param worksInMultiplayer boolean
---@param quickAccessCheatOverlay boolean
---@return integer
function CCheatManager.AddCheat(self, category , name , command , shortcut , comment , worksInMultiplayer , quickAccessCheatOverlay ) end
---Adds a cheat to the system. Name must be unique. Command should be the console command without TextSource.TextSourceRoots\nAdd for every argument an ascending index in curly brackets.\nExample MyManager.CrazyFunction({0}, {1})
---@param self rdgs.CCheatManager
---@param category rdgs.CheatCategories
---@param name string
---@param command string
---@param shortcut string
---@param comment string
---@param worksInMultiplayer boolean
---@return integer
function CCheatManager.AddCheat(self, category , name , command , shortcut , comment , worksInMultiplayer ) end
---@return boolean returns true if weak pointer holds a valid reference
function CCheatManager.isValid() end

return CCheatManager
