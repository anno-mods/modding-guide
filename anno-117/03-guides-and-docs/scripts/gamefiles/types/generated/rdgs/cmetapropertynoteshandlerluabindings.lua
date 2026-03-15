---@meta rdgs.CMetaPropertyNotesHandler
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CMetaPropertyNotesHandler
---@field GetNotesCount std.size_t		
local CMetaPropertyNotesHandler = {}
Notes = CMetaPropertyNotesHandler
---@param self rdgs.CMetaPropertyNotesHandler
---@param noteText string
---@param timerTimestamp rdtime
---@param jumpToGameObjectID rdgs.GameObjectID
function CMetaPropertyNotesHandler.AddNote(self, noteText , timerTimestamp , jumpToGameObjectID ) end
---@param self rdgs.CMetaPropertyNotesHandler
---@param noteText string
function CMetaPropertyNotesHandler.AddDebugNote(self, noteText ) end
---@param self rdgs.CMetaPropertyNotesHandler
function CMetaPropertyNotesHandler.Clear(self) end
---@param self rdgs.CMetaPropertyNotesHandler
---@param id std.size_t
function CMetaPropertyNotesHandler.JumpTo(self, id ) end
---@param self rdgs.CMetaPropertyNotesHandler
---@param id std.size_t
function CMetaPropertyNotesHandler.Delete(self, id ) end
---@param self rdgs.CMetaPropertyNotesHandler
---@param timer integer
---@param id std.size_t
function CMetaPropertyNotesHandler.SetTimer(self, timer , id ) end
---@param self rdgs.CMetaPropertyNotesHandler
---@param id std.size_t
---@return string
function CMetaPropertyNotesHandler.GetNoteText(self, id ) end
---@param self rdgs.CMetaPropertyNotesHandler
---@param text string
---@param id std.size_t
function CMetaPropertyNotesHandler.ChangeText(self, text , id ) end
---@param self rdgs.CMetaPropertyNotesHandler
function CMetaPropertyNotesHandler.ToggleEditMode(self) end
---@param self rdgs.CMetaPropertyNotesHandler
---@param objectId rdgs.GameObjectID
---@return string
function CMetaPropertyNotesHandler.NoteText(self, objectId ) end
---@param self rdgs.CMetaPropertyNotesHandler
function CMetaPropertyNotesHandler.ToggleBannerVisibility(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CMetaPropertyNotesHandler.isValid() end

return CMetaPropertyNotesHandler
