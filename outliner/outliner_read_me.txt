Setup:
Bring the "outliner" folder into your project files, and add the "OutlineLayer" scene into your scene.
Make sure to go in the inspector for "OutlineCamera" and link it to your main camera.
On the main camera "Cull Mask" disable layer 2.

Changing Layers:
This is currently set to use layer 2. If you need to change this then change the "Cull Mask" on "OutlineCamera" and make sure the main camera cannot see the selected layer.
Make sure to add your target objects to outline to the proper layer as well.

Occluding:
Attach the "invisible_occluder.gd" to your object and it will now occlude outlines.

Settings:
To adjust settings, go to "OutlineLayer", then "OutlineDisplay", lastly in the inspector under the section "CanvasItem",
open "Material" and change "Shader Parameters" to allow for a different outline color, width, and transparency tolerance.
