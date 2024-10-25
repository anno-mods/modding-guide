# Create custom cloth .rdms 

Taubenangriff made [a new version of the rdm4-bin.exe](https://github.com/lukts30/rdm4/releases/tag/v0.11.0-alpha.1) which now supports the vertex format `P3f_N3f_G3f_B3f_T2f_C4b` when converting from `.gltf/.glb to .rdm` (atm not from `.rdm to .gltf/.glb`). 
This format is required for `Clothes`, which are usually used for flags, sails and all other models which are supposed to not to be stiff.

In comparison to the simple `Wind_Ripples` effect which is available for the common assets (`T2h` and `I4b`), `Clothes` allow much bigger meshes and targeted deflections for each vertice. If you just need a small awning which should fake
motion through wind, then the `Wind_Ripples` effect should be sufficient (simply enable it in the corresponding cfg material and adjust its values). 

As an easy example for this guide we recreate one of the ornamental airport flags but apply less deflections: `data/dlc11/graphics/buildings/ornaments/airport/airport_flag_02.cfg`

## Import mesh
You can...

- either just convert the .rdm to .gltf/.glb via console and import it into Blender without using the Anno Import/Export addon, cause the Addon does not support `P3f_N3f_G3f_B3f_T2f_C4b` as an export option yet anyway.
- or you import the whole .cfg as always and simply add an extra argument to the console at the end of the process.

In this case, import via option 2 is faster, so I used that one here. 

## Vertex Paint
- After import click on your model and go to the `Object Data Properties` tab on the right. There you click on `Color Attributes` (picture 1). With `+` you add a new attribute to our mesh.
- As soon as you do so, a window pops up and gives you some options: `Domain` should be `Vertex` and `DataType` should be `Color`. The color you select below is the default color all your vertices of this mesh will be assigned to:
  - White means = no deflection by default (100 % stiff)
  - Black means = max. deflection by default
  - Any grey tone inbetween = proportional deflection
- It´s up to you, I chose white in this case.
  
![cloth2](./_sources/cloth2.png)

- Click on `Viewport Shading` and select `Attributes`. Then switch into `Vertex Paint` mode:

![cloth3](./_sources/cloth3.png)

- If you chose white before, your whole mesh is now covered in white. To tell Anno where to deflect your mesh, select black or any grey tone in the color tab. Then draw on your mesh and see what happens if you hit a vertice with your brush :)
- In this case, the vertices on the left can be black, since they should move the most, the adjacent vertices should move a bit less. So either adjust the color again or simply use the `Strength` slider to get any grey tone.
- I left the vertices next to the pole and the upper vertices white, but they should actually be slightly grey to achieve a more realistic effect.

![cloth6](./_sources/cloth6.png) 
This is how it looks like in `Edit mode`:
![cloth7](./_sources/cloth7.png)

Before export, make sure your face normals are continuous for all areas which should behave as a single piece of cloth ingame. Otherwise each discontinuous area will be affected by the cloth dynamics (set in your cfg) individually and you won't get a continuous deflection across your cloth surface. 
In this example this is already the case, so nothing more to do here. 
However for other (custom) meshes this could not be the case. Therefore: 

- Select your mesh, go into EDIT mode and **Vertex Selection Mode**, press `A` to select all vertices of your mesh (or choose all vertices which should belong to one cloth section)
- Press `M`, choose `By Distance`
- Switch to **Face Selection Mode**, right click and select `Shade Smooth`

## Export mesh and conversion to rdm

- If imported via .gltf/.glb: skip to the next step
- If imported via cfg: Click on the model --> `Ctrl A` --> `All Transforms`. Alternatively set all Location, Rotation values to 0 (except Rotation W = 1) and Scale to 1. Which option you choose, determines if you have to adjust the
Orientation_Transform in the cfg afterwards or not. If you decided to use `Ctrl A` and to export the whole cfg as well, which is probably the way most people here do it, then you have no locations, rotations, scales to adjust afterwards.
However there might be cases, where you don't want to export the cfg, but just the model. In such cases: If you chose `Ctrl A`, you have to manually set all Location, Rotation, Scale values to their default values in the cfg. But if you
set all Location, Rotation, Scale values to their default values in Blender before export, you don't have to touch the original Orientation_Transform in the cfg (this is, because we export the model via glTF 2.0 not via Addon).

- In any case: Choose `glTF 2.0` as export option with the settings below:

![cloth8](./_sources/cloth8.png)

