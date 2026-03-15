---@meta rdgs.CSavegameManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CSavegameManager
---@field TimeSinceSaving number		 Returns how much time passed since the last savegame happened\n\\return \ttime passed since last savegame was written
local CSavegameManager = {}
Savegame = CSavegameManager
---@param self rdgs.CSavegameManager
---@param folderName string
function CSavegameManager.SetLiveSavegamesSourceFolder(self, folderName ) end
---@param self rdgs.CSavegameManager
function CSavegameManager.UpdateLiveSavegames(self) end
---@param self rdgs.CSavegameManager
---@param savegameSortHeader integer
function CSavegameManager.SortLiveSavegames(self, savegameSortHeader ) end
---@param self rdgs.CSavegameManager
---@param fileIndex integer
---@param load boolean
function CSavegameManager.DownloadLiveSavegames(self, fileIndex , load ) end
---@param self rdgs.CSavegameManager
function CSavegameManager.FillSavegameSpaceWithDummyFile(self) end
---@param self rdgs.CSavegameManager
---@param profileIndex integer
---@param savegameIndex integer
---@return rdgs.CGameSetup
function CSavegameManager.GetGameSetupForSavegame(self, profileIndex , savegameIndex ) end
---@param self rdgs.CSavegameManager
---@param file rdgs.SavegameFile
function CSavegameManager.DebugDumpSaveGameToDisk(self, file ) end
---@param self rdgs.CSavegameManager
function CSavegameManager.DebugDumpSaveGameToDisk(self) end
---@param self rdgs.CSavegameManager
function CSavegameManager.DebugDumpAllSaveGamesToDisk(self) end
---@param self rdgs.CSavegameManager
---@param savegameFolder string
function CSavegameManager.ChangeSavegamesSourceFolder(self, savegameFolder ) end
---@param self rdgs.CSavegameManager
function CSavegameManager.ResetSavegamesSourceFolder(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CSavegameManager.isValid() end

return CSavegameManager
