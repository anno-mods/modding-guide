# QuestPools:
[QuestPools Properties](./Properties-Quest-QuestPool.md#propertiesvalues-of-questpools)

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
