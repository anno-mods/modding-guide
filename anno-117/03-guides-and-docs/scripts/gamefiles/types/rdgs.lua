---@meta rdgs
rdgs = {}

---Convertible to integer
---@source ../../../../../Source/Components/GameSession/ScriptEngine/LuaBindings/rdgs/CombatUnitTypes.h
---@class rdgs.CombatUnitID

---Convertible to integer
---@source ../../../../../Source/Components/GameSession/ScriptEngine/LuaBindings/rdgs/EconomicTypes.h
---@class rdgs.ProductAmount

---Convertible to integer
---@source ../../../../../Source/Components/GameSession/ScriptEngine/LuaBindings/rdgs/EconomicTypes.h
---@class rdgs.ProductGUID

---Convertible to integer
---@source ../../../../../Source/Components/GameSession/ScriptEngine/LuaBindings/rdgs/EconomicTypes.h
---@class rdgs.BuildingGUID

---Convertible to integer
---@source ../../../../../Source/Components/GameSession/ScriptEngine/LuaBindings/rdgs/EconomicTypes.h
---@class rdgs.CraftableGUID

---Convertible to integer
---@source ../../../../../Source/Components/GameSession/ScriptEngine/LuaBindings/rdgs/EconomicTypes.h
---@class rdgs.BuildingOrCraftableGUID

---wraps a game event
---@class rdgs.ScriptEvent
rdgs.ScriptEvent = {}

---Adds a listener to this event
---@param self rdgs.ScriptEvent current event (this)
---@param listener function a callable that will be triggered on every event
---@param group? string optional group name that should help to remove listeners by name. A group can contain many listeners.
function rdgs.ScriptEvent.Add(self, listener, group) end

---Remove the given listener
---@param self rdgs.ScriptEvent current event (this)
---@param listener function a function you registered before using Add
function rdgs.ScriptEvent.Remove(self, listener) end

---Remove all listeners assigned to this group name
---@param self rdgs.ScriptEvent current event (this)
---@param group string a group. All listeners of this group will be unregistered
function rdgs.ScriptEvent.RemoveByName(self, group) end

---Clears all registered events (regardless of group name)
---@param self rdgs.ScriptEvent current event (this)
function rdgs.ScriptEvent.RemoveAll(self) end

---Represents a future used for asynchronous processing of tasks.
---@class rdgs.CAsyncFunction
rdgs.CAsyncFunction = {}

---returns true if the async method is finished
---@return boolean true if ready
function rdgs.CAsyncFunction.Check() end

---if the async function returns values, the will be pushed to Lua by this method 
---@return ... all results the asynchronous operation returns
function rdgs.CAsyncFunction.PushResult() end

---@class rdtime
---@class rdgs.AIShipRequestID
---@class rdgs.AppTime
---@class rdgs.AreaID
---@class rdgs.CameraSequenceID
---@class rdgs.CorporationTime
---@class rdgs.GoodTradeID
---@class rdgs.GovernorRequestID
---@class rdgs.IslandID
---@class rdgs.IsMovingDefinition
---@class rdgs.MetaGameObjectID
---@class rdgs.NeedGUID
---@class rdgs.NotificationID
---@class rdgs.ParticipantGUID
---@class rdgs.SessionTime
---@class rdgs.StationTradeID
---@class rdgs.StatsValue
---@class rdgs.TradeRouteID
---@class rdgs.UnixTime
