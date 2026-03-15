---@meta rdgs.CGameSetupSlot
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CGameSetupSlot
---@field IsUsed boolean		
---@field CompanyName string		
local CGameSetupSlot = {}
---@param self rdgs.CGameSetupSlot
---@param participant rdgs.ParticipantGUID
function CGameSetupSlot.SetSecondParty(self, participant ) end
---@return boolean returns true if weak pointer holds a valid reference
function CGameSetupSlot.isValid() end

return CGameSetupSlot
