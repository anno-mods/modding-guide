---@meta rdgs.CBenchmarkManager
-- Generated File, do not edit (template Declaration.stg)

---@class rdgs.CBenchmarkManager
---@field LastBenchmarkDate string		returns a formatted date and time of the last benchmark. Returns empty string if there is no benchmark recorded yet
local CBenchmarkManager = {}
Benchmark = CBenchmarkManager
AddBenchValue = CBenchmarkManager
AddBenchTag = CBenchmarkManager
---initialize the benchmark pointer
---@param self rdgs.CBenchmarkManager
function CBenchmarkManager.CreateBenchmark(self) end
---write data of benchmark to disk
---@param self rdgs.CBenchmarkManager
---@param benchmarkPrefix string
function CBenchmarkManager.FinishBenchmark(self, benchmarkPrefix ) end
---samples a single run (maybe with certain graphics settings)
---@param self rdgs.CBenchmarkManager
---@param name string
function CBenchmarkManager.StartBenchmarkRun(self, name ) end
---finish recording to access gathered data
---@param self rdgs.CBenchmarkManager
function CBenchmarkManager.StopBenchmarkRun(self) end
---add a value to a storage with the name given
---@param name string
---@param val number
function CBenchmarkManager.AddBenchValue(name , val ) end
---add a tag to a storage with the name given
---@param name string
---@param tag string
function CBenchmarkManager.AddBenchTag(name , tag ) end
---@param self rdgs.CBenchmarkManager
---@param allQualitySets table<integer, table<rdgs.QualitySettings, integer>>
---@param benchmarkScript string
function CBenchmarkManager.ScheduleSuite(self, allQualitySets , benchmarkScript ) end
---@return boolean returns true if weak pointer holds a valid reference
function CBenchmarkManager.isValid() end

return CBenchmarkManager
