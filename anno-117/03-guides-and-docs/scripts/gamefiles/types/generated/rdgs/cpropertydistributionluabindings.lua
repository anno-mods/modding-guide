---@meta rdgs.CPropertyDistribution
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPropertyDistribution
---@field DistributionProduct integer		
local CPropertyDistribution = {}
---@param self rdgs.CPropertyDistribution
---@param productGUID integer
---@return integer
function CPropertyDistribution.DistributionAmount(self, productGUID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CPropertyDistribution.isValid() end

return CPropertyDistribution
