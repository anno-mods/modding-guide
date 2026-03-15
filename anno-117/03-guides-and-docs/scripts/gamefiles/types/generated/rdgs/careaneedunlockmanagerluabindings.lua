---@meta rdgs.CAreaNeedUnlockManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAreaNeedUnlockManager
local CAreaNeedUnlockManager = {}
AreaNeedUnlock = CAreaNeedUnlockManager
---@param self rdgs.CAreaNeedUnlockManager
---@param populationGUID integer
---@param productGUID rdgs.ProductGUID
---@return boolean
function CAreaNeedUnlockManager.NeedLocked(self, populationGUID , productGUID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CAreaNeedUnlockManager.isValid() end

return CAreaNeedUnlockManager
