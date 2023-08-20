
# Mesh Height Maps

`MeshHeightmaps` are necessary for dynamic feedback units, whenever they should walk into or out of buildings which do not adjust to terrain height. Prime examples are stairs and ramps. 

The maps are implemented as an entry in the .ifo file of such a building. As you will see, the code can be extremely long, since these maps often consists of thousands of points, named `<i>`, and each of them needs its own line. 

Basically there are four steps to create such a map: 

1. Set up the code manually in the .ifo file.
2. Import the building with its .ifo file to Blender
3. Adjust the z-positions of each `<i>` which are located at the spots where dynamic units should enter / leave the building.
4. Export your building as usual

## 1. The ifo Code

The basic structure is a following: 

```
<MeshHeightmap>
  <MaxHeight>0</MaxHeight>
  <StartPos>
    <x>-4.000000</x>
    <y>-2.000000</y>
  </StartPos>
  <StepSize>
    <x>0.125000</x>
    <y>0.125000</y>
  </StepSize>
  <Heightmap>
    <Width>65</Width>
    <Height>33</Height>
    <Map>
      <i>-3.000000</i>
      <i>-3.000000</i>
      <i>-3.000000</i>
      ... vast amount of <i> entries ...
    </Map>
  </HeightMap>
</MeshHeightmap>
```
`<StartPos>`: `<y>` and `<x>` are the starting coordinates which spans your plane aka MeshHeightmap. Usually this plane is the same size as your BuildBlocker. You can use any of the four possible point pairs: (x/y); (-x/y); (x/-y); (-x/-y). 
> Unlike the cfg environment where y defines the z (height) axis of Blender, here y corresponds to y in Blender. In other words: The z component of your .ifo BuildBlocker is the y-component of your MeshHeightmap.
   
`<StepSize>`: Defines the distance between two MeshHeightmap points in x and y. Default value is `0.125000` and I guess there´s no reason to change this value.

`<Width>`: Amount of MeshHeightmap points (`<i>`) along the x-axis

- With a `<StepSize>` of `0.125000` 8 points fit in one tile (8 * 0.125 = 1).
- Multiply 8 with the total amount of tiles your building has in x-direction. In the example it´s:
> 8 * (4 tiles in positive x-direction + 4 tiles in negative x-direction) = 64.

- Add 1 to the result to take into account that also x = 0 needs a row of `<i>`. **The final width in the example would be 65**. 

`<Height>`: Amount of MeshHeightmap points (`<i>`) along the y-axis (also y-axis in Blender)

- With a `<StepSize>` of `0.125000` 8 points fit in one tile (8 * 0.125 = 1).
- Multiply 8 with the total amount of tiles your building has in y-direction. In the example it´s:
> 8 * (2 tiles in positive y-direction + 2 tiles in negative y-direction) = 32.

- Add 1 to the result to take into account that also y = 0 needs a column of `<i>`. **The final width in the example would be 33**. 
  
`<i>`: Points of the MeshHeightmap itself. 
- Total amount of `<i>` entries in your .ifo file = `<Width>` * `<Height>`. In the example it´s:
> 64 * 32 = 2048. That means, starting from the current line, 2048 `<i>` entries must be added.

- The value inbetween should represent a height lower than your building reaches under the ground level in Blender. In the example, the value `-3` was chosen.

![MeshHeightMap1](/sources/meshheightmap1.png)

![MeshHeightMap2](/sources/meshheightmap1.png)

## 2. After the import to Blender

- Select the MeshHeightmap and switch to EDIT MODE.
> **IMPORTANT**: Select Mode must be set to Vertex, otherwise the points won´t be visible!

- Select the points aka vertices and move them along their z-axis until they match the faces of your stairs, ramps, whatever.
> You can´t add new points in Blender - well you actually can, but they won´t be exported.

![MeshHeightMap3](/sources/meshheightmap3.png)

- Done. 





