---@meta rdgs.CPropertyMonument
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPropertyMonument
---@field UpgradeTarget string		
---@field Progress number		Gets the progress in range [0, 1]
---@field RemainingTime string		Gets the time needed for the upgrade if all goods are available
---@field ConstructionState datasets.MonumentConstructionState		calculate the current status of this upgrade phase
---@field CurrentPhase integer		get upgrade level
---@field MaxPhase integer		get highest possible upgrade level
local CPropertyMonument = {}
---@param self rdgs.CPropertyMonument
---@param productGUID integer
---@return integer
function CPropertyMonument.GetNeededProducts(self, productGUID ) end
---@param self rdgs.CPropertyMonument
---@param productGUID integer
---@return integer
function CPropertyMonument.GetAvailableProducts(self, productGUID ) end
---pause the simulated upgrade
---@param self rdgs.CPropertyMonument
function CPropertyMonument.PauseUpgrade(self) end
---finish current micro phase
---@param self rdgs.CPropertyMonument
function CPropertyMonument.CheatUpgradeMicro(self) end
---force start current micro phase
---@param self rdgs.CPropertyMonument
function CPropertyMonument.CheatMicroPhase(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CPropertyMonument.isValid() end

return CPropertyMonument
