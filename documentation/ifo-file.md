# Ifo File

To work with .ifo files a simple text editor can be sufficient, especially when you just want to delete an entry or resize the BuildBlocker for example. However for everything else Blender + [Anno Addon](https://github.com/xormenter/Blender-Anno-.cfg-Import-Addon) is recommended to avoid going crazy.

In Blender: 

- Cuboids: do **not** `Ctrl A` `All Transforms` before export   
- Planes: **do** `Ctrl A` `All Transforms` before export

## Cuboids

Cuboids mostly appear as `<Dummy>` which only distinguish by their `<Name>` (see exceptions) and are fully determined by their `<Position>`, `<Rotation>` and `<Extent>`  (related to their center point). 

<details>  
<summary>Click to expand: Code Example</summary>

```xml
<Dummy>
		<Name>transporter_spawn</Name>
		<Position>
			<xf>1.189299</xf>
			<yf>0.000000</yf>
			<zf>3.588088</zf>
		</Position>
		<Rotation>
			<xf>0.000000</xf>
			<yf>0.703321</yf>
			<zf>0.000000</zf>
			<wf>-0.710925</wf>
		</Rotation>
		<Extents>
			<xf>0.100000</xf>
			<yf>0.100000</yf>
			<zf>0.100000</zf>
		</Extents>
</Dummy>
```

</details>

- All names with an appended `_` usually have consecutive digits starting at 0
- All names with an appended `_01` continue with `02`, `03` and so on
- Names with 01, 02 but without `_` are fixed names, so sth like `railroad03` would not work

| Name                  |   Tag                 | Usage                                                                | assets.xml                   |
| :--------------       | :------------------   | :-------------------------------------------------------------       | :---------------------       | 
| BoundingBox              |      BoundingBox      | includes the whole cfg | 
| MeshBoundingBox          |      MeshBoundingBox  | includes the mesh geometry | 
| HitBox                   |      IntersectBox     | asset is highlighted during mouse-over and considered being selected for tool-bar actions |
| infolayer                |      Dummy            | position of `InfoLayerIcon` such as 'Missing Workforce'  | enable with `<Infolayer />`; template: `InfoLayerIcon` 
| transporter_spawn        |      Dummy            | position of factory transporters in idle mode / before first move  | `HideTransportersBeforeTheyMove=1`  
| quest_spawn_             |      Dummy            | position where `QuestObjects` are spawned (for special quests like campaign there are other names like `campaign_demolition_quest_spawn`  | enable with `<QuestObject />`; Quests: Name can be used in `ContextMarkerName`  
| DamageImpact             |      Dummy            | when damaged (incidents or weapons) but not ruined: area where mesh shows damage  | 
| harbourblock01           |      Dummy            | blocks harbour area infront of buildings; minimum size is 5x5 tiles: x/z axis => 0 to 0.49 == 5 tiles; 0.5 to 0.99 == 6 tiles etc.  | 
| docklandsmodule01        |      Dummy            | blocks harbour area infront of buildings; minimum size is 3x3 tiles x/z axis => 0 to 0.49 == 3 tiles; 0.5 to 0.99 == 4 tiles etc. | 
| loadingpier01            |      Dummy            | docking position for ships; use `loadingpier02` for a 2nd pier  | configure in `<LoadingPier>`
| loadingpier_air          |      Dummy            | docking position for airships   | configure in `<LoadingPier>`
| hit_metal_               |      Dummy            | when hit by weapons: trigger metal sound / visuals     | linked in projectile assets <EffectSequences>
| hit_wood_                |      Dummy            | when hit by weapons: trigger wooden sound / visuals   | linked in projectile assets <EffectSequences>
| hit_bricks_              |      Dummy            | when hit by weapons: trigger brick sound / visuals    | linked in projectile assets <EffectSequences>
| hit_concrete_            |      Dummy            | when hit by weapons: trigger concrete sound / visuals  | linked in projectile assets <EffectSequences>
| expl_01                  |      Dummy            | when hit by weapons: area with explosion effects | can be defined in `<ExplosionEffects>`
| warflag                  |      Dummy            | a war flag is spawned at this position when island is at war   | 
| hpbar                    |      Dummy            | when being attacked: position of current hitpoints bar | 
| FireDummy                |      Dummy            | position of fire (if no .fc file) | 
| railroad01               |      Dummy            | connection to rails; use `railroad02` for another one | `HasBuildingBaseTiles=1` to remove them after asset was destroyed / moved; `AllowCodeToControlRotation=0` if they are not centered relative to the building
| railroadbase01           |      Dummy            | mandatory use with railroad01 / railroad02 | 
| mining_ground            |      Dummy            | WorkAreaPath starts here   | `<WorkAreaPathSnapDummy>`
| mining_mountain          |      Dummy            | WorkAreaPath ends here   | `<WorkAreaPathSnapDummy>`
| irrigation_connector     |      Dummy            | for water source: connection to irrigation canals   |
| watersupply_connector    |      Dummy            | for water consumer: connection to irrigation canals |
| slot_station             |      Dummy            | start position for river channel   | `BezierPath` / `StartPositionDummyName`
| turret_                  |      Dummy            | position of a turret   | configure in `<Turrets>`
| shootTurret_             |      Dummy            | turrets: position of muzzle effects / projectile  | configure in `<MuzzleEffectAssets>` / `<ProjectileAsset>`
| shootLeft_               |      Dummy            | cannons: position of muzzle effects / projectile  | configure in `<MuzzleEffectAssets>` / `<ProjectileAsset>`
| shootRight_              |      Dummy            | cannons: position of muzzle effects / projectile  | configure in `<MuzzleEffectAssets>` / `<ProjectileAsset>`
| shootFront_              |      Dummy            | cannons: position of muzzle effects / projectile  | configure in `<MuzzleEffectAssets>` / `<ProjectileAsset>`
| WorkforcePier            |      Dummy            | connection for workforce transfer ships | enable with `<WorkforceConnector />`
| VisitorPier              |      Dummy            | connection for tourist ships | enable with `<VisitorPier />`
| ShipEntrance             |      Dummy            | *? some kind of anchor for incoming visitor / workforce ships ?* | 
| SpecialistSpawn          |      Dummy            | should spawn a clickable specialist on arrival (not used anymore?) | 
| BoardingDummy_           |      Dummy            | on ship arrival: feedbacks walk towards island | configure in `HarborWaterConfig`
| DisembarkDummy_          |      Dummy            | on ship arrival: feedbacks walk towards ship   | configure in `HarborWaterConfig`
| TouristIdleDummy_        |      Dummy            | visitors gather here until ship arrival if the "Tendency" is negative | 
| special_feedback_loading |      Dummy            | spawn point for fishing ship | configure in `<FisheryConfig>` (per region)
| nextFloor                |      Dummy            | indicates position of the next floor level for skyscrapers | 
| backside_rect            |      Dummy            | indicates the backside of a train wagon; important for directional coupling | 
| frontside_rect           |      Dummy            | indicates the frontside of a train wagon; important for directional coupling | 
| bird_land01              |      Dummy            | birds can land here | 
| speaker_                 |      Dummy            | *? Anarchist loudspeaker audio ?*   |
| joint_back               |      Dummy            | *? used in several vehicles with trailers ?* | 
| GeneratedItemSlot        |      Dummy            | *? does nothing; used for coastal_01, food_01, factory_06, workshop_06; institution_02 ?* | 
| EventPier                |      Dummy            | *? does nothing; used for visitor piers ?* | 
| HarborFrontBuilding      |      Dummy            | *? does nothing; used for visitor piers and workforce pier ?* |
| fire_                    |      Dummy            | *? only used for man_of_war and campaign queen ship; leftover with no function ?* | 

## Planes

Planes can consist of as many vertices as you want to achieve quite complex blockers. Each vertice is translated into a pair of `x` and `z` coordinates related to the center point of your `MAIN_FILE` [should be (0/0/0)].
Therefore `Ctrl A` `All Transforms` on all planes is highly recommended if you work with Blender.

> Note that 1 tile in Anno corresponds to \|x\| = 0.5 / \|z\| = 0.5

<details>  
<summary>Click to expand: Code Example</summary>
  
```xml
<BuildBlocker>
		<Position>
			<xf>6.000000</xf>
			<zf>4.000000</zf>
		</Position>
		<Position>
			<xf>6.000000</xf>
			<zf>-4.000000</zf>
		</Position>
		<Position>
			<xf>-6.000000</xf>
			<zf>-4.000000</zf>
		</Position>
		<Position>
			<xf>-6.000000</xf>
			<zf>4.000000</zf>
		</Position>
</BuildBlocker>
```

</details>

- For most entries you can have as many as you want, their names stay the same, no consecutive digits. 
- UnevenBlocker can be used only once per .ifo file.

| Tag                      | Usage                                                                | assets.xml             |
| :--------------          | :-------------------------------------------------------------       | :---------------       | 
| BuildBlocker             | the (logical) footprint an asset has ingame (== usually blocked tiles) |  almost all properties of `<Blocking/>` only work within this blocker
| FeedbackBlocker          | dynamic feedback is allowed to walk here (includes first person mode) | 
| PriorityFeedbackBlocker  | dynamic feedback is not allowed to walk here (includes first person mode) | 
| UnevenBlocker            | mesh within and above this plane is always above terrain. Usually used for assets with `AdjustToTerrainHeight=0` |
| WaterBlocker             | blocks area for ships  | 
| QuayArea                 | area where a quay is constructed automatically (by default: with fence) | configure in `GroundDecalAsset`
| InvisibleQuayArea        | area where a quay is constructed automatically (by default: without fence); if overlapping with QuayArea: overwrites QuayArea | configure in `GroundDecalInvisible`
| PathBlocker              | *? probably some kind of feedback blocker; rarely used; is not imported into Blender ?*  | 
| ExtraBlocker             | *? rarely used (e.g. calamari fishery); is not imported into Blender ?*  | 

## MeshHeightMap

Dynamic feedback adapts to this heightmap instead of terrain. Usually used for assets with `AdjustToTerrainHeight=0`. 

Guide on how to create this map: [MeshHeightMap](https://github.com/anno-mods/modding-guide/blob/main/guides/Mesh-Height-Maps.md)

## Sequences

One entry for each sequence used in the corresponding cfg. For all possible sequence IDs look at `<SequenceIDs>` in `>GlobalBalancing<` (Guid: 2001270).
