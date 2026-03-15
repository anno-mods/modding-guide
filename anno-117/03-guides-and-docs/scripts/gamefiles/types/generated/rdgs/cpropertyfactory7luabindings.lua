---@meta rdgs.CPropertyFactory7
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CPropertyFactory7
---@field FillStorage boolean		
---@field TeleportsProducedGoodsDirectlyIntoAreaStorage boolean		
---@field CycleTime rdtime		
---@field RelativeCycleTime rdtime		
---@field Progress number		
---@field Productivity number		Returns the average productivity which is the smoothed productivity over time
---@field CurrentProductivity number		Returns the current productivity in this very moment. This is not an average value. For the average value which is used in the UI use GetProductivity
---@field ProductivityUpgrade number		
---@field ProductivityUpgradeList rdgs.CItemAsset[]		
---@field ProductivityBase number		
---@field ProductivityBoostPotential number		
---@field Inputs rdgs.CProductAmount[]		returns the actual current inputs (affected by items)
---@field FullOutputStorage boolean		
---@field NoWarehouseInRange boolean		Returns true if there is not a single connection to a warehouse the range of this factory
---@field NeededFertility rdgs.CAsset		
---@field NeedsAFertility boolean		
---@field HasNeededFertility boolean		
---@field RemainingFuelTime rdtime		remaining time includes complete supply of fuel, ticks down while production is running 
---@field HasFuelWarning boolean		if production is not running and there is not enough fuel available for the next production cycle
---@field FuelDurationPerTon rdtime		
local CPropertyFactory7 = {}
---@param self rdgs.CPropertyFactory7
function CPropertyFactory7.ToggleCheatFertility(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CPropertyFactory7.isValid() end

return CPropertyFactory7
