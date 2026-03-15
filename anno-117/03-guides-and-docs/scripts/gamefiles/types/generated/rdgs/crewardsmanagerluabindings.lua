---@meta rdgs.CRewardsManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CRewardsManager
local CRewardsManager = {}
Rewards = CRewardsManager
---@param self rdgs.CRewardsManager
---@param guid integer
---@return boolean
function CRewardsManager.IsConnectReward(self, guid ) end
---@param self rdgs.CRewardsManager
---@param guid integer
---@return boolean
function CRewardsManager.IsConnectPlusReward(self, guid ) end
---@param self rdgs.CRewardsManager
---@param guid integer
---@return boolean
function CRewardsManager.IsHallOfFameReward(self, guid ) end
---@param self rdgs.CRewardsManager
---@param guid integer
---@return boolean
function CRewardsManager.IsTwitchReward(self, guid ) end
---@param self rdgs.CRewardsManager
---@param guid integer
---@return boolean
function CRewardsManager.IsPreorderReward(self, guid ) end
---@return boolean returns true if weak pointer holds a valid reference
function CRewardsManager.isValid() end

return CRewardsManager
