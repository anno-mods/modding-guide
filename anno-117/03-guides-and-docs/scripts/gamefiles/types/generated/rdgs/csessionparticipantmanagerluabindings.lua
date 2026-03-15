---@meta rdgs.CSessionParticipantManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CSessionParticipantManager
local CSessionParticipantManager = {}
SessionParticipants = CSessionParticipantManager
---Returns GameObject belonging to given ParticipantGUID
---@param self rdgs.CSessionParticipantManager
---@param participantGUID rdgs.ParticipantGUID
---@return rdgs.CGameObject
function CSessionParticipantManager.GetParticipant(self, participantGUID ) end
---Only to be used for cheat!
---@param self rdgs.CSessionParticipantManager
---@param participantGUID rdgs.ParticipantGUID
function CSessionParticipantManager.CheatCreateSessionParticipant(self, participantGUID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CSessionParticipantManager.isValid() end

return CSessionParticipantManager
