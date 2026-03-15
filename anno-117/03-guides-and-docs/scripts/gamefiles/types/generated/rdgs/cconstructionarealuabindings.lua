---@meta rdgs.CConstructionArea
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CConstructionArea
---@field ID rdgs.AreaID		
---@field OwnerName string		
---@field OwnerIcon string		
---@field IsInVassalState boolean		
---@field VassalOrAreaOwner rdgs.ParticipantGUID		
---@field AreaOwnerIsCurrentParticipant boolean		
---@field Owner rdgs.ParticipantGUID		
---@field IsOwnedByAnyone boolean		
---@field IsOwnedByCurrentParticipant boolean		
---@field KontorID rdgs.GameObjectID		
---@field KontorCost rdgs.CBuildCost		
---@field Fertilities integer[]		
---@field Lodes integer[]		
---@field CityName string		
---@field Economy rdgs.CAreaEconomy		
---@field HasAreaEconomy boolean		
---@field AreaNeedAttributes rdgs.CAreaNeedAttributeManager		
---@field PassiveTrade rdgs.CPassiveTradeController		
---@field LimitedLode rdgs.CLimitedLodeComponent		
---@field HasTradeRights boolean		
---@field IsIslandWarActive boolean		
local CConstructionArea = {}
---how many settlement rights are needed to build a kontor on this area?
---@param self rdgs.CConstructionArea
---@param participant rdgs.ParticipantGUID
---@return rdgs.ProductAmount
function CConstructionArea.GetSettlementRightCost(self, participant ) end
---@param self rdgs.CConstructionArea
---@param participant rdgs.ParticipantGUID
---@param takeoverMode datasets.TakeOverTransformation
function CConstructionArea.Takeover(self, participant , takeoverMode ) end
---@param self rdgs.CConstructionArea
---@param guid integer
---@return rdgs.CTextSourceListValue[]
function CConstructionArea.GetListOfObjectsFromSameRecipeCount(self, guid ) end
---@param self rdgs.CConstructionArea
---@param buildingGuid integer
---@return boolean
function CConstructionArea.IsDuplicate(self, buildingGuid ) end
---@return boolean returns true if weak pointer holds a valid reference
function CConstructionArea.isValid() end

return CConstructionArea
