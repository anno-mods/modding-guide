---@meta rdgs.VirtualSpaceTechHandler
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.VirtualSpaceTechHandler
local VirtualSpaceTechHandler = {}
Static.GetKnowledgeRequirement = VirtualSpaceTechHandler
Static.GetTechUnlockRewards = VirtualSpaceTechHandler
Static.GetTechResourceRewards = VirtualSpaceTechHandler
Static.GetTechEffectRewards = VirtualSpaceTechHandler
Static.GetTechItemRewards = VirtualSpaceTechHandler
Static.GetInfoImage = VirtualSpaceTechHandler
Static.IsTechWithResearchableTrigger = VirtualSpaceTechHandler
Static.GetTechResearchableTrigger = VirtualSpaceTechHandler
---returns unlock requirement for a tech
---@param techGUID integer
---@return number
function VirtualSpaceTechHandler.GetKnowledgeRequirement(techGUID ) end
---@param techGUID integer
---@return rdgs.CTextSourceListValue[]
function VirtualSpaceTechHandler.GetTechUnlockRewards(techGUID ) end
---@param techGUID integer
---@return rdgs.CTextSourceListValue[]
function VirtualSpaceTechHandler.GetTechResourceRewards(techGUID ) end
---@param techGUID integer
---@return rdgs.CTextSourceListValue[]
function VirtualSpaceTechHandler.GetTechEffectRewards(techGUID ) end
---@param techGUID integer
---@return rdgs.CTextSourceListValue[]
function VirtualSpaceTechHandler.GetTechItemRewards(techGUID ) end
---@param techGUID integer
---@return integer
function VirtualSpaceTechHandler.GetInfoImage(techGUID ) end
---checks if a tech is not a gate but has a researchable trigger (may have a lock symbol) 
---@param techGUID integer
---@return boolean
function VirtualSpaceTechHandler.IsTechWithResearchableTrigger(techGUID ) end
---@param techGUID integer
---@return integer
function VirtualSpaceTechHandler.GetTechResearchableTrigger(techGUID ) end

return VirtualSpaceTechHandler
