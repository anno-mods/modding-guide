---@meta rdsdk

---@class rdsdk
rdsdk = {}

---@class rdsdk.TextId

---@class rdsdk.Tile

---@return rdsdk.TextId newInstance 
function rdsdk.TextId() end
---@return rdsdk.TextId newInstance 
---@param oasisId string using oasisId to initialize
function rdsdk.TextId(oasisId) end

---this converts the value be just reinterpreting the memory. This is done to circumvent float deterministic issues.
---@param uintValue integer a integer value that will be converted back to float
---@return number
function rdsdk.UintAsFloat(uintValue) end

---this converts the value be just reinterpreting the memory. This is done to circumvent float deterministic issues.
---@param floatValue number a floating point value that will be converted to an integer
---@return integer
function rdsdk.FloatAsUint(floatValue) end

---@meta Direction8
---@enum rdsdk.Direction8
rdsdk.Direction8 = {
	MaxX = 0,
	MaxX_MaxZ = 1,
	MaxZ = 2,
	MinX_MaxZ = 3,
	MinX = 4,
	MinX_MinZ = 5,
	MinZ = 6,
	MaxX_MinZ = 7
}

---@meta Direction4
---@enum rdsdk.Direction4
rdsdk.Direction4 = {
	MaxX = 0,
	MaxZ = 1,
	MinX = 2,
	MinZ = 3
}

---@meta RotateDirection
---@enum rdsdk.RotateDirection
rdsdk.RotateDirection = {
	None = 0,
	CounterClockwise = 1,
	Clockwise = 2
}

---@meta IterateDirection
---@enum rdsdk.IterateDirection
rdsdk.IterateDirection = {
	None = 0,
	Forward = 1,
	Backward = 2
}

---@meta rdsdk.Category
---@enum rdsdk.Category
rdsdk.Category = {
	SYSTEM = 0,
	FILESYSTEM = 1,
	ASSERTS = 2,
	SCRIPT = 3,
	NETWORK = 4,
	SYNCPROTOCOL = 5,
	LOBBY = 6,
	RENDERER = 7,
	SDK = 8,
	PARSER = 9,
	MESHENGINE = 10,
	PATHPLANNER = 11,
	TEXTENGINE = 12,
	NUGGETS = 13,
	SOUNDENGINE = 14,
	BLOOMBERG = 15,
	SESSION = 16,
	AUDIO_VOICE_PLAYBACK = 17,
	FEEDBACK = 18,
	CONDITION = 19,
	QUEST = 20,
	CAMERA_SEQUENCES = 21,
	SESSION_LOADER = 22,
	AI = 23,
	FIRST_PERSON = 24,
	AUTOMATED_TESTS = 25,
	GUI_GENERAL = 26,
	GUI_FOCUS = 27,
	GUI_SOUND = 28,
	GUI_TUTORIAL = 29,
	TOOLONE = 30,
	TOOLS = 31,
	EAL = 32,
	UPLAY = 33,
	PHOENIX = 34,
	ATOM = 35,
	GEAR = 36,
	UBISERVICES = 37,
	STORM = 38,
	KEEL = 39,
	CONSOLE = 40,
	LIFECYCLE = 41,
	CALLSTACK = 42
}

---@meta rdsdk.Severity
---@enum rdsdk.Severity
rdsdk.Severity = {
	EMERGENCY = 0,      -- Emergency: system is unusable
	ALERT = 1,			-- Alert: action must be taken immediately
	CRITICAL = 2,       -- Critical: critical conditions
	ERROR_SEVERITY = 3, -- Error: error conditions - named this way because of collision with ERROR preprocessor define
	WARNING = 4,        -- Warning: warning conditions
	NOTICE = 5,		    -- Notice: normal but significant condition
	INFORMATIONAL = 6,  -- Informational: informational messages
	VERBOSE = 7         -- Debug: debug-level messages - named this way because of collision with DEBUG preprocessor define
}

---@meta rdsdk.LogOutputMode
---@enum rdsdk.LogOutputMode
rdsdk.LogOutputMode = {
	LOGFILE = 0,			-- slow
	STUDIO = 1,				-- uses OutputDebugString
	LOGFILEWITHOUTFLUSH = 2,-- fast, but with output buffering on
	STDOUT = 3,
	GRAYLOG2 = 4,			-- sends all logs to a graylog2 server using GELF protocol
	CONSOLE = 5,			-- sends all logs to the connected console tools
	TELEMETRY = 6 			-- sends all logs to Telemetry
}

---@meta rdsdk.Logger
---@class rdsdk.Logger
---@field level rdsdk.Severity sets the log filter for importance (lower gets cut)
---@field allowed rdsdk.Category[] list of all categories that are allowed to log
---@field blocked rdsdk.Category[] list of all categories that are blocked
---@field logOutputMode rdsdk.LogOutputMode[] list of all outputs the logs should be routed to
rdsdk.Logger = {}

