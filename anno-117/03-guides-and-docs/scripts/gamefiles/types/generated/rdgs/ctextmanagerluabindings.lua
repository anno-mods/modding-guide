---@meta rdgs.CTextManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CTextManager
local CTextManager = {}
Text = CTextManager
---Chooses the next available TextDisplayMode
---@param self rdgs.CTextManager
function CTextManager.NextTextDisplayMode(self) end
---returns a reference to the requested text, which may be empty if not found.
---@param self rdgs.CTextManager
---@param textId rdsdk.TextId
---@param makeNewText boolean
---@return string
function CTextManager.GetText(self, textId , makeNewText ) end
---returns a reference to the requested text, which may be empty if not found.
---@param self rdgs.CTextManager
---@param textId rdsdk.TextId
---@return string
function CTextManager.GetText(self, textId ) end
---@return boolean returns true if weak pointer holds a valid reference
function CTextManager.isValid() end

return CTextManager
