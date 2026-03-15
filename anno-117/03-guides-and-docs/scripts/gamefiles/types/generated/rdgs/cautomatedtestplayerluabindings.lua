---@meta rdgs.CAutomatedTestPlayer
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAutomatedTestPlayer
---@field ErrorOutput string		Returns the output of the first error that happened during a replay
---@field AbortReplay boolean		Returns if a running replay should be aborted
local CAutomatedTestPlayer = {}
---Set the current line number (called via replay script)
---@param self rdgs.CAutomatedTestPlayer
---@param lineNumber integer
function CAutomatedTestPlayer.PlaybackDebugLog(self, lineNumber ) end
---Aborts the replaying script and writes the error\n\\isWarning: if true the script will continue and only output the error as warning, if false the script will abort\n\\failure: type of the failure (script error or data difference)
---@param self rdgs.CAutomatedTestPlayer
---@param errorText string
---@param isWarning boolean
---@param failure rec.FailureType
function CAutomatedTestPlayer.ThrowError(self, errorText , isWarning , failure ) end
---Aborts the replaying script and writes the error\n\\isWarning: if true the script will continue and only output the error as warning, if false the script will abort\n\\failure: type of the failure (script error or data difference)
---@param self rdgs.CAutomatedTestPlayer
---@param errorText string
---@param isWarning boolean
function CAutomatedTestPlayer.ThrowError(self, errorText , isWarning ) end
---Aborts the replaying script and writes the error\n\\isWarning: if true the script will continue and only output the error as warning, if false the script will abort\n\\failure: type of the failure (script error or data difference)
---@param self rdgs.CAutomatedTestPlayer
---@param errorText string
function CAutomatedTestPlayer.ThrowError(self, errorText ) end
---@return boolean returns true if weak pointer holds a valid reference
function CAutomatedTestPlayer.isValid() end

return CAutomatedTestPlayer
