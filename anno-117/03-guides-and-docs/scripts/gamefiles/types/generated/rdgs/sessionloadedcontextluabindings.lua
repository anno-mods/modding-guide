---@meta rdgs.SessionLoadedContext
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.SessionLoadedContext
---@field SessionGUID integer		
---@field IsNewSession boolean		map guid of the session that has been loaded
---@field SessionID integer		if true, session was created from map file. If false, loaded from savegame
---@field AllSessionsLoaded boolean		ID of the loaded session
local SessionLoadedContext = {}

return SessionLoadedContext
