---@meta rdgs.CVolcanoEruptionManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CVolcanoEruptionManager
local CVolcanoEruptionManager = {}
Volcano = CVolcanoEruptionManager
---@param self rdgs.CVolcanoEruptionManager
---@param participantGuid rdgs.ParticipantGUID
---@return integer
function CVolcanoEruptionManager.GetCurrentOverdriveFactor(self, participantGuid ) end
---@param self rdgs.CVolcanoEruptionManager
---@param participantGuid rdgs.ParticipantGUID
---@return integer
function CVolcanoEruptionManager.GetMaximumOverdriveFactor(self, participantGuid ) end
---@return boolean returns true if weak pointer holds a valid reference
function CVolcanoEruptionManager.isValid() end

return CVolcanoEruptionManager
