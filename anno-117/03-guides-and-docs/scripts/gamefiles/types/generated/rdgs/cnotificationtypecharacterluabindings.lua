---@meta rdgs.CNotificationTypeCharacter
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CNotificationTypeCharacter
---@field CharacterGUID rdgs.ParticipantGUID		Gets the character GUID
---@field NotificationPositionObject rdgs.CGameObject		Returns the object for the NotificationPosition if availabe\t
---@field QuestID quest.ComponentID		
local CNotificationTypeCharacter = {}
---@see INotification parent class
---@param self rdgs.CNotificationTypeCharacter
---@param key string
---@return rdgs.CTextSourceObjectWrapper
function CNotificationTypeCharacter.GetValue(self, key ) end
---@return boolean returns true if weak pointer holds a valid reference
function CNotificationTypeCharacter.isValid() end
---@return boolean returns true if weak pointer holds a valid reference
function CNotificationTypeCharacter.isValid() end

return CNotificationTypeCharacter
