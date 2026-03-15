---@meta rdgs.COnlineManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.COnlineManager
---@field Connectivity rdgs.CConnectionController		
---@field BadConnection boolean		
---@field DesyncError string		
---@field HasNoPendingInvitations boolean		
---@field CurrentInvitation rdgs.CGameInviteFlow		
---@field MultiplayerValidationFlow rdgs.CValidateMultiplayerAccessFlow		
---@field LastLeftPlayer string		
---@field LastInviter string		
---@field LastSwapRequester string		
---@field SecondsUntilDesyncRecoverStart rdtime		returns the time left until the automatic desync recovery will start (after detecting a desync)
local COnlineManager = {}
Online = COnlineManager
---@param self rdgs.COnlineManager
function COnlineManager.AcceptInvite(self) end
---@param self rdgs.COnlineManager
function COnlineManager.DeclineInvite(self) end
---kills the current game invitation flow state object which resets the flow
---@param self rdgs.COnlineManager
function COnlineManager.CancelCurrentInvitationFlow(self) end
---@param self rdgs.COnlineManager
---@param leaveToTitle boolean
function COnlineManager.LeaveMultiplayerArea(self, leaveToTitle ) end
---@param self rdgs.COnlineManager
function COnlineManager.LeaveMultiplayerArea(self) end
---start multiplayer with current settings (calls StartMultiplayerSession(const CMPGameSettings& settings))
---@param self rdgs.COnlineManager
function COnlineManager.LoadMPSession(self) end
---@param self rdgs.COnlineManager
---@param peerID integer
---@return string
function COnlineManager.Username(self, peerID ) end
---@param self rdgs.COnlineManager
---@param peerID integer
---@return string
function COnlineManager.FormerUsername(self, peerID ) end
---@param self rdgs.COnlineManager
---@param slotIndex integer
---@return string
function COnlineManager.GetPlayerName(self, slotIndex ) end
---@param self rdgs.COnlineManager
function COnlineManager.CheatForceDesync(self) end
---@param self rdgs.COnlineManager
function COnlineManager.OpenHelpPage(self) end
---returns the peers looking at the same UI page with the same custom value.
---@param self rdgs.COnlineManager
---@param id integer
---@param customValue integer
---@return integer[]
function COnlineManager.GetCoopPeersAtMarker(self, id , customValue ) end
---@return boolean returns true if weak pointer holds a valid reference
function COnlineManager.isValid() end

return COnlineManager
