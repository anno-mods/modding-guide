---@meta rdgs.CSessionFeedbackManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CSessionFeedbackManager
local CSessionFeedbackManager = {}
Feedback = CSessionFeedbackManager
---@param self rdgs.CSessionFeedbackManager
function CSessionFeedbackManager.ToggleAllFeedbackUnits(self) end
---Hide specific Feedback in Area. Should only be used by content design (as we use name as identifier here. Better usage: Register it directly at PerBuildingAreaFeedback)
---@param self rdgs.CSessionFeedbackManager
---@param name string
---@param centerX integer
---@param centerZ integer
---@param radius integer
---@param hideVehicles boolean
---@param hidePersons boolean
function CSessionFeedbackManager.HideFeedbackInArea(self, name , centerX , centerZ , radius , hideVehicles , hidePersons ) end
---Name as identifier: Should only be used by content design
---@param self rdgs.CSessionFeedbackManager
---@param name string
function CSessionFeedbackManager.UnHideFeedbackInArea(self, name ) end
---@param self rdgs.CSessionFeedbackManager
---@param behaviourType integer
function CSessionFeedbackManager.SetBehaviourFilter(self, behaviourType ) end
---@return boolean returns true if weak pointer holds a valid reference
function CSessionFeedbackManager.isValid() end

return CSessionFeedbackManager
