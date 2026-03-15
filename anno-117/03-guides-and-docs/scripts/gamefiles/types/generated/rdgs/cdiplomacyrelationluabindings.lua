---@meta rdgs.CDiplomacyRelation
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CDiplomacyRelation
---@field WarState rdgs.CWarState		
local CDiplomacyRelation = {}
---@param self rdgs.CDiplomacyRelation
---@param state datasets.DiplomacyState
---@return boolean
function CDiplomacyRelation.IsInState(self, state ) end
---@param self rdgs.CDiplomacyRelation
---@param subState datasets.DiplomacySubState
---@param iteration integer
---@return boolean
function CDiplomacyRelation.IsSubstateActive(self, subState , iteration ) end
---@param self rdgs.CDiplomacyRelation
---@param subState datasets.DiplomacySubState
---@return boolean
function CDiplomacyRelation.IsSubstateActive(self, subState ) end
---@param self rdgs.CDiplomacyRelation
---@param actionGUID integer
---@return boolean
function CDiplomacyRelation.IsRenewThresholdReached(self, actionGUID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CDiplomacyRelation.isValid() end

return CDiplomacyRelation
