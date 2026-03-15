---@meta events

---@class events
---@field OnSessionLoaded rdgs.ScriptEvent listeners receive a rdgs.SessionLoadedContext
---@field OnSessionEnter rdgs.ScriptEvent listeners receive a SessionEnteredContext
---@field OnMetaGameUnloaded rdgs.ScriptEvent listeners receive an unused int
---@field OnCameraSequenceEnd rdgs.ScriptEvent listeners receive a CameraSequenceEventIdentifier
---@field OnLeaveUIState rdgs.ScriptEvent listeners receive a rdui.StateID
---@field OnGameSetupLoaded rdgs.ScriptEvent listeners receive a bool. True if the game setup is a savegame, false if it is for a new game
events = {}
