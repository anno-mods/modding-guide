---@meta rdgs.CMetaPropertyParticipant
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CMetaPropertyParticipant
---@field EconomyLevel integer		
local CMetaPropertyParticipant = {}
GetCompanyNameForParticipant = CMetaPropertyParticipant
GetAvatarPortraitIconForParticipant = CMetaPropertyParticipant
GetAvatarPortraitForParticipant = CMetaPropertyParticipant
GetCompanyLogoGUIDForParticipant = CMetaPropertyParticipant
GetRatingForParticipant = CMetaPropertyParticipant
---NAME
---@param participant rdgs.ParticipantGUID
---@return string
function CMetaPropertyParticipant.GetCompanyNameForParticipant(participant ) end
---PORTRAIT
---@param participant rdgs.ParticipantGUID
---@return string
function CMetaPropertyParticipant.GetAvatarPortraitIconForParticipant(participant ) end
---@param participant rdgs.ParticipantGUID
---@return integer
function CMetaPropertyParticipant.GetAvatarPortraitForParticipant(participant ) end
---LOGO
---@param participant rdgs.ParticipantGUID
---@return integer
function CMetaPropertyParticipant.GetCompanyLogoGUIDForParticipant(participant ) end
---RATINGS
---@param participant rdgs.ParticipantGUID
---@return rdgs.RivalRating
function CMetaPropertyParticipant.GetRatingForParticipant(participant ) end
---Cheats
---@param self rdgs.CMetaPropertyParticipant
---@param newPortraitGUID integer
function CMetaPropertyParticipant.SetAvatarPortrait(self, newPortraitGUID ) end
---@param self rdgs.CMetaPropertyParticipant
---@param newName string
function CMetaPropertyParticipant.SetCompanyName(self, newName ) end
---@return boolean returns true if weak pointer holds a valid reference
function CMetaPropertyParticipant.isValid() end

return CMetaPropertyParticipant
