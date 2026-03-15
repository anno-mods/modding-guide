---@meta rdgs.CModManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CModManager
---@field IsModded boolean		
---@field WasGameModded boolean		IsModded was true once since game start. Mostly for debugging reload side effects.
---@field WasSaveModded boolean		IsModded was true once for current save game - even before across game starts. Fetched from GameSetup
---@field LoadedModIDs string[]		
local CModManager = {}
Mods = CModManager
---@param self rdgs.CModManager
function CModManager.LoadMods(self) end
---@param self rdgs.CModManager
function CModManager.UnloadMods(self) end
---@param self rdgs.CModManager
---@param folderPath string
function CModManager.AddModsFolder(self, folderPath ) end
---@param self rdgs.CModManager
function CModManager.RemoveLastModsFolder(self) end
---@param self rdgs.CModManager
---@param modId string
function CModManager.EnableMod(self, modId ) end
---@param self rdgs.CModManager
---@param modId string
function CModManager.DisableMod(self, modId ) end
---@return boolean returns true if weak pointer holds a valid reference
function CModManager.isValid() end

return CModManager
