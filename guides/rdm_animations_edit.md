# Editing .rdm models with animations

## along with solving the problem of disappearing objects.


This guide is intended for people who already know how to edit models and know what tools to use. If you're just getting started, check out the guides below first:

- Modelling in Blender for Anno 1800:
  
[https://github.com/anno-mods/modding-guide/tree/main/hier0nimus-tutorials/06-basics-modelling](https://github.com/anno-mods/modding-guide/tree/main/hier0nimus-tutorials/06-basics-modelling)
- Tutorial 4 - Making a new ship:
  
[https://github.com/anno-mods/modding-guide/tree/main/hier0nimus-tutorials/04-making-new-ship](https://github.com/anno-mods/modding-guide/tree/main/hier0nimus-tutorials/04-making-new-ship)
- Create .rdm Animations with Blender:
  
[https://github.com/anno-mods/modding-guide/blob/main/guides/rdm_animations.md](https://github.com/anno-mods/modding-guide/blob/main/guides/rdm_animations.md)


#### **Introduction**

If you have already dealt with editing models containing animations, then most likely you have encountered the symptom of invisible models or their parts in the game after using the rdm4 converter. The way to work around this problem is described in the second part of the guide and you can skip the first part, intended for people unfamiliar with editing such models.

If something is not clear about the editing steps described below, e.g. setting animation paths (sometimes it is necessary) - check out the guides mentioned above.


# PART I


### Editing models.

After loading the .cfg file with the model, you need to load the animations into it. Select the layer with the model that has them and load it using the "Load Animations" button:

![alt_text](rdm-edit/image20.png "image_tooltip")


If you are not sure which model it is, you can view the .cfg file to which some animations are assigned:


![alt_text](rdm-edit/image4.png "image_tooltip")


Once loaded (and the layers expanded), it should look something like this:


![alt_text](rdm-edit/image10.png "image_tooltip")


Theoretically, you could already edit the model and try to save it according to the "Create .rdm Animations with Blender" guide, but we may encounter some problems and inconveniences that do not make sense to write about here, so it will be best to just clean up so as not to have them later:



1. **Move the layers with animations (“armature”) outside the MAIN_FILE object:**



![alt_text](rdm-edit/image11.png "image_tooltip")


As you can see in the picture, there may be transformations of the model to its original version (size and orientation) and we now have 3 of the same models, but we don't care about it and we continue our work.



2. **Remove the whole MAIN_FILE:**


![alt_text](rdm-edit/image13.png "image_tooltip")




3. **Then remove one of the meshes with the model and the other move to the Scene Collection:**




![alt_text](rdm-edit/image18.png "image_tooltip")




4. **Set the "Armature" modifier to the object containing animations, i.e. "armature" (first on the list):**




![alt_text](rdm-edit/image14.png "image_tooltip")



![alt_text](rdm-edit/image16.png "image_tooltip")


Now you can go to edit the object and ...

... some time later:


![alt_text](rdm-edit/image1.png "image_tooltip")


In this example, we have a reduced wagon, and on the side, a list of how everything should look arranged - make sure that the idle animations with others (walk)  are not mixed up, use the spacebar to check if everything works correctly.

According to the art, we should now export everything (according to the "Create .rdm Animations with Blender" guide) and convert using rdm4-bin, but after loading the model into the game it will disappear (although there are exceptions) ... why?

and here we go to part 2 of this guide:


# PART II


### How to solve the problem of disappearing models with animations in the game after editing and converting them through rdm4.


## What's the problem?

As you can see on one of the first screenshots in part I of the guide, the correct structure of the animation after loading looks like this:




![alt_text](rdm-edit/image2.png "image_tooltip")


We have bones assigned to the Armature node (Armature.002). And the game reads such a structure for the models it uses. I'm not sure if it does it by name, or by index, or maybe it depends on the object. But the fact is that the rdm4 converter changes this structure by adding an additional parent bone (using the “Armature” node we have created in Blender), which in turn completely changes the bone node indexing:

nodes in blender before exporting:



![alt_text](rdm-edit/image7.png "image_tooltip")


nodes after converting by rdm4:




![alt_text](rdm-edit/image8.png "image_tooltip")



## **SOLUTION**


### Step 1


#### Bone structure modification in blender.

We have to choose one of the bones that is responsible for the main element of the model and make it a "parent" for the rest. In this case we select “SKN_root”:



before

![alt_text](rdm-edit/image6.png "image_tooltip")




after

![alt_text](rdm-edit/image12.png "image_tooltip")



Now we can export the file, but we must save it as a .GLTF file (not .GLB), remembering the following rules:



* select the layer with the model and the layer with animation (walk, do not select idle)
* remember to select “Tangents” and other options
* before export, we check if all layers with animations are correct as in the screen below




![alt_text](rdm-edit/image3.png "image_tooltip")




![alt_text](rdm-edit/image15.png "image_tooltip")


After saving, it is worth checking, e.g. in the 3D Windows browser, whether the model loads correctly and has animations (there should be, for example, two - idle and walk as Animation 1 and Animation 2)


### Step 2

Open the .glTF file for the model in a text editor. You can see something like this at the beginning:



![alt_text](rdm-edit/image9.png "image_tooltip")


We are interested in “scenes” and “nodes”.

"Nodes" is just a list of all the nodes in the structure and we need to manually change it here so that rdm4 doesn't consider the root node "Armature" to be a bone, but an actual bone - in our case we want it to be "SKN_root".

Therefore, to achieve this, you need to do two things:



* remove all data, including brackets {}, where “name”:“armature”.
* change the “nodes” indexes in the scenes, which are responsible for indicating the root nodes: in our case, “3” is responsible for “armature”, which will disappear and we replace it with “2” to point to “SKN_root” and we replace “4” with “3” because the “mesh” index moved up after removing “armature”

Effect after changes:




![alt_text](rdm-edit/image5.png "image_tooltip")


Now we save and can use rdm4-bin to convert the .gltf file to .rdm:




![alt_text](rdm-edit/image19.png "image_tooltip")


path>rdm4-bin.exe -g=P4h_N4b_G4b_B4b_T2h_I4b -i path/filename.gltf -sa --no_transform --force

and of course we replace the resulting files with their respective names




![alt_text](rdm-edit/image17.png "image_tooltip")



### A word of comment:

I don't know if the above steps are 100% effective for all models. Some, however, do not require this procedure. But so far it has helped everyone I've worked with, each model has its own specific bone arrangement and sometimes you have to experiment with different configurations.
#
ver 1.0
contact to author: JimDiGriz77

[https://discord.com/channels/578443209940926465](https://discord.com/channels/578443209940926465)

[https://www.nexusmods.com/users/40898860](https://www.nexusmods.com/users/40898860)
