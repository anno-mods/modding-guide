---@meta rdgs.CAreaIncidentManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAreaIncidentManager
---@field ActiveMajorIncident rdgs.IIncident		
---@field IsMajorIncidentActive boolean		
---@field IsEscalatedMajorIncidentActive boolean		
local CAreaIncidentManager = {}
Incidents = CAreaIncidentManager
IsIncidentAttributeLowEnoughToTriggerNotification = CAreaIncidentManager
---@param self rdgs.CAreaIncidentManager
---@param type datasets.IncidentType
---@return rdtime
function CAreaIncidentManager.GetIncidentInterval(self, type ) end
---@param self rdgs.CAreaIncidentManager
---@param type datasets.IncidentType
---@return rdtime
function CAreaIncidentManager.GetTimeUntilNextTrigger(self, type ) end
---@param self rdgs.CAreaIncidentManager
---@param type datasets.IncidentType
---@return string
function CAreaIncidentManager.GetIncidentRangeName(self, type ) end
---@param self rdgs.CAreaIncidentManager
---@param type datasets.IncidentType
---@return string
function CAreaIncidentManager.GetIncidentRangeDescription(self, type ) end
---@param self rdgs.CAreaIncidentManager
---@param type datasets.IncidentType
---@return boolean
function CAreaIncidentManager.WarnAboutCurrentIncidentRange(self, type ) end
---@param self rdgs.CAreaIncidentManager
---@param attributeType datasets.NeedAttributeType
---@return boolean
function CAreaIncidentManager.IsNeedAttributeAboveCurrentDifficultyPreventionThreshold(self, attributeType ) end
---@param self rdgs.CAreaIncidentManager
---@param type datasets.IncidentType
---@return boolean
function CAreaIncidentManager.IsIncidentTypeBlockedByBuff(self, type ) end
---@param incidentCategoryInt integer
---@param areaIDInt integer
---@return boolean
function CAreaIncidentManager.IsIncidentAttributeLowEnoughToTriggerNotification(incidentCategoryInt , areaIDInt ) end
---@return boolean returns true if weak pointer holds a valid reference
function CAreaIncidentManager.isValid() end

return CAreaIncidentManager
