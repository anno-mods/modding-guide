---@meta rdgs.CWarState
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CWarState
---@field AttackerParticipant rdgs.ParticipantGUID		
---@field DefenderParticipant rdgs.ParticipantGUID		
---@field GetAttackerAllies rdgs.ParticipantGUID[]		
---@field GetDefenderAllies rdgs.ParticipantGUID[]		
---@field TargetWarScore integer		
---@field AttackerWarScore integer		
---@field DefenderWarScore integer		
---@field IsCeaseFireActive boolean		
---@field IsFeud boolean		
---@field IsFullWar boolean		
---@field IsAnnihilation boolean		
---@field IsPirateWar boolean		
---@field IsRebellionWar boolean		
local CWarState = {}
---@param self rdgs.CWarState
---@param participant rdgs.ParticipantGUID
---@return boolean
function CWarState.IsDominating(self, participant ) end
---@param self rdgs.CWarState
---@param participant rdgs.ParticipantGUID
---@return boolean
function CWarState.IsStruggling(self, participant ) end
---@param self rdgs.CWarState
---@param participant rdgs.ParticipantGUID
---@return boolean
function CWarState.IsCloseToWin(self, participant ) end
---@param self rdgs.CWarState
---@param participant rdgs.ParticipantGUID
---@return boolean
function CWarState.IsCloseToLoss(self, participant ) end
---@return boolean returns true if weak pointer holds a valid reference
function CWarState.isValid() end

return CWarState
