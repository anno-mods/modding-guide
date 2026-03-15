---@meta rdgs.CPropertyRecruitment
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPropertyRecruitment
---@field IsGarrisonAutoDeploymentActive boolean		
---@field CurrentConstructionGUID integer		Current Selected Construction Data
---@field Progress number		
---@field RemainingRelativeTime rdtime		
local CPropertyRecruitment = {}
---@param self rdgs.CPropertyRecruitment
---@param craftableGuid integer
---@return boolean
function CPropertyRecruitment.RequiresMilitiaRecruitmentPermits(self, craftableGuid ) end
---@param self rdgs.CPropertyRecruitment
---@param craftableGuid integer
---@return boolean
function CPropertyRecruitment.AllowsMilitiaPermitRecruitment(self, craftableGuid ) end
---@param self rdgs.CPropertyRecruitment
---@param craftableGuid integer
---@return integer
function CPropertyRecruitment.GetMaximumMilitiaRecruitmentPermits(self, craftableGuid ) end
---@param self rdgs.CPropertyRecruitment
---@param craftableGuid integer
---@return integer
function CPropertyRecruitment.GetUsedMilitiaRecruitmentPermits(self, craftableGuid ) end
---@param self rdgs.CPropertyRecruitment
---@param craftableGuid integer
---@return integer
function CPropertyRecruitment.GetAliveMilitiaRecruitment(self, craftableGuid ) end
---@param self rdgs.CPropertyRecruitment
---@param craftableGuid integer
---@return rdtime
function CPropertyRecruitment.GetRemainingMilitiaGarrisonRespawnTime(self, craftableGuid ) end
---@param self rdgs.CPropertyRecruitment
---@param craftableGuid integer
---@return rdtime
function CPropertyRecruitment.GetMaxMilitiaGarrisonRespawnTime(self, craftableGuid ) end
---@param self rdgs.CPropertyRecruitment
---@param guid integer
---@return boolean
function CPropertyRecruitment.GetIsCurrentConstructionGUID(self, guid ) end
---@param self rdgs.CPropertyRecruitment
---@param guid integer
---@return rdtime
function CPropertyRecruitment.ConstructionTime(self, guid ) end
---@param self rdgs.CPropertyRecruitment
---@param shipConfigurationID integer
---@return rdgs.CBuildCost
function CPropertyRecruitment.BuildCostForShip(self, shipConfigurationID ) end
---@param self rdgs.CPropertyRecruitment
---@param guid integer
---@return rdgs.CBuildCost
function CPropertyRecruitment.GetBuildCostForLandUnit(self, guid ) end
---@param self rdgs.CPropertyRecruitment
function CPropertyRecruitment.CheatSkipRemainingTime(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CPropertyRecruitment.isValid() end

return CPropertyRecruitment
