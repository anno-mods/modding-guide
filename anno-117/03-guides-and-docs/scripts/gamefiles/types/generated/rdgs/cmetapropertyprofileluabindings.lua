---@meta rdgs.CMetaPropertyProfile
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CMetaPropertyProfile
---@field CompanyName string		NAME
---@field AvatarPortraitIcon string		PORTRAIT
---@field AvatarPortrait integer		
---@field CompanyLogoGUID integer		LOGO
---@field Level integer		
---@field PopulationRequirementForNextLevel integer		
local CMetaPropertyProfile = {}
---Cheats
---@param self rdgs.CMetaPropertyProfile
---@param newPortraitGUID integer
function rdgs.CMetaPropertyProfile.SetAvatarPortrait(self, newPortraitGUID ) end
---@param self rdgs.CMetaPropertyProfile
---@param newName string
function rdgs.CMetaPropertyProfile.SetCompanyName(self, newName ) end
---@param self rdgs.CMetaPropertyProfile
---@param level integer
function rdgs.CMetaPropertyProfile.SetLevel(self, level ) end
---@param self rdgs.CMetaPropertyProfile
function rdgs.CMetaPropertyProfile.IncreaseLevel(self) end
---@param self rdgs.CMetaPropertyProfile
---@param level integer
---@return integer
function rdgs.CMetaPropertyProfile.GetPopulationRequirementForCompanyLevel(self, level ) end

return CMetaPropertyProfile
