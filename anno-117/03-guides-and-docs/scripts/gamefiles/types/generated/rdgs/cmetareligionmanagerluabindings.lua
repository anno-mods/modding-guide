---@meta rdgs.CMetaReligionManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CMetaReligionManager
---@field UnlockThreshold integer		
local CMetaReligionManager = {}
Religion = CMetaReligionManager
---@param self rdgs.CMetaReligionManager
---@param guid integer
---@return rdsdk.TextId
function CMetaReligionManager.GlobalEffectTitle(self, guid ) end
---@param self rdgs.CMetaReligionManager
---@param guid integer
---@return rdsdk.TextId
function CMetaReligionManager.GlobalEffectDescription(self, guid ) end
---@param self rdgs.CMetaReligionManager
---@param guid integer
---@return integer
function CMetaReligionManager.NumberOfIslandsWithPatron(self, guid ) end
---@param self rdgs.CMetaReligionManager
---@param patronGUID integer
---@return rdsdk.TextId
function CMetaReligionManager.WonderDescription(self, patronGUID ) end
---@param self rdgs.CMetaReligionManager
---@param patronGUID integer
---@return integer
function CMetaReligionManager.Wonder(self, patronGUID ) end
---@param self rdgs.CMetaReligionManager
---@param patronGUID integer
---@return integer
function CMetaReligionManager.Shrine(self, patronGUID ) end
---@param self rdgs.CMetaReligionManager
---@param patronGUID integer
---@return boolean
function CMetaReligionManager.IsDominantPatron(self, patronGUID ) end
---@param self rdgs.CMetaReligionManager
---@param patronGUID integer
---@return rdsdk.TextId
function CMetaReligionManager.PatronName(self, patronGUID ) end
---@param self rdgs.CMetaReligionManager
---@param rate integer
function CMetaReligionManager.SetFastDevotionRate(self, rate ) end
---@param self rdgs.CMetaReligionManager
---@param GUIDToUnlock integer
---@return integer
function CMetaReligionManager.GetWonderUnlockDeity(self, GUIDToUnlock ) end
---@param self rdgs.CMetaReligionManager
---@param GUIDToUnlock integer
---@return integer
function CMetaReligionManager.GetShrineUnlockDeity(self, GUIDToUnlock ) end
---@param self rdgs.CMetaReligionManager
---@param effectGUID integer
---@param milestone integer
---@return integer
function CMetaReligionManager.GetRequiredDevotion(self, effectGUID , milestone ) end
---@param self rdgs.CMetaReligionManager
---@param effectGUID integer
---@param milestone integer
---@return integer
function CMetaReligionManager.GetBuffScaling(self, effectGUID , milestone ) end
---@param self rdgs.CMetaReligionManager
function CMetaReligionManager.OpenGlobalReligionScreen(self) end
---@param self rdgs.CMetaReligionManager
---@param island rdgs.AreaID
function CMetaReligionManager.OpenLocalReligionScreen(self, island ) end
---@return boolean returns true if weak pointer holds a valid reference
function CMetaReligionManager.isValid() end

return CMetaReligionManager
