---@meta rdgs.CAccountManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAccountManager
local CAccountManager = {}
Account = CAccountManager
---@param self rdgs.CAccountManager
function CAccountManager.DownloadCrossProgressionSavegame(self) end
---@param self rdgs.CAccountManager
---@param savegame rdgs.SavegameFile
function CAccountManager.UploadCrossProgressionSavegame(self, savegame ) end
---@param self rdgs.CAccountManager
function CAccountManager.UploadCrossProgressionSavegame(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CAccountManager.isValid() end

return CAccountManager
