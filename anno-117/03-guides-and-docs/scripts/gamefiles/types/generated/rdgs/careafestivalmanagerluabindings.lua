---@meta rdgs.CAreaFestivalManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAreaFestivalManager
---@field IsFestivalRunning boolean		
---@field RunningFestivalGUID integer		
---@field RunningFestivalEffectGUIDs rdgs.CTextSourceListValue[]		
---@field RemainingFestivalDuration rdtime		
local CAreaFestivalManager = {}
Festival = CAreaFestivalManager
FestivalFromArea = CAreaFestivalManager
GetFestivalDuration = CAreaFestivalManager
---@param areaID rdgs.AreaID
---@return rdgs.CAreaFestivalManager
function CAreaFestivalManager.FestivalFromArea(areaID ) end
---@param self rdgs.CAreaFestivalManager
---@param attribute datasets.NeedAttributeType
---@return rdtime
function CAreaFestivalManager.GetFestivalIntervalBasedOnCurrentAttributes(self, attribute ) end
---@param festivalGUID integer
---@return rdtime
function CAreaFestivalManager.GetFestivalDuration(festivalGUID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CAreaFestivalManager.isValid() end

return CAreaFestivalManager
