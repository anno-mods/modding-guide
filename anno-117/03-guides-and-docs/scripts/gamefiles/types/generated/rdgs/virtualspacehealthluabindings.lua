---@meta rdgs.VirtualSpaceHealth
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.VirtualSpaceHealth
local VirtualSpaceHealth = {}
Static.GetBaseHealth = VirtualSpaceHealth
Static.GetSelfHealPerTick = VirtualSpaceHealth
---TextSources
---@param guid integer
---@return integer
function VirtualSpaceHealth.GetBaseHealth(guid ) end
---@param guid integer
---@return number
function VirtualSpaceHealth.GetSelfHealPerTick(guid ) end

return VirtualSpaceHealth
