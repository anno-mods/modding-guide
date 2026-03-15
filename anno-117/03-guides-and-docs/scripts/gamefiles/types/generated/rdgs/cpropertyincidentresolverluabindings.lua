---@meta rdgs.CPropertyIncidentResolver
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPropertyIncidentResolver
---@field IsFireInstitution boolean		
---@field IsRiotInstitution boolean		
---@field IsIllnessInstitution boolean		
---@field ResolverRange number		
---@field ResolverIncidentResolveDuration rdtime		
---@field ResolverRuinRepairDuration rdtime		
---@field CanResolverRepairRuins boolean		
---@field DefaultResolverMovementSpeed number		
---@field MaxResolverMovementSpeed number		
local CPropertyIncidentResolver = {}
---@param self rdgs.CPropertyIncidentResolver
---@param resolverIndex integer
---@return rdsdk.TextId
function CPropertyIncidentResolver.GetResolverStateText(self, resolverIndex ) end
---@return boolean returns true if weak pointer holds a valid reference
function CPropertyIncidentResolver.isValid() end

return CPropertyIncidentResolver
