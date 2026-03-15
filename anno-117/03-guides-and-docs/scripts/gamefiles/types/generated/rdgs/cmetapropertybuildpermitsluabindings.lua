---@meta rdgs.CMetaPropertyBuildPermits
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CMetaPropertyBuildPermits
local CMetaPropertyBuildPermits = {}
BuildPermits = CMetaPropertyBuildPermits
---@param self rdgs.CMetaPropertyBuildPermits
---@param guid integer
---@return integer
function CMetaPropertyBuildPermits.GetBuildPermits(self, guid ) end
---@param self rdgs.CMetaPropertyBuildPermits
---@param guid integer
---@return boolean
function CMetaPropertyBuildPermits.GetNeedsBuildPermit(self, guid ) end
---@param self rdgs.CMetaPropertyBuildPermits
---@param amount integer
function CMetaPropertyBuildPermits.CheatAddBuildingPermits(self, amount ) end
---@return boolean returns true if weak pointer holds a valid reference
function CMetaPropertyBuildPermits.isValid() end

return CMetaPropertyBuildPermits
