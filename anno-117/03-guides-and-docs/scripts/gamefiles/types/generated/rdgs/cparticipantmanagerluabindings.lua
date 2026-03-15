---@meta rdgs.CParticipantManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CParticipantManager
---@field GetCurrentParticipantGUID rdgs.ParticipantGUID		Gets the participant that is currently controlled.
---@field Current rdgs.CMetaGameObject		Returns the current participant. May be overridden by cheats.
---@field Human0ParticipantGUID rdgs.ParticipantGUID		
---@field Human1ParticipantGUID rdgs.ParticipantGUID		
---@field Human2ParticipantGUID rdgs.ParticipantGUID		
---@field Human3ParticipantGUID rdgs.ParticipantGUID		
---@field ActiveEmperor rdgs.ParticipantGUID		
---@field ActiveEmperorProperty rdgs.CMetaPropertyEmperor		
---@field ControlledAreaList rdgs.CConstructionArea[]		
local CParticipantManager = {}
Participants = CParticipantManager
---@param self rdgs.CParticipantManager
---@param participantGUID rdgs.ParticipantGUID
---@param alsoIfDisabled boolean
---@return rdgs.CMetaGameObject
function CParticipantManager.GetParticipant(self, participantGUID , alsoIfDisabled ) end
---@param self rdgs.CParticipantManager
---@param participantGUID rdgs.ParticipantGUID
---@return rdgs.CMetaGameObject
function CParticipantManager.GetParticipant(self, participantGUID ) end
---@param self rdgs.CParticipantManager
---@param participantGUID rdgs.ParticipantGUID
function CParticipantManager.RemoveParticipant(self, participantGUID ) end
---@param self rdgs.CParticipantManager
---@param participantGUID rdgs.ParticipantGUID
function CParticipantManager.CheatCreateParticipant_IfNecessary(self, participantGUID ) end
---@param self rdgs.CParticipantManager
---@param participantGUID rdgs.ParticipantGUID
function CParticipantManager.SetCurrentParticipant(self, participantGUID ) end
---@param self rdgs.CParticipantManager
function CParticipantManager.SetCurrentParticipantFromSelection(self) end
---@param self rdgs.CParticipantManager
function CParticipantManager.CheatLetSelectedAIEnterNewSession(self) end
---@param self rdgs.CParticipantManager
---@param participantGUID rdgs.ParticipantGUID
---@return boolean
function CParticipantManager.CanRivalBeAddedToRunningGame(self, participantGUID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CParticipantManager.isValid() end

return CParticipantManager
