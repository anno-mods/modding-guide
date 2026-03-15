---@meta rdgs.CEffect
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CEffect
---@field IsTimed boolean		
---@field TimeLeft rdtime		
---@field IsBoosted boolean		
local CEffect = {}
GetEffect = CEffect
IsEffect = CEffect
GetBuffDetails = CEffect
GetStaticBuffDetails = CEffect
GetHealthModifiers = CEffect
GetAttributeModifiers = CEffect
GetEffectTimeLeft = CEffect
---Returns the effect if it exists
---@param effectID rdgs.EffectID
---@return rdgs.CEffect|nil
function CEffect.GetEffect(effectID ) end
---@param effectID rdgs.EffectID
---@return boolean
function CEffect.IsEffect(effectID ) end
---Returns a vector of all the value upgrades a buff contains (containing icons, text and values), does not include some upgrades like pirate flag, white flag etc.
---@param buffGuid integer
---@param effectIDAsInt integer
---@return rdgs.CTextSourceListValue[]
function CEffect.GetBuffDetails(buffGuid , effectIDAsInt ) end
---@param buffGuid integer
---@param scaling number
---@return rdgs.CTextSourceListValue[]
function CEffect.GetStaticBuffDetails(buffGuid , scaling ) end
---Returns a vector of all the value upgrades a buff contains (containing icons, text and values), does not include some upgrades like pirate flag, white flag etc.
---@param self rdgs.CEffect
---@param buffGuid integer
---@return rdgs.CTextSourceListValue[]
function CEffect.GetBuffDetails(self, buffGuid ) end
---Returns a vector of all the value upgrades of all buffs affecting this objects health (containing icons, text and values)
---@param objectID rdgs.GameObjectID
---@return rdgs.CTextSourceListValue[]
function CEffect.GetHealthModifiers(objectID ) end
---@param objectID rdgs.GameObjectID
---@param type datasets.NeedAttributeType
---@return rdgs.CTextSourceListValue[]
function CEffect.GetAttributeModifiers(objectID , type ) end
---Returns the time left if a effect id is given or the duration of the effect if only the guid is given
---@param effectGUID integer
---@param effectIDAsInt integer
---@return rdtime
function CEffect.GetEffectTimeLeft(effectGUID , effectIDAsInt ) end
---@return boolean returns true if weak pointer holds a valid reference
function CEffect.isValid() end

return CEffect
