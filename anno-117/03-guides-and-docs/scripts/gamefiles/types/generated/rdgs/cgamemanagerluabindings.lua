---@meta rdgs.CGameManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CGameManager
---@field PlayTime rdtime		
local CGameManager = {}
Game = CGameManager
---@see CMetaGameLoader parent class
---New Savegame, asynchronously. Returns the requested savegame name as identifier to check if saving has finished.
---@param self rdgs.CGameManager
---@param savegameName string
---@param canOverride boolean
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CGameManager.Save(self, savegameName , canOverride ) end
---New Savegame, asynchronously. Returns the requested savegame name as identifier to check if saving has finished.
---@param self rdgs.CGameManager
---@param savegameName string
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CGameManager.Save(self, savegameName ) end
---@param self rdgs.CGameManager
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CGameManager.Save(self) end
---load a savegame by filename. Checks first, if name is a profile name. If so, profiles newest savegame will be loaded\nOtherwise it gathers fileinfo and starts loading of given file. If meta game is running, it will be unloaded first.
---@param self rdgs.CGameManager
---@param savegameName string
---@param enterLoadingState boolean
---@param skipSetSailButton boolean
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CGameManager.Load(self, savegameName , enterLoadingState , skipSetSailButton ) end
---@param self rdgs.CGameManager
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CGameManager.Load(self) end
---@param self rdgs.CGameManager
---@param sessionGUID integer
function CGameManager.EnterCorrectLoadingScene(self, sessionGUID ) end
---@param self rdgs.CGameManager
function CGameManager.EnterCorrectLoadingScene(self) end
---@param self rdgs.CGameManager
function CGameManager.SaveGameWithPopup(self) end
---@param self rdgs.CGameManager
function CGameManager.SaveGame(self) end
---@param self rdgs.CGameManager
function CGameManager.QueueCampaignBackup(self) end
---@param self rdgs.CGameManager
---@param cheatForce boolean
function CGameManager.PushSavegameQuota(self, cheatForce ) end
---@param self rdgs.CGameManager
function CGameManager.PushSavegameQuota(self) end
---unload current corporation. This must happen in FullSync. If not, it will be deferred to.\nin case you want to execute something right after unloading finished, provide a lambda as first parameter.
---@param self rdgs.CGameManager
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CGameManager.Unload(self) end
---@param self rdgs.CGameManager
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CGameManager.Unload(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CGameManager.isValid() end
---used to select the timer returned by GetPerformanceTimerJSON
---@param self rdgs.CGameManager
---@param performanceTimerGUID integer
function CGameManager.SetPerformanceTimerGUID(self, performanceTimerGUID ) end
---Executes the same action as when \'x\' button of the game window is pressed
---@param self rdgs.CGameManager
function CGameManager.SimulateWindowClose(self) end
---@param self rdgs.CGameManager
---@param mode integer
function CGameManager.FastQuit(self, mode ) end
---@param self rdgs.CGameManager
function CGameManager.DebugSaveWithoutProperty(self) end
---kicks off a completeness check - see #CheckSavegameCompleteness for details
---@param self rdgs.CGameManager
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CGameManager.CheckSavegameCompleteness(self) end
---returns true if the test with given ids has finished
---@param self rdgs.CGameManager
---@param id std.size_t
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CGameManager.CheckSavegameCompleteness(self, id ) end
---queries a test with given id
---@param self rdgs.CGameManager
---@param id std.size_t
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CGameManager.CheckSavegameCompleteness(self, id ) end
---@return boolean returns true if weak pointer holds a valid reference
function CGameManager.isValid() end

return CGameManager
