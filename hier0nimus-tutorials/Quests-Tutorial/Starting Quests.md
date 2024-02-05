# How to start a Quest:

You can start quests with several different ways. What to use mainly depends on how you want your quests to start and how many you have.  
Simply using `ActionStartQuest` in any Trigger or Quest Actions works fine and may be the easiest solution for a single Quest.  
But when you have multiple Quests that either should be chosen randomly or even a Questline that should start one after the other, it will save alot of work and headaches to use ***QuestPools*** and if you want also ***QuestLines***.

## ActionStartQuest:
### Basic usage:
Open p-t.xml and search for `<Name>ActionStartQuest</Name>` to see valid content of this action and some descriptions.

**Example:**  
(In Triggers it is called `TriggerActions/Item/TriggerAction`, while on some other locations it is `Actions/Item/Action` instead, compare with vanilla if you are unsure what to use)
```xml
  <Item>
    <TriggerAction>
      <Template>ActionStartQuest</Template>
      <Values>
        <Action />
        <ActionStartQuest>
          <Quest>150621</Quest>
          <QuestSession>180023</QuestSession>
        </ActionStartQuest>
      </Values>
    </TriggerAction>
  </Item>
```
This action will start the **Quest 150621 in Old World session 180023**.  
`QuestSession` p-t.xml description:  
> The session where this quest should be started or a region(= list of sessions) where a session is randomly chosen from if the player entered that session already

Hardcoding the session like this is always the easiest way to define the session the quest should start.

***Important Note:***  
Starting a Quest with `ActionStartQuest` does ignore many things Quests can have defined, especially it does ignore the `PreConditionList` of a Quest! If you want to use all features from Quests, you maybe better should use a [QuestPool](./Creating%20QuestPools.md).


### Advanced Usage:
TODO evlt auch Interhit UseCurrentSession GetQuestSessionFromArea usw eingehen.  
SubQuests die automatisch durch ConditionQuestSubQuest gestartet werden.

# QuestPools:
See also [Creating QuestPools](./Creating%20QuestPools.md)
