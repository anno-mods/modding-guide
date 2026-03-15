---@meta rdgs.CMetaPropertyEmperor
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CMetaPropertyEmperor
local CMetaPropertyEmperor = {}
---Enables or disables the possibility to rebel against this emperor when at min reputation
---@param self rdgs.CMetaPropertyEmperor
---@param disableRebellion boolean
function CMetaPropertyEmperor.SetRebellionDisabledState(self, disableRebellion ) end
---Shortens the interval between emperor quests to a couple of minutes
---@param self rdgs.CMetaPropertyEmperor
function CMetaPropertyEmperor.ShortenAllEmperorQuestTimerIntervals(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CMetaPropertyEmperor.isValid() end

return CMetaPropertyEmperor
