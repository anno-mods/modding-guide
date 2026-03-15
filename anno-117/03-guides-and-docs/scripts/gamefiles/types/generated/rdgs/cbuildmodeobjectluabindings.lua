---@meta rdgs.CBuildModeObject
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CBuildModeObject
---@field IsInBlueprintMode boolean		
---@field IsSnapped boolean		
---@field IsTerrainTypeValid boolean		
---@field CannotBePlacedOnMarsh boolean		
---@field CannotBePlacedOnStaticMarsh boolean		
---@field CanOnlyBePlacedOnMarsh boolean		
---@field IsOverlappingSameGUIDRadius boolean		
---@field HasNeededFertility boolean		
---@field FertilityLevel number		
---@field IsNotAdjacent boolean		 true if a module should be build and it is not adjacent
---@field IsIrrigationMissing boolean		
---@field IsAreaBlocked boolean		 true if a building cannot be build because the area is blocked
---@field IsModuleLimitReached boolean		 true if module limit reached
---@field IsMainModule boolean		
---@field IsThreatened boolean		 true if build position is threatened by enemy military
---@field IsAreaNotFullyClaimed boolean		 true if a building cannot be build because the area is not fully claimed
---@field IsAccessToSeaBlockedByPreview boolean		 true if a preview building needs a water path to the open sea, but could not find any
---@field IsAccessToSeaBlockedByExisting boolean		 true if a existing building needs a water path to the open sea, but could not find any
---@field IsHarborBlockerBlocked boolean		 true if the area in front of a harbor building is blocked
---@field IsTerrainTooSteep boolean		 true if a building cannot be build because the terrain is too steep
---@field Object rdgs.CGameObject		
---@field FunctionalEffectNewTargetCount integer		how many buildings are newly affected by the functional effect of current preview
---@field NeedAttributeBoostTargetCount integer		
---@field NeedAttributeBoostTargetCountPositive integer		
---@field NeedAttributeBoostTargetCountNegative integer		
---@field IsMovePossible boolean		
local CBuildModeObject = {}
---@see IBuildMode parent class
---@param self rdgs.CBuildModeObject
---@param rotateDirection rdsdk.RotateDirection
function CBuildModeObject.ChangeDirection(self, rotateDirection ) end
---@param self rdgs.CBuildModeObject
---@param direction rdsdk.Direction8
function CBuildModeObject.SetDirection(self, direction ) end
---@return boolean returns true if weak pointer holds a valid reference
function CBuildModeObject.isValid() end
---@param self rdgs.CBuildModeObject
---@param effectGUID integer
---@param buffGUID integer
---@return integer
function CBuildModeObject.GetBuffNewTargetCount(self, effectGUID , buffGUID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CBuildModeObject.isValid() end

return CBuildModeObject
