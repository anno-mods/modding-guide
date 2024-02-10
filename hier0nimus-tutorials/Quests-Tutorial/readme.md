# WIP Tutorial Quests, written by Serp:

This tutorial will show you how to create quests and how to properly start them. 
 
I will use GUIDs from the personal GUID Range: https://github.com/anno-mods/GuidRanges?tab=readme-ov-file#personal-guid-range  
If you plan to publish your mod, make sure to reserve your own GUID Range there to not conflict with other mods.  


[Quests Properties](./0-Properties-Quest-QuestPool.md#propertiesvalues-of-quests-explained)  
[QuestPools Properties](./0-Properties-Quest-QuestPool.md#propertiesvalues-of-questpools)  


1) [Creating a Quest](./Creating%20a%20Quest.md)  
2) [Starting Quests](./Starting%20Quests.md)  
3) [Creating QuestPools](./Creating%20QuestPools.md)  

## Testing ingame
To **easier test your code ingame**, feel free to use this Cheatmod:
[Cheat Keybinds (Serp) v1.02](https://github.com/Serpens66/Anno-1800-SharedMods-for-Modders-/releases/tag/testing-cheat)  

## Multiplayer
There is a reason why most vanilla Story Quests are disabled in Multiplayer. Random Quests usually work fine.  
- **Desyncs:** Conditions like "MovieFinished/NotificationRemoved/EnterUIState/LeaveUIState" and similar, looking for the client dealing with UI are unfortunately causing desyncs.  
Workarounds can be found in my **"Campaign in Coop (Serp)"** mod you may find here https://github.com/Serpens66/Anno-1800-Mods either in "YouKnowWhatYouDo-Mods" or in "WorkInProgress-Mods" folder.  
- **DecisionQuests:** DecisionObjective are not fully multiplayer compatible.
- - AutoShowDecisionScreen will open the Decision Screen for all human players, even for those not having any Quest active. So do not use this for Multiplayer.
- - If several different human players have the same DecisionQuest (GUID) active, the decision one of them chooses is automatically also chosen for the other human player. A workaround for this is to make one Asset with unique GUID per human player (Human0 to Human3) to make sure Human0 never can have the same DecisionQuest GUID active like any other Human.  
- **Human0** in code/default: Many commands/actions/conditions default to Human0 (the Host) (eg many vanilla Quests use "CheckSpecificParticipant=1", but nothing more, which defaults zo Human0). So make sure to always use code that contains the word "processing" (eg. CheckProcessingParticipantID or BuffProcessingParticipant and so on) which usually means "the player executing this code". This way it will work for every human, not only the Host.
