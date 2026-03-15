---@meta rdgs.VirtualSpaceFactory
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.VirtualSpaceFactory
local VirtualSpaceFactory = {}
Static.GetInputs = VirtualSpaceFactory
Static.GetOutputs = VirtualSpaceFactory
Static.GetCycleTime = VirtualSpaceFactory
Static.GetNeededFertility = VirtualSpaceFactory
Static.CurrentAreaHasNeededFertility = VirtualSpaceFactory
Static.CurrentAreaFertilityLevel = VirtualSpaceFactory
---Static Data
---@param guid integer
---@return rdgs.CProductAmount[]
function VirtualSpaceFactory.GetInputs(guid ) end
---@param guid integer
---@return rdgs.CProductAmount[]
function VirtualSpaceFactory.GetOutputs(guid ) end
---@param guid integer
---@return rdtime
function VirtualSpaceFactory.GetCycleTime(guid ) end
---@param guid integer
---@return integer
function VirtualSpaceFactory.GetNeededFertility(guid ) end
---@param guid integer
---@return boolean
function VirtualSpaceFactory.CurrentAreaHasNeededFertility(guid ) end
---@param guid integer
---@return number
function VirtualSpaceFactory.CurrentAreaFertilityLevel(guid ) end

return VirtualSpaceFactory
