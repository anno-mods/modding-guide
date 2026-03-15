---@meta rdgs.CMetaGameLoader
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CMetaGameLoader
---@field PlayTime rdtime		
local CMetaGameLoader = {}
---New Savegame, asynchronously. Returns the requested savegame name as identifier to check if saving has finished.
---@param self rdgs.CMetaGameLoader
---@param savegameName string
---@param canOverride boolean
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CMetaGameLoader.Save(self, savegameName , canOverride ) end
---New Savegame, asynchronously. Returns the requested savegame name as identifier to check if saving has finished.
---@param self rdgs.CMetaGameLoader
---@param savegameName string
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CMetaGameLoader.Save(self, savegameName ) end
---@param self rdgs.CMetaGameLoader
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CMetaGameLoader.Save(self) end
---load a savegame by filename. Checks first, if name is a profile name. If so, profiles newest savegame will be loaded\nOtherwise it gathers fileinfo and starts loading of given file. If meta game is running, it will be unloaded first.
---@param self rdgs.CMetaGameLoader
---@param savegameName string
---@param enterLoadingState boolean
---@param skipSetSailButton boolean
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CMetaGameLoader.Load(self, savegameName , enterLoadingState , skipSetSailButton ) end
---@param self rdgs.CMetaGameLoader
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CMetaGameLoader.Load(self) end
---@param self rdgs.CMetaGameLoader
---@param sessionGUID integer
function CMetaGameLoader.EnterCorrectLoadingScene(self, sessionGUID ) end
---@param self rdgs.CMetaGameLoader
function CMetaGameLoader.EnterCorrectLoadingScene(self) end
---@param self rdgs.CMetaGameLoader
function CMetaGameLoader.SaveGameWithPopup(self) end
---@param self rdgs.CMetaGameLoader
function CMetaGameLoader.SaveGame(self) end
---@param self rdgs.CMetaGameLoader
function CMetaGameLoader.QueueCampaignBackup(self) end
---@param self rdgs.CMetaGameLoader
---@param cheatForce boolean
function CMetaGameLoader.PushSavegameQuota(self, cheatForce ) end
---@param self rdgs.CMetaGameLoader
function CMetaGameLoader.PushSavegameQuota(self) end
---unload current corporation. This must happen in FullSync. If not, it will be deferred to.\nin case you want to execute something right after unloading finished, provide a lambda as first parameter.
---@param self rdgs.CMetaGameLoader
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CMetaGameLoader.Unload(self) end
---@param self rdgs.CMetaGameLoader
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CMetaGameLoader.Unload(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CMetaGameLoader.isValid() end

return CMetaGameLoader
