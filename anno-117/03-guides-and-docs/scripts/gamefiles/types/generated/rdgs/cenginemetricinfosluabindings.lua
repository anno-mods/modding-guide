---@meta rdgs.CEngineMetricInfos
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CEngineMetricInfos
local CEngineMetricInfos = {}
EngineMetrics = CEngineMetricInfos
---@param self rdgs.CEngineMetricInfos
---@param guid integer
function CEngineMetricInfos.ToggleSession(self, guid ) end
---@param self rdgs.CEngineMetricInfos
---@param participantGUID integer
function CEngineMetricInfos.ToggleParticipant(self, participantGUID ) end
---@param self rdgs.CEngineMetricInfos
---@param propertyID integer
function CEngineMetricInfos.ToggleProperty(self, propertyID ) end
---@param self rdgs.CEngineMetricInfos
function CEngineMetricInfos.ClearParticipantFilter(self) end
---@param self rdgs.CEngineMetricInfos
---@param search string
function CEngineMetricInfos.SetPropertySearch(self, search ) end
---@param self rdgs.CEngineMetricInfos
function CEngineMetricInfos.ResetPropertySearch(self) end
---@param self rdgs.CEngineMetricInfos
function CEngineMetricInfos.UpdatePropertyMeshStatistic(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CEngineMetricInfos.isValid() end

return CEngineMetricInfos
