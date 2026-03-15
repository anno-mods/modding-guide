-- benchmark using async camera sequence control
local SessionGUID = require "sessions"
local Test = require "testhelper"

system.waitUILoaded()

Benchmark:CreateBenchmark()

Benchmark:StartBenchmarkRun("Loading")
await(Game:Load("data/script/benchmark/benchmark.a8s", true, true))
Benchmark:StopBenchmarkRun()

-- run sequences
local function benchmarkCameraSequence(seqId, islandId, name)
    print("Start paused sequence " .. seqId)
    local camSequence = CameraSequenceManager:RunCameraSequence(islandId, seqId, true)
    print("Start waiting for asset loading...")
    local waitForLoadingAssets = CameraSequenceManager:WaitForAutoResume()
    await_all(waitForLoadingAssets, system.sleep(1000))
    print("Finished waiting (min 1000 ms)")
    Benchmark:StartBenchmarkRun(name)
    print("Resumed sequence " .. seqId)
    await(camSequence)
    Benchmark:StopBenchmarkRun()
    print("Benchmark run finished.")
end

benchmarkCameraSequence(0, 0, "Clip1")
benchmarkCameraSequence(3, 0, "Clip2")
benchmarkCameraSequence(5, 0, "Clip3")
benchmarkCameraSequence(7, 0, "Clip4")
benchmarkCameraSequence(8, 0, "Clip5")
benchmarkCameraSequence(10, 0, "Clip6")
benchmarkCameraSequence(11, 0, "Clip7")

Benchmark:StartBenchmarkRun("SessionSwitch")

-- jump to Albion
await(Scripts:JumpToSession(SessionGUID.Base_Province_Celtic_Britannia))

Benchmark:StopBenchmarkRun()

benchmarkCameraSequence(2, 0, "Clip8")
benchmarkCameraSequence(3, 0, "Clip9")
benchmarkCameraSequence(5, 0, "Clip10")
benchmarkCameraSequence(6, 0, "Clip11")
benchmarkCameraSequence(7, 0, "Clip12")
benchmarkCameraSequence(9, 0, "Clip13")
benchmarkCameraSequence(10, 0, "Clip14")

await(Game:Unload())
Benchmark:FinishBenchmark("Clip")
