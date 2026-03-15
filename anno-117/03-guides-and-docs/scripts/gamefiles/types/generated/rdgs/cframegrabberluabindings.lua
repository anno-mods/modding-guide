---@meta rdgs.CFrameGrabber
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CFrameGrabber
---@field IsCapturingFrames boolean		returns true, if capturing is enabled
---@field CaptureFixedFPS integer		frame rate of the capture
---@field CapturePrefix string		prefix for capture filenames
---@field CaptureFormat string		format of captured frames (\"png\", \"bmp\")
---@field DepthCaptureEnabled boolean		enable/disable depth capture
---@field NormalCaptureEnabled boolean		enable/disable normal capture
---@field ScreenshotFormat string		format of captured frames (\"png\", \"bmp\", \"jpg\")
local CFrameGrabber = {}
FrameGrabber = CFrameGrabber
---creates a screenshot and stores it in the screen shot folder
---@param self rdgs.CFrameGrabber
function CFrameGrabber.TakeScreenshot(self) end
---start or stop screen capture mode. Configuration is fetched from the ini file
---@param self rdgs.CFrameGrabber
function CFrameGrabber.ToggleFrameCaptureMode(self) end
---@param self rdgs.CFrameGrabber
function CFrameGrabber.StartFrameCaptureMode(self) end
---@param self rdgs.CFrameGrabber
function CFrameGrabber.StopFrameCaptureMode(self) end
---@return boolean returns true if weak pointer holds a valid reference
function CFrameGrabber.isValid() end

return CFrameGrabber
