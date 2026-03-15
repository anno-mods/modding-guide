---@meta rdgs.CAreaNeedAttributeManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CAreaNeedAttributeManager
---@field OrnamentPrestige integer		
local CAreaNeedAttributeManager = {}
AreaNeedAttributes = CAreaNeedAttributeManager
---Returns the current area need attributes
---@param self rdgs.CAreaNeedAttributeManager
---@param needAttributeTypeInt integer
---@return number
function CAreaNeedAttributeManager.GetNeedAttribute(self, needAttributeTypeInt ) end
---Returns the effect of city status on a need attribute per residence(datasets::NeedAttributeType)
---@param self rdgs.CAreaNeedAttributeManager
---@param needAttributeInt integer
---@return number
function CAreaNeedAttributeManager.GetCityStatusEffectOnNeedAttribute(self, needAttributeInt ) end
---Returns the effect of city status on a need attribute in total(datasets::NeedAttributeType)
---@param self rdgs.CAreaNeedAttributeManager
---@param needAttributeInt integer
---@return number
function CAreaNeedAttributeManager.GetCityStatusEffectOnNeedAttributeTotal(self, needAttributeInt ) end
---Returns the effect of the incident difficulty setting on a need attribute (datasets::NeedAttributeType)
---@param self rdgs.CAreaNeedAttributeManager
---@param needAttributeInt integer
---@return number
function CAreaNeedAttributeManager.GetIncidentDifficultyEffectOnNeedAttribute(self, needAttributeInt ) end
---Returns the list of buffs that affect a need attribute
---@param self rdgs.CAreaNeedAttributeManager
---@param needAttributeInt integer
---@return rdgs.CTextSourceListValue[]
function CAreaNeedAttributeManager.GetBuffSourcesForNeedAttribute(self, needAttributeInt ) end
---Returns the list of buffs that affect a need attribute with a modifier
---@param self rdgs.CAreaNeedAttributeManager
---@param needAttributeInt integer
---@return rdgs.CTextSourceListValue[]
function CAreaNeedAttributeManager.GetBuffSourcesForNeedAttributeModifier(self, needAttributeInt ) end
---Returns the list of needs that affect a need attribute (only usable if Infotip Need Attributes is open)
---@param self rdgs.CAreaNeedAttributeManager
---@param needAttributeInt integer
---@return rdgs.CTextSourceListValue[]
function CAreaNeedAttributeManager.GetSourcesForNeedAttribute(self, needAttributeInt ) end
---Returns the list of residence buffs that affect a need attribute (only usable if Infotip Need Attributes is open)
---@param self rdgs.CAreaNeedAttributeManager
---@param needAttributeInt integer
---@return rdgs.CTextSourceListValue[]
function CAreaNeedAttributeManager.GetBuffSources(self, needAttributeInt ) end
---Returns the list of buildings that affect a need attribute (only usable if Infotip Need Attributes is open)
---@param self rdgs.CAreaNeedAttributeManager
---@param needAttributeInt integer
---@return rdgs.CTextSourceListValue[]
function CAreaNeedAttributeManager.GetFlatSources(self, needAttributeInt ) end
---Returns the list of buildings and buffs that affect a need attribute (only usable if Infotip Need Attributes is open)
---@param self rdgs.CAreaNeedAttributeManager
---@param needAttributeInt integer
---@return rdgs.CTextSourceListValue[]
function CAreaNeedAttributeManager.GetBuffAndFlatSourcesMergedByIcon(self, needAttributeInt ) end
---@param self rdgs.CAreaNeedAttributeManager
---@param type datasets.NeedAttributeType
---@param value integer
function CAreaNeedAttributeManager.AddCheatedNeedAttribute(self, type , value ) end
---@param self rdgs.CAreaNeedAttributeManager
---@param amount integer
function CAreaNeedAttributeManager.AddCheatedNeedAttributesNet(self, amount ) end
---@return boolean returns true if weak pointer holds a valid reference
function CAreaNeedAttributeManager.isValid() end

return CAreaNeedAttributeManager
