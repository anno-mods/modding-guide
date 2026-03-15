---@meta rdgs.CPerformanceTrackingManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPerformanceTrackingManager
local CPerformanceTrackingManager = {}
PerformanceTracking = CPerformanceTrackingManager
---@param self rdgs.CPerformanceTrackingManager
function CPerformanceTrackingManager.StartPerformanceTracking(self) end
---@param self rdgs.CPerformanceTrackingManager
function CPerformanceTrackingManager.StopPerformanceTracking(self) end
---@param self rdgs.CPerformanceTrackingManager
function CPerformanceTrackingManager.WritePerformanceTracking(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CPerformanceTrackingManager.isValid() end

return CPerformanceTrackingManager
