# Multiplayer Compatibility (xml)

There are a few things that do not properly work in Multiplayer, especially in Triggers and Quests (~1%), while 99.9% of other xml stuff works fine in Multiplayer.  
Feel free to add more problems related to xml and Multiplayer if you know some.  
(For **lua** and MP see [here](../Scripting/basics.md#multiplayer-sync))

## Conditions
- Conditions related to the **UI** from a player, like ConditionEvent + **MovieFinished/NotificationRemoved/EnterUIState/LeaveUIState** and similar or ConditionGUIEvent are only checked locally for the client and therefore will cause desync in multiplayer.  
- - **Workaround**: Try to achieve the same result with other Conditions.   
- - - For Movies eg. check how long the Movie is and use ConditionTimer after the Movie was triggered.   
- - - For NotificationRemoved you can at least use for Character Notifications sth like `<ThirdpartyDefaultCommand>[Unlock UnlockNet(GUID)]</ThirdpartyDefaultCommand>` to unlock sth as soon as the Notification closes, which is then used in an Unlock-Condition. Or simply again use ConditionTimer/DelayedAction after your ActionNotification, if possible.  
- **ConditionActiveSession** checks in a coop game all sessions any of the coop players is active in. So it can be true while only one of the coop players is active here.  

## Actions
- **ActionSpawnObject** with SpawnGUID being an **AssetPool** will spawn a random asset from that pool, but unfortunately it also causes desync, since it does not choose the same for all players in multipalyer (btw. an AssetPool also refuses to work at all, if it only contains a single asset, at least tested with ActionDeleteObjects)
- - **Workaround**: No good workaround known yet (to spawn one random object from a list of objects). Best I can imagine may be a QuestPool with Quests having different weight and randomly choosing one of these (but Quests can not be executed for AI players)  
- Values like **UseCurrentSession/CounterScopeUseActiveSession** will be in a Coop game always the Session, where the Coop-Leader is currently active in. This can especially be a problem if you want to do sth. in a specific session as soon as the player is active in it and you use ConditionActiveSession and then UseCurrentSession, which may hit not the session you expected to hit!  

## Quests
- **Decision Quests**  
in general are not multiplayer compatible if several players have the same Quest GUID active at the same time! The option chose by one player will also be chosen for other players.  
Luckily the Actions resulting from a decision seems to be only executed for the correct player.  
**Workaround**: Either make sure this Quest can only be active for one player at a time ([CanBeActiveForMultipleParticipants=0](../hier0nimus-tutorials/Quests-Tutorial/0-Properties-Quest-QuestPool.md#canbeactiveformultipleparticipants)). Or make 4 Quest Assets each with its own GUIDs (you can use BaseAssetGUID to not need to copy the whole code several times) and start the first only for Human0, second only for Human1 and so on (eg with help of this shared mod [shared_WhichPlayer_Condition](https://github.com/Serpens66/Anno-1800-SharedMods-for-Modders-/blob/main/shared_WhichPlayer_Condition/modinfo.json) )  
- - **AutoShowDecisionScreen**: It opens the Decision for every human player and accepts decisions made by players who should not be able to choose. So don't use this for a mod that should work in Multiplayer (you could have in total 5 copies of the same Quest, 4 for each Human in case the game is multiplayer and one with AutoShowDecisionScreen=1 if the game is singleplayer (use conditions to check))  
- **General_Enemy** is the owner of enemy ships in most Quests. There is only one General_Enemy which is at war with all human players, so keep in mind that human players may attack the enemies belonging to Quests active for another player.  

## Other
- Trying to enable unused Diplomatic actions, like **"PaymentDecreaseReputation"**, to use the button in Diplomacy Menu for something else: Using these buttons also causes Desync unfortunately.. (I (Serp) worked on a mod to add a button to diplo-menu to add more diplomatic options, but now I will try to implement it differently, not via the diplo-menu)  


