---@meta rdgs.CPropertyResidence7
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPropertyResidence7
---@field PopulationLevel rdgs.CAsset		
---@field ResidentMax number		
---@field ResidentLimitBySupply number		
---@field ResidentCount number		
---@field Occupancy number		
---@field IsAbandoned boolean		
---@field Satisfaction number		returns the average satisfaction for all unlocked products. Considers the current need weight\nvalues between [0-1]
---@field CategorySatisfaction number		returns the average satisfaction for all categories\nvalues between [0-1]
---@field PopulationToWorkforceFactor number		[[deprecated(\"Use PropertyAttributeProvider.GetPopulationToWorkforceFactor() instead\")]]
---@field MoneyOutput number		
---@field WorkforceOutput number		[[deprecated(\"Use PropertyAttributeProvider.GetWorkforceOutput() instead\")]]\t
local CPropertyResidence7 = {}
---@param self rdgs.CPropertyResidence7
---@param productGUID rdgs.ProductGUID
---@return number
function CPropertyResidence7.GetSatisfaction(self, productGUID ) end
---@param self rdgs.CPropertyResidence7
---@param categoryTypeInt integer
---@return number
function CPropertyResidence7.GetNeedCategorySatisfaction(self, categoryTypeInt ) end
---Gets the base value for the multiplier for comparison in order to know if the multiplier means a buff or a debuff.\n[[deprecated(\"Use PropertyAttributeProvider.GetBaseValueForAttribute() instead\")]]
---@param self rdgs.CPropertyResidence7
---@param attributeType datasets.NeedAttributeType
---@return number
function CPropertyResidence7.GetBaseValueForNeedAttribute(self, attributeType ) end
---@param self rdgs.CPropertyResidence7
---@param productGUID rdgs.ProductGUID
---@return number
function CPropertyResidence7.GetSatisfactionTrend(self, productGUID ) end
---@param self rdgs.CPropertyResidence7
---@param categoryTypeInt integer
---@return rdgs.NeedGUID[]
function CPropertyResidence7.GetNeedsByNeedCategory(self, categoryTypeInt ) end
---@param self rdgs.CPropertyResidence7
---@param categoryTypeInt integer
---@return number
function CPropertyResidence7.GetCategoryOversupply(self, categoryTypeInt ) end
---@param self rdgs.CPropertyResidence7
---@param categoryTypeInt integer
---@return number
function CPropertyResidence7.GetNeedCategorySupplyUnclamped(self, categoryTypeInt ) end
---@param self rdgs.CPropertyResidence7
---@param categoryTypeInt integer
---@return number
function CPropertyResidence7.GetNeedCategorySatisfactionUnclamped(self, categoryTypeInt ) end
---@param self rdgs.CPropertyResidence7
---@param categoryTypeInt integer
---@return number
function CPropertyResidence7.GetNeedCategoryDemand(self, categoryTypeInt ) end
---Return effect of city status on the needAttribute\n[[deprecated(\"Use PropertyAttributeProvider.GetAttributeValueFromCityStatus() instead\")]]
---@param self rdgs.CPropertyResidence7
---@param needAttributeType datasets.NeedAttributeType
---@return number
function CPropertyResidence7.GetCityStatusNeedAttribute(self, needAttributeType ) end
---Return effect of incident difficulty setting on the needAttribute\n[[deprecated(\"Use PropertyAttributeProvider.GetAttributeValueFromCityStatus() instead\")]]
---@param self rdgs.CPropertyResidence7
---@param needAttributeType datasets.NeedAttributeType
---@return number
function CPropertyResidence7.GetIncidentDifficultyNeedAttribute(self, needAttributeType ) end
---Returns the current amount for a need attribute for the whole residence
---@param self rdgs.CPropertyResidence7
---@param needAttributeTypeInt integer
---@return number
function CPropertyResidence7.GetNeedAttributeValueForType(self, needAttributeTypeInt ) end
---@param self rdgs.CPropertyResidence7
---@param needAttributeType datasets.NeedAttributeType
---@return number
function CPropertyResidence7.GetNeedAttributeAmountFromBuffs(self, needAttributeType ) end
---Returns the current amount for a need attribute gained from a good/category
---@param self rdgs.CPropertyResidence7
---@param categoryTypeInt integer
---@param needAttributeTypeInt integer
---@return number
function CPropertyResidence7.GetNeedAttributeByNeedCategory(self, categoryTypeInt , needAttributeTypeInt ) end
---@param self rdgs.CPropertyResidence7
---@param needGUID rdgs.NeedGUID
---@param needAttributeTypeInt integer
---@return number
function CPropertyResidence7.GetNeedAttributeByNeed(self, needGUID , needAttributeTypeInt ) end
---@param self rdgs.CPropertyResidence7
---@param needGUID rdgs.NeedGUID
---@param needAttributeTypeInt integer
---@return number
function CPropertyResidence7.GetNeedAttributeByNeedMax(self, needGUID , needAttributeTypeInt ) end
---@param self rdgs.CPropertyResidence7
---@param productGUID integer
---@return number
function CPropertyResidence7.GetCurrentHappinessForGood(self, productGUID ) end
---@param self rdgs.CPropertyResidence7
---@param needGUID rdgs.NeedGUID
---@return number
function CPropertyResidence7.GetCurrentSupplyForNeed(self, needGUID ) end
---@param self rdgs.CPropertyResidence7
---@param productGUID integer
---@return number
function CPropertyResidence7.GetCurrentSupplyForGood(self, productGUID ) end
---@param self rdgs.CPropertyResidence7
---@param categoryTypeInt integer
---@return number
function CPropertyResidence7.GetNeedCategoryCurrentSupply(self, categoryTypeInt ) end
---@param self rdgs.CPropertyResidence7
---@param categoryTypeInt integer
---@return number
function CPropertyResidence7.GetCurrentSupplyForNeedCategoryUnclamped(self, categoryTypeInt ) end
---@param self rdgs.CPropertyResidence7
---@param categoryTypeInt integer
---@return number
function CPropertyResidence7.GetSupplyRequiredForNeedCategory(self, categoryTypeInt ) end
---money per minute this residence building produces currently
---@param self rdgs.CPropertyResidence7
---@param productGUID integer
---@return number
function CPropertyResidence7.GetCurrentMoneyForGood(self, productGUID ) end
---@param self rdgs.CPropertyResidence7
---@param productGUID integer
---@return number
function CPropertyResidence7.GetMaxSupplyForGood(self, productGUID ) end
---@param self rdgs.CPropertyResidence7
---@param needGUID rdgs.NeedGUID
---@return number
function CPropertyResidence7.GetMaxSupplyForNeed(self, needGUID ) end
---@return boolean returns true if weak pointer holds a valid reference
function CPropertyResidence7.isValid() end

return CPropertyResidence7
