# Modding Infotips (tooltips)

You can mod the infotips this way:
https://github.com/jakobharder/anno1800-mod-loader/blob/main/doc/modloader11.md#patching-infotip-exportbin
You can extract the vanilla "data\infotips\export.bin" file with the FileDBReader (https://github.com/anno-mods/FileDBReader/releases) and the FileFormat "infotip.xml".
Alternatively I attached the extracted file in the modding discord channel here: https://discord.com/channels/578443209940926465/1146098268850376816/1149910673678159964


### Enums
The infotips use alot of numbers to express operations. We have to test and find out the meaning ourself. Here what we already found out (no guarantee that it is correct):
- CompareOperator:
0 Equals
1 Unequals
2 smaller than
3 smaller than or equal
4 bigger than or equal
5 bigger than


