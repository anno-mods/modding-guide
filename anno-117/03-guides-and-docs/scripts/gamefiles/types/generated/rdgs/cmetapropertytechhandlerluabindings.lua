---@meta rdgs.CMetaPropertyTechHandler
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CMetaPropertyTechHandler
---@field IsTechTreeUsable boolean		returns true if the techtree is currently usable. If false, no techs can be researched
---@field TechTreeUsableThreshold integer		returns the knowledge unlock threshold for using the techtree
local CMetaPropertyTechHandler = {}
TechHandler = CMetaPropertyTechHandler
---forces visibility of a tech
---@param self rdgs.CMetaPropertyTechHandler
---@param techGUID integer
function CMetaPropertyTechHandler.MakeTechVisible(self, techGUID ) end
---checks if a lock symbol should be displayed on this tech (only use with IsTechWithResearchableTrigger)
---@param self rdgs.CMetaPropertyTechHandler
---@param techGUID integer
---@param skipVisibilityCheck boolean
---@return boolean
function CMetaPropertyTechHandler.IsTechResearchConditionResolved(self, techGUID , skipVisibilityCheck ) end
---checks if a lock symbol should be displayed on this tech (only use with IsTechWithResearchableTrigger)
---@param self rdgs.CMetaPropertyTechHandler
---@param techGUID integer
---@return boolean
function CMetaPropertyTechHandler.IsTechResearchConditionResolved(self, techGUID ) end
---unlocks a tech so it can be researched
---@param self rdgs.CMetaPropertyTechHandler
---@param techGUID integer
function CMetaPropertyTechHandler.MakeTechResearchable(self, techGUID ) end
---finishes the progress of a tech, rewards are executed
---@param self rdgs.CMetaPropertyTechHandler
---@param techGUID integer
---@param triggerNotificationAndUnlockNeighbors boolean
function CMetaPropertyTechHandler.CompleteTechResearch(self, techGUID , triggerNotificationAndUnlockNeighbors ) end
---reset the tech to not visible, visibility trigger is reactivated
---@param self rdgs.CMetaPropertyTechHandler
---@param techGUID integer
function CMetaPropertyTechHandler.ResetTech(self, techGUID ) end
---makes all existing techs at least visible
---@param self rdgs.CMetaPropertyTechHandler
function CMetaPropertyTechHandler.CheatVisibleAll(self) end
---makes all existing techs at least researchable
---@param self rdgs.CMetaPropertyTechHandler
function CMetaPropertyTechHandler.CheatResearchableAll(self) end
---calls CompleteTechResearch for all existing techs and unlocks them
---@param self rdgs.CMetaPropertyTechHandler
function CMetaPropertyTechHandler.CheatResearchAll(self) end
---calls ResetTech for all existing techs
---@param self rdgs.CMetaPropertyTechHandler
function CMetaPropertyTechHandler.CheatResetAll(self) end
---calls CompleteTechResearch or ResetTech for all existing techs
---@param self rdgs.CMetaPropertyTechHandler
function CMetaPropertyTechHandler.CheatToggleResearchAll(self) end
---returns true if tech can be researched multiple times
---@param self rdgs.CMetaPropertyTechHandler
---@param techGUID integer
---@return boolean
function CMetaPropertyTechHandler.TechIsRepeatable(self, techGUID ) end
---returns progress of a tech [0..1]
---@param self rdgs.CMetaPropertyTechHandler
---@param techGUID integer
---@return number
function CMetaPropertyTechHandler.GetTechProgress(self, techGUID ) end
---predicts Duration depending on current GetKnowledgePerMinute, only usable for UI
---@param self rdgs.CMetaPropertyTechHandler
---@param techGUID integer
---@return rdtime
function CMetaPropertyTechHandler.GetRemainingTechDuration(self, techGUID ) end
---returns remaining knowledge needed to research a tech
---@param self rdgs.CMetaPropertyTechHandler
---@param techGUID integer
---@return number
function CMetaPropertyTechHandler.GetRemainingKnowledgeCost(self, techGUID ) end
---returns already used knowledge for a tech
---@param self rdgs.CMetaPropertyTechHandler
---@param techGUID integer
---@return number
function CMetaPropertyTechHandler.GetPaidKnowledgeCost(self, techGUID ) end
---returns full knowledge needed to research a tech (includes exponential increase for repeatable techs)
---@param self rdgs.CMetaPropertyTechHandler
---@param techGUID integer
---@return number
function CMetaPropertyTechHandler.GetKnowledgeCost(self, techGUID ) end
---returns current icon of tech (depending on current unlock state)
---@param self rdgs.CMetaPropertyTechHandler
---@param techGUID integer
---@return rdgs.CAsset
function CMetaPropertyTechHandler.GetTechIcon(self, techGUID ) end
---returns current name of tech (depending on current unlock state)
---@param self rdgs.CMetaPropertyTechHandler
---@param techGUID integer
---@return rdsdk.TextId
function CMetaPropertyTechHandler.GetTechName(self, techGUID ) end
---returns current description of tech (depending on current unlock state)
---@param self rdgs.CMetaPropertyTechHandler
---@param techGUID integer
---@return rdsdk.TextId
function CMetaPropertyTechHandler.GetTechDescription(self, techGUID ) end
---@param self rdgs.CMetaPropertyTechHandler
---@param techGUID integer
function CMetaPropertyTechHandler.StartTech(self, techGUID ) end
---@param self rdgs.CMetaPropertyTechHandler
---@param techGUID integer
function CMetaPropertyTechHandler.StopTech(self, techGUID ) end
---returns 0 if tech is not in queue or position 
---@param self rdgs.CMetaPropertyTechHandler
---@param techGUID integer
---@return integer
function CMetaPropertyTechHandler.GetQueuePosition(self, techGUID ) end
---@param self rdgs.CMetaPropertyTechHandler
---@param queuePosStartingwith0 integer
---@return rdgs.CAsset
function CMetaPropertyTechHandler.GetTechAtQueuePosition(self, queuePosStartingwith0 ) end
---@param self rdgs.CMetaPropertyTechHandler
---@param techGUID integer
---@return integer
function CMetaPropertyTechHandler.GetRepeatableResearchedCount(self, techGUID ) end
---@param self rdgs.CMetaPropertyTechHandler
---@param techGUID integer
function CMetaPropertyTechHandler.ToggleConditionTreeVisibility(self, techGUID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CMetaPropertyTechHandler.isValid() end

return CMetaPropertyTechHandler
