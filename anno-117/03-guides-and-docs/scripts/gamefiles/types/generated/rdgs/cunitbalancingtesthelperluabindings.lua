---@meta rdgs.CUnitBalancingTestHelper
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CUnitBalancingTestHelper
---@field IsTestFinished boolean		
local CUnitBalancingTestHelper = {}
---@param self rdgs.CUnitBalancingTestHelper
function CUnitBalancingTestHelper.StartTest(self) end
---@param self rdgs.CUnitBalancingTestHelper
function CUnitBalancingTestHelper.EndTest(self) end
---@param self rdgs.CUnitBalancingTestHelper
function CUnitBalancingTestHelper.FinishTestRound(self) end
---@param self rdgs.CUnitBalancingTestHelper
---@param posX number
---@param posZ number
---@param owner rdgs.ParticipantGUID
---@param unitGuid integer
---@param rotationY number
---@return rdgs.GameObjectID
function CUnitBalancingTestHelper.SpawnUnit(self, posX , posZ , owner , unitGuid , rotationY ) end
---@param self rdgs.CUnitBalancingTestHelper
---@param unitGuid integer
---@param targetShipObjectId rdgs.GameObjectID
---@param ownerGuid rdgs.ParticipantGUID
---@return rdgs.GameObjectID
function CUnitBalancingTestHelper.SpawnUnitOnShip(self, unitGuid , targetShipObjectId , ownerGuid ) end
---@param self rdgs.CUnitBalancingTestHelper
---@param unitObjectId rdgs.GameObjectID
---@param stance datasets.UnitStance
function CUnitBalancingTestHelper.SetUnitStance(self, unitObjectId , stance ) end
---@param self rdgs.CUnitBalancingTestHelper
---@param sourceUnitID rdgs.GameObjectID
---@param targetUnitID rdgs.GameObjectID
function CUnitBalancingTestHelper.AttackUnit(self, sourceUnitID , targetUnitID ) end
---@param self rdgs.CUnitBalancingTestHelper
---@param sourceUnitID rdgs.GameObjectID
---@param posX number
---@param posZ number
function CUnitBalancingTestHelper.AttackPosition(self, sourceUnitID , posX , posZ ) end
---@param self rdgs.CUnitBalancingTestHelper
---@param unitID rdgs.GameObjectID
---@param posX number
---@param posZ number
function CUnitBalancingTestHelper.MoveUnit(self, unitID , posX , posZ ) end
---@param self rdgs.CUnitBalancingTestHelper
---@param unitID rdgs.GameObjectID
---@param recoveryAllowed boolean
function CUnitBalancingTestHelper.ForceDeserting(self, unitID , recoveryAllowed ) end
---@param self rdgs.CUnitBalancingTestHelper
---@param unitID rdgs.GameObjectID
---@param percent number
---@param damageDealer rdgs.ParticipantGUID
---@param countAsUnitAttack boolean
function CUnitBalancingTestHelper.AddDamagePercent(self, unitID , percent , damageDealer , countAsUnitAttack ) end
---@param self rdgs.CUnitBalancingTestHelper
---@param unitID rdgs.GameObjectID
---@param percent number
function CUnitBalancingTestHelper.AddHealPercent(self, unitID , percent ) end
---@param self rdgs.CUnitBalancingTestHelper
---@param debugFlag integer
---@param value boolean
function CUnitBalancingTestHelper.SetDebugUnitFlag(self, debugFlag , value ) end
---@param self rdgs.CUnitBalancingTestHelper
function CUnitBalancingTestHelper.ClearUnits(self) end
---@param self rdgs.CUnitBalancingTestHelper
function CUnitBalancingTestHelper.SkipDelayedVisualDeletionTimes(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CUnitBalancingTestHelper.isValid() end

return CUnitBalancingTestHelper
