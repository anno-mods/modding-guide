# QuestPools:
[QuestPools Properties](./0-Properties-Quest-QuestPool.md#propertiesvalues-of-questpools)

QuestPools are a helper construct to automatically start quests on regular basis if PreConditions are fullfilled. Eg. if you made like 10 Quests that simply should be chosen randomly if preconditions are fullfilled (just like the games Random Quests) you can put your Quests in a pool and define how often the pool should start up to how many quests at once and so on. It also supports adding QuestLines into the pool instead of Quests directly to make sure they are started one after the other.

- We will [start the Quests](./Starting%20Quests.md) with help of a **QuestPool**:
  <details>
  <summary>(CLICK) CODE</summary>  
  
  ```xml
  <ModOp Type="addNextSibling" GUID="150725">
    <Asset>
      <Template>QuestPool</Template>
      <Values>
        <Standard>
          <GUID>2001000002</GUID>
          <Name>QuestPool</Name>
        </Standard>
        <QuestPool>
          <Quests>
            <Item>
              <Quest>2001000001</Quest>
              <Weight>10</Weight>
            </Item>
            <Item>
              <Quest>2001000004</Quest>
              <Weight>10</Weight>
            </Item>
          </Quests>
          <PoolCooldown>60000</PoolCooldown>
          <QuestCooldown>0</QuestCooldown>
          <CooldownOnQuestStart>1</CooldownOnQuestStart>
          <CooldownOnQuestEnd>0</CooldownOnQuestEnd>
          <AffectedByCooldownFactor>1</AffectedByCooldownFactor>
          <IsMainStoryPool>0</IsMainStoryPool>
          <IsTopLevel>1</IsTopLevel>
          <QuestLimit>1</QuestLimit>
        </QuestPool>
        <Locked>
          <DefaultLockedState>0</DefaultLockedState>
        </Locked>
      </Values>
    </Asset>
  </ModOp>
  ```
  </details>

This Pool will automatically start the Quests as soon as the PreConditions of the Pool and of a Quest are met. There is no need to add this pool somewhere else or to activate it. If you set DisabledByDefault=1 in a pool it will be disabled (not starting any quests) and need to be enabled first with ActionSetQuestPoolEnablement and IsQuestPoolEnabled=1. But enabling/disabling pools with ActionSetQuestPoolEnablement is only needed if you are not able to include it as PreCondition (this vanilla pool is eg. disabled when the player looses the continental island).
Some QuestPools are also added to AI player assets, like <QuestPool>150082</QuestPool> is added to Jorgensen. This is not mandatory, as far as I know this only means that Quests are offered at the lighthouse of the AI and you don't have to define the starting point of a Quest in the Quest itself (?).

## Pools including SubPools
Pools can include other Pools as [SubPools](./0-Properties-Quest-QuestPool.md#questsgroupssubpools) (see explanation on that link, it is already quite good explained there why you may want to use SubPools).  


## QuestLine:
They are a very simple lists including Quests in your preferred order. You can add the GUID of a `QuestLine` to a`QuestPool` instead of `Quest`.  
The `QuestLine` will make sure that the Quests must be solved in this specific order. The first Quest must be completed before the second one can start and so on (PreConditions of each Quest must be fullfilled of course).  
- Failing/Aborting a Quest will make the QuestLine to start that Quest again (if the `MaxCallOut` setting of your Quests allow it and of course after your PoolCooldown) until you solved it. After you solved all Quests of the QuestLine it may start over again from the very first Quest, if the `MaxSolveCount` of your Quests allow it.
- Quests that have reached their `MaxSolveCount` will not be triggered again. Usually you should use the same value for all the Quests being in the same QuestLine. Assuming you set it to 1 for the first Quest and unlimited for the others, the QuestLine is unable to start from beginning again after you solved all of them once.
- Same is true for `MaxCallOut`. If a Quest reaches this and was not solved, it will be impossible to continue the QuestLine.
