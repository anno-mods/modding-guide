-- this script will configure the game to match the diary study requirements
local Version = require "versionhelper"
local SpecialGUIDs = require("specialguids")

system.waitUILoaded()
print("Main menu entered.")

-- Remove unwanted Main Menu buttons
RuntimeSettings:HideTitleButton(datasets.TitleButton.Shop)
RuntimeSettings:HideTitleButton(datasets.TitleButton.HallOfFame)
RuntimeSettings:HideTitleButton(datasets.TitleButton.Credits)

-- Remove unwanted Pause Menu buttons
RuntimeSettings:HidePauseMenuButton(datasets.PauseMenuButton.Store)
RuntimeSettings:HidePauseMenuButton(datasets.PauseMenuButton.PhotoMode)