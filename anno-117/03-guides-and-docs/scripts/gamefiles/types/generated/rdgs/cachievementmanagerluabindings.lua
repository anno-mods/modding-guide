---@meta rdgs.CAchievementManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAchievementManager
local CAchievementManager = {}
Achievements = CAchievementManager
---@param self rdgs.CAchievementManager
function CAchievementManager.LockAll(self) end
---@param self rdgs.CAchievementManager
function CAchievementManager.UnlockAll(self) end
---@param self rdgs.CAchievementManager
---@param category integer
function CAchievementManager.UnlockByCategory(self, category ) end
---@return boolean returns true if weak pointer holds a valid reference
function CAchievementManager.isValid() end

return CAchievementManager
