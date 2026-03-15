---@meta rdgs.CGlobalCheats
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CGlobalCheats
---@field IgnoreBuildingCosts boolean		
---@field IgnoreFertilities boolean		
---@field IgnoreThreats boolean		
---@field IsUndiscoveredDisabled boolean		
---@field IncidentsDisabled boolean		
---@field SuperShipSpeedEnabled boolean		
---@field ConstructionAIEnabled boolean		
---@field DeferExpensiveEconomy boolean		
---@field EconomySpeed number		
---@field IsProductivityCheated boolean		
---@field IsAttackDebugView boolean		
---@field IsLOSDebugView boolean		
---@field IsWinLoseConditionsDisabled boolean		
---@field IsAllPerfSamplesUploaded boolean		
local CGlobalCheats = {}
---@param self rdgs.CGlobalCheats
---@param cheat rdgs.GlobalCheat
function CGlobalCheats.ToggleCheatStateNet(self, cheat ) end
---@param self rdgs.CGlobalCheats
function CGlobalCheats.ToggleIgnoreBuildingCosts(self) end
---@param self rdgs.CGlobalCheats
function CGlobalCheats.ToggleIgnoreFertilities(self) end
---@param self rdgs.CGlobalCheats
function CGlobalCheats.ToggleIgnoreThreats(self) end
---@param self rdgs.CGlobalCheats
function CGlobalCheats.DisableUndiscovered(self) end
---@param self rdgs.CGlobalCheats
function CGlobalCheats.ToggleIncidents(self) end
---@param self rdgs.CGlobalCheats
function CGlobalCheats.ToggleSuperShipSpeed(self) end
---@param self rdgs.CGlobalCheats
function CGlobalCheats.ToggleConstructionAIEnabled(self) end
---@param self rdgs.CGlobalCheats
function CGlobalCheats.ToggleDeferExpensiveEconomy(self) end
---@param self rdgs.CGlobalCheats
function CGlobalCheats.ToggleDeferExpensiveQuestSystem(self) end
---@param self rdgs.CGlobalCheats
function CGlobalCheats.ToggleProductivity(self) end
---@param self rdgs.CGlobalCheats
function CGlobalCheats.ToggleAttackDebugView(self) end
---@param self rdgs.CGlobalCheats
function CGlobalCheats.ToggleLOSDebugView(self) end
---@param self rdgs.CGlobalCheats
function CGlobalCheats.ToggleUnlockAllForHumans(self) end
---@param self rdgs.CGlobalCheats
function CGlobalCheats.ToggleUseDebugCameraZoomLevels(self) end
---@param self rdgs.CGlobalCheats
function CGlobalCheats.ToggleUpgradeCheck(self) end
---@param self rdgs.CGlobalCheats
function CGlobalCheats.ToggleHappyDaysDisabled(self) end
---@param self rdgs.CGlobalCheats
function CGlobalCheats.DisableWinLoseConditions(self) end
---@param self rdgs.CGlobalCheats
---@param debuggingType integer
function CGlobalCheats.ToggleExtendedDebugging(self, debuggingType ) end
---@param self rdgs.CGlobalCheats
function CGlobalCheats.ToggleMemoryTracking(self) end
---@param self rdgs.CGlobalCheats
function CGlobalCheats.ToggleGearPerfProfiler(self) end
---@param self rdgs.CGlobalCheats
function CGlobalCheats.StartAutoProfiler(self) end
---@param self rdgs.CGlobalCheats
function CGlobalCheats.StopAutoProfiler(self) end
---@param self rdgs.CGlobalCheats
---@param xptype string
function CGlobalCheats.SetGearPerfSamplingXPType(self, xptype ) end
---select the timing used for capture in Gear or Telemetry 
---@param self rdgs.CGlobalCheats
---@param gameTiming boolean
function CGlobalCheats.SelectPerformanceGameTiming(self, gameTiming ) end
---will capture a sample using the continuous profiler and send it to PAP using TGDP-Client 
---@param self rdgs.CGlobalCheats
---@param profilingType string
---@param xpType string
---@param gameTiming boolean
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CGlobalCheats.CapturePAPSample(self, profilingType , xpType , gameTiming ) end
---returns true, once the ongoing capture is finished and sent to PAP backend
---@param self rdgs.CGlobalCheats
---@async
---@return rdgs.CAsyncFunction returns a future that can be waited for by using await(...)
function CGlobalCheats.CapturePAPSample(self) end
---@param self rdgs.CGlobalCheats
function CGlobalCheats.LoadLivePP(self) end
---@param self rdgs.CGlobalCheats
function CGlobalCheats.ToggleBlockBannerNotifications(self) end
---@param self rdgs.CGlobalCheats
function CGlobalCheats.ToggleSessionSwitchUISkipped(self) end
---@param self rdgs.CGlobalCheats
function CGlobalCheats.ToggleLetterboxingDisabled(self) end
---@param self rdgs.CGlobalCheats
function CGlobalCheats.EnableTrailerMovieHacks(self) end
---@param self rdgs.CGlobalCheats
function CGlobalCheats.EnableVegetationDebugging(self) end
---@param self rdgs.CGlobalCheats
function CGlobalCheats.ToggleSuppressDebugDrawings(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CGlobalCheats.isValid() end

return CGlobalCheats
