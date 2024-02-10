# Documentation of some lua commands

There is no official documentation.The textsourcelist.json is quite outdated, but still partly tells us what arguments are expected and what is returned, although not everything from it is useable in lua.  
Here we will collect some helpful lua commands, what they do and how they are used. Feel free to contribute.  

## PlayerCounter in lua
`ts.Participants.GetParticipant(ParticipantID).ProfileCounter.Stats.GetCounter(CounterValueType,PlayerCounter,Context,CounterScope,ScopeContext)`  
With this command you can count and get the number returned for most things you can also check with PlayerCounter in xml.   
CounterValueType/PlayerCounter/CounterScope and ParticipantID can be found in datasets.xml. Context is the GUID you want to search for and ScopeContext the GUID for your Scope, eg. a Session-GUID if you CounterScope is Session.  
**Note:** You do not enter strings here, but the datasets.xml list-positon, so eg. 6 for PlayerCounter `GoodsInStock` and 25 for Jorgensen as ParticipantID (it is not the "Id" you find there, but the position (starting from 0) of that entry in the datasets.xml list. It is often the same, but some lists are missing IDs which makes them different).  

## Register Triggers / Start Quests
- `ts.Conditions.RegisterTriggerForCurrentParticipant(TriggerGUID)`  
- `ts.Quests.StartQuestForCurrentPlayerNet(QuestGUID)`
- `ts.ToolOneDataHelper.GetUnlockTriggerForAsset(AssetGUID)` to get the TriggerGUID of the Trigger that unlocks AssetGUID.

## Unlock/Relock assets
- `ts.Unlock.GetIsUnlocked(AssetGUID)`: returns booleane if sth is locked or not.
- `s.Unlock.SetUnlockNet(AssetGUID)`
- `ts.Unlock.SetRelockNet(AssetGUID)`




 
