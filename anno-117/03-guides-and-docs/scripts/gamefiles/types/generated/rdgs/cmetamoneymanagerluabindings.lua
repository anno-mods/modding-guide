---@meta rdgs.CMetaMoneyManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CMetaMoneyManager
---@field TotalIncome number		returns the total income per minute (balance)
---@field ActiveLoans rdgs.CLoanState[]		returns all active loans for the current player
---@field PositiveMoneyPerCategory rdgs.CTextSourceListValue[]		returns balances for all categories that are positive except for loan
---@field NegativeMoneyPerCategory rdgs.CTextSourceListValue[]		returns balances for all categories that are negative except for loan
---@field TradeBalance integer		returns balances from all trades on owned islands in last trade balance period
---@field PassiveTradeBalance integer		returns balances from all passive trades on owned islands in last trade balance period
---@field ActiveTradeBalance integer		returns balances from all active trades in last trade balance period
local CMetaMoneyManager = {}
Money = CMetaMoneyManager
---@return boolean returns true if weak pointer holds a valid reference
function CMetaMoneyManager.isValid() end

return CMetaMoneyManager
