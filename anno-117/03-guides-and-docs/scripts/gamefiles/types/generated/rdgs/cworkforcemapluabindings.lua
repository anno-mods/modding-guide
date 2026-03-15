---@meta rdgs.CWorkforceMap
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CWorkforceMap
local CWorkforceMap = {}
---@param self rdgs.CWorkforceMap
---@param workforceGuid integer
---@return number
function CWorkforceMap.GetProduction(self, workforceGuid ) end
---@param self rdgs.CWorkforceMap
---@param workforceGuid integer
---@return number
function CWorkforceMap.GetConsumption(self, workforceGuid ) end
---@param self rdgs.CWorkforceMap
---@param workforceGuid integer
---@return number
function CWorkforceMap.GetBalance(self, workforceGuid ) end

return CWorkforceMap
