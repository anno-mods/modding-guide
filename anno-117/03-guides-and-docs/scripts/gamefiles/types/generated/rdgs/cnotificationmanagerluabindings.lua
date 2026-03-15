---@meta rdgs.CNotificationManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CNotificationManager
---@field Current rdgs.INotification		Returns the currently active notification
local CNotificationManager = {}
Notifications = CNotificationManager
---Returns the notification with the given ID\nNote that this can return nullptr, especially if the notification you are trying to access is already deleted (e.g. by being filtered out by the player)
---@param self rdgs.CNotificationManager
---@param notificationID rdgs.NotificationID
---@return rdgs.INotification
function CNotificationManager.ByID(self, notificationID ) end
---@param self rdgs.CNotificationManager
function CNotificationManager.JumpToLastNotification(self) end
---@param self rdgs.CNotificationManager
---@param id rdgs.GovernorRequestID
---@return rdgs.CGovernorRequest
function CNotificationManager.GetGovernorRequest(self, id ) end
---Debug / Cheat methods
---@param self rdgs.CNotificationManager
---@param participantGUID rdgs.ParticipantGUID
function CNotificationManager.SelectDebugProfile(self, participantGUID ) end
---@param self rdgs.CNotificationManager
---@param participantGUID rdgs.ParticipantGUID
---@param oasisID string
function CNotificationManager.PlayProfileNotificationFromOasisID(self, participantGUID , oasisID ) end
---@param self rdgs.CNotificationManager
---@param audioGuid integer
function CNotificationManager.PlayAudioGuid(self, audioGuid ) end
---@return boolean returns true if weak pointer holds a valid reference
function CNotificationManager.isValid() end

return CNotificationManager
