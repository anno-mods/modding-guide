---@meta rdgs.CSeasonManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CSeasonManager
---@field ActiveSeason integer		
---@field NextSeason integer		
---@field RemainingSeasonTime rdtime		
---@field NextSeasonType string		
---@field NextSeasonName string		
---@field NextSeasonFluffText string		
---@field CurrentSeasonFluffText string		
local CSeasonManager = {}
Season = CSeasonManager
---@param self rdgs.CSeasonManager
---@param enabled boolean
function CSeasonManager.SetEnabled(self, enabled ) end
---Sets current season close to end. Will not immediately end it, to have a better visual transition
---@param self rdgs.CSeasonManager
function CSeasonManager.CheatEndCurrentSeasonIn20s(self) end
---@param self rdgs.CSeasonManager
function CSeasonManager.CheatToggleSkipVisualUpdates(self) end
---@param self rdgs.CSeasonManager
---@param seasonGUID integer
---@param priority integer
function CSeasonManager.CheatOverwriteNextSeason(self, seasonGUID , priority ) end
---@param self rdgs.CSeasonManager
---@param guid integer
---@return integer
function CSeasonManager.GetCurrentSeasonTradeBuff(self, guid ) end
---@param self rdgs.CSeasonManager
---@param guid integer
---@return rdgs.CTextSourceListValue[]
function CSeasonManager.GetCurrentSeasonTradeGoods(self, guid ) end
---@param self rdgs.CSeasonManager
---@param guid integer
---@return boolean
function CSeasonManager.CurrentSeasonAllGoods(self, guid ) end
---@param self rdgs.CSeasonManager
---@param guid integer
---@return string
function CSeasonManager.GetCurrentSeasonTradeGoodsName(self, guid ) end
---@param self rdgs.CSeasonManager
---@param guid integer
---@return string
function CSeasonManager.GetCurrentSeasonTradeGoodsFluff(self, guid ) end
---@return boolean returns true if weak pointer holds a valid reference
function CSeasonManager.isValid() end

return CSeasonManager
