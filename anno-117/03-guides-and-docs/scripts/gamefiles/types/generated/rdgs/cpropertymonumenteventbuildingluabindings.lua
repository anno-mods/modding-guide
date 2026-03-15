---@meta rdgs.CPropertyMonumentEventBuilding
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPropertyMonumentEventBuilding
---@field IsEventPreparing boolean		
---@field IsEventRunning boolean		
---@field RemainingEventTime rdtime		
---@field EventWorkforce rdgs.CAsset		
---@field EventWorkforceUsed integer		
---@field NextBuffDuration rdtime		prediction on buff duration after event ends (only usable while event is preparing or running)
---@field EffectDurationLeft rdtime		returns the duration when the current effect will be running out. Returns 0 when there is no effect
local CPropertyMonumentEventBuilding = {}
---@param self rdgs.CPropertyMonumentEventBuilding
function CPropertyMonumentEventBuilding.CheatSkipEventTime(self) end
---@param self rdgs.CPropertyMonumentEventBuilding
---@param eventGUID integer
---@param requirementGUID integer
---@return string
function CPropertyMonumentEventBuilding.GetEventGoodsRange(self, eventGUID , requirementGUID ) end
---@param self rdgs.CPropertyMonumentEventBuilding
---@param eventGUID integer
---@return rdgs.CAsset
function CPropertyMonumentEventBuilding.GetEventWorkforceByGUID(self, eventGUID ) end
---@param self rdgs.CPropertyMonumentEventBuilding
---@param eventGUID integer
---@return integer
function CPropertyMonumentEventBuilding.GetEventMaxUsableWorkforceAmount(self, eventGUID ) end
---@param self rdgs.CPropertyMonumentEventBuilding
---@param eventGUID integer
---@return integer
function CPropertyMonumentEventBuilding.GetEventWorkforceUsedByGUID(self, eventGUID ) end
---@param self rdgs.CPropertyMonumentEventBuilding
---@param requirementGUID integer
---@return rdgs.CTextSourceListValue[]
function CPropertyMonumentEventBuilding.GetPossibleEventGoods(self, requirementGUID ) end
---monument event requests less preparation goods if more workforce is available
---@param self rdgs.CPropertyMonumentEventBuilding
---@param eventGUID integer
---@return integer
function CPropertyMonumentEventBuilding.GetEventGoodsReductionPercent(self, eventGUID ) end
---Returns true if the given monument event is banned/blocked by an asset
---@param self rdgs.CPropertyMonumentEventBuilding
---@param eventGUID integer
---@return boolean
function CPropertyMonumentEventBuilding.IsMonumentEventBanned(self, eventGUID ) end
---Returns the asset that blocks this event
---@param self rdgs.CPropertyMonumentEventBuilding
---@param eventGUID integer
---@return integer
function CPropertyMonumentEventBuilding.MonumentBannedReason(self, eventGUID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CPropertyMonumentEventBuilding.isValid() end

return CPropertyMonumentEventBuilding
