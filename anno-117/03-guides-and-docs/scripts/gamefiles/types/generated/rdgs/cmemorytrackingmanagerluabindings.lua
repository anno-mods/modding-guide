---@meta rdgs.CMemoryTrackingManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CMemoryTrackingManager
local CMemoryTrackingManager = {}
MemoryTracking = CMemoryTrackingManager
---@param self rdgs.CMemoryTrackingManager
---@param str string
function CMemoryTrackingManager.SetMemoryDebugBreakContext(self, str ) end
---@param self rdgs.CMemoryTrackingManager
---@param str string
function CMemoryTrackingManager.ListTypes(self, str ) end
---@param self rdgs.CMemoryTrackingManager
---@param str string
function CMemoryTrackingManager.SetMemoryDebugBreakType(self, str ) end
---@param self rdgs.CMemoryTrackingManager
---@param str string
function CMemoryTrackingManager.StartSamplingContext(self, str ) end
---@param self rdgs.CMemoryTrackingManager
---@param str string
function CMemoryTrackingManager.StopSamplingContext(self, str ) end
---@param self rdgs.CMemoryTrackingManager
---@param str string
function CMemoryTrackingManager.SetMemoryAllocationSamplingMax(self, str ) end
---@param self rdgs.CMemoryTrackingManager
---@param str string
function CMemoryTrackingManager.SetMemoryAllocationSamplingPeriod(self, str ) end
---@param self rdgs.CMemoryTrackingManager
---@param str string
function CMemoryTrackingManager.SetMemoryAllocationSamplingContext(self, str ) end
---@param self rdgs.CMemoryTrackingManager
---@param str string
function CMemoryTrackingManager.SetMemoryDisplayThreshold(self, str ) end
---@param self rdgs.CMemoryTrackingManager
function CMemoryTrackingManager.SaveMemoryInfo(self) end
---@param self rdgs.CMemoryTrackingManager
function CMemoryTrackingManager.CreateMemorySnapshot(self) end
---@param self rdgs.CMemoryTrackingManager
---@param str string
function CMemoryTrackingManager.SelectMemorySnapshot(self, str ) end
---@param self rdgs.CMemoryTrackingManager
---@param str string
function CMemoryTrackingManager.ToggleMemTreeVisibility(self, str ) end
---@param self rdgs.CMemoryTrackingManager
---@param str string
function CMemoryTrackingManager.ToggleMemResourcesVisibility(self, str ) end
---@param self rdgs.CMemoryTrackingManager
---@param str string
function CMemoryTrackingManager.ToggleMemPoolResourcesVisibility(self, str ) end
---@param self rdgs.CMemoryTrackingManager
---@param str string
function CMemoryTrackingManager.ToggleMemObjectPoolVisibility(self, str ) end
---@return boolean returns true if weak pointer holds a valid reference
function CMemoryTrackingManager.isValid() end

return CMemoryTrackingManager