- Open a console terminal of your choice and use:

> `your_path/rdm4-bin.exe -i your_path/your_file.glb -g=P3f_N3f_G3f_B3f_T2f_C4b`

> and if you imported via .cfg add: `--negative-x-and-v0v2v1` to mirror the model correctly again.

- You may notice that in the .cfg file the vertex format for CLOTH elements is displayed as `<VertexFormat>P3f_N3b,T2f</VertexFormat>`. Nothing to worry about. Example: 

```xml 
<Clothes>
    <Config>
        <ConfigType>CLOTH</ConfigType>
        <Transformer>
            <Config>
                <ConfigType>ORIENTATION_TRANSFORM</ConfigType>
                <Conditions>0</Conditions>
                <Position.x>0.073091</Position.x>
                <Position.y>1.488325</Position.y>
                <Position.z>0.002520</Position.z>
                <Rotation.x>0.000000</Rotation.x>
                <Rotation.y>0.000000</Rotation.y>
                <Rotation.z>0.000000</Rotation.z>
                <Rotation.w>1.000000</Rotation.w>
                <Scale>0.900000</Scale>
            </Config>
        </Transformer>
        <Materials>
            <Config>
                <ConfigType>MATERIAL</ConfigType>
                <Name>flag_cloth</Name>
                <ShaderID>0</ShaderID>
                <VertexFormat>P3f_N3b,T2f</VertexFormat>
                <NumBonesPerVertex>0</NumBonesPerVertex>
                <DIFFUSE_ENABLED>1</DIFFUSE_ENABLED>
                <cClothDiffuseTex>data/dlc11/graphics/buildings/ornaments/airport/maps/dlc11_airport_ornaments_flags_diff.psd</cClothDiffuseTex>
                <NORMAL_ENABLED>1</NORMAL_ENABLED>
                <cClothNormalTex>data/graphics/props/flags/ornamental_flags/maps/ornamental_banners_norm.psd</cClothNormalTex>
                <cDiffuseColor.r>1.000000</cDiffuseColor.r>
                <cDiffuseColor.g>1.000000</cDiffuseColor.g>
                <cDiffuseColor.b>1.000000</cDiffuseColor.b>
                <cSpecularColor.r>0.200000</cSpecularColor.r>
                <cSpecularColor.g>0.200000</cSpecularColor.g>
                <cSpecularColor.b>0.200000</cSpecularColor.b>
                <cGlossinessFactor>0.500000</cGlossinessFactor>
                <cAlphaRef>0.100000</cAlphaRef>
                <DYE_MASK_ENABLED>0</DYE_MASK_ENABLED>
                <Atlas>Atlas</Atlas>
                <LOGO_ATLAS_ENABLED>0</LOGO_ATLAS_ENABLED>
                <INVERSE_LOGO_COLORING>0</INVERSE_LOGO_COLORING>
                <RimEffect>RimEffect</RimEffect>
                <cRimColor.r>1.000000</cRimColor.r>
                <cRimColor.g>1.000000</cRimColor.g>
                <cRimColor.b>1.000000</cRimColor.b>
                <cRimIntensity>1.000000</cRimIntensity>
                <Ripples>Ripples</Ripples>
                <RIPPLES_ENABLED>0</RIPPLES_ENABLED>
                <cRippleTiling>0.500000</cRippleTiling>
                <cRippleSpeed>1.000000</cRippleSpeed>
                <cRippleNormalIntensity>0.200000</cRippleNormalIntensity>
                <TerrainAdaption>TerrainAdaption</TerrainAdaption>
                <ADJUST_TO_TERRAIN_HEIGHT>1</ADJUST_TO_TERRAIN_HEIGHT>
                <DisableReviveDistance>0</DisableReviveDistance>
            </Config>
        </Materials>
        <Name></Name>
        <FileName>data\dlc11\graphics\buildings\ornaments\airport\rdm\airport_ornaments_flag_01.rdm</FileName>
        <AdaptTerrainHeight>0</AdaptTerrainHeight>
        <UniqueSimulation>0</UniqueSimulation>
        <AllowLocalWind>1</AllowLocalWind>
        <LocalWindDirection>0.000000</LocalWindDirection>
        <WindStrength>0.500000</WindStrength>
        <Gravity>0.010000</Gravity>
        <LineSize>1.000000</LineSize>
        <CollisionIndex>0</CollisionIndex>
    </Config>
</Clothes>
```

Result ingame: 

![cloth10](./_sources/cloth10.png)





