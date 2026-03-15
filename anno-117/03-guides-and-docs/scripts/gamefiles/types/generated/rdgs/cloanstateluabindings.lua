---@meta rdgs.CLoanState
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CLoanState
---@field MoneyBalanceForCurrentParticipant number		
---@field MoneyBalanceUnsigned number		
---@field LoanSum integer		
---@field TotalLoanCost integer		
---@field InterestRate integer		
---@field TotalPaybackTime rdtime		
---@field RemainingPaybackTime rdtime		
---@field Lender rdgs.ParticipantGUID		
---@field Debtor rdgs.ParticipantGUID		
local CLoanState = {}
LoanState = CLoanState
---@param actionGuid integer
---@param lender rdgs.ParticipantGUID
---@param debtor rdgs.ParticipantGUID
---@return rdgs.CLoanState
function CLoanState.LoanState(actionGuid , lender , debtor ) end
---@return boolean returns true if weak pointer holds a valid reference
function CLoanState.isValid() end

return CLoanState
