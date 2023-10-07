Space Exploration - No More Rocket Man
======================================

Introduction
------------

This mod makes playing using the Space Exploration mod faster paced by making spaceships and other techs
cheaper and available earlier. It is only for use with Space Exploration and Krastorio 2, optionally with the Very BZ mod too.

Spaceships in particular become usable soon after the player reaches Nauvis orbit, and their launch costs 
are reduced making them a viable transport option almost from the start of the space age.

Transport capsules, logistics, spaceship automation, space trains and other techs are available much sooner than normal in SE.

In addition, for some balance and to further encourage use of spaceships, cargo rockets and delivery capsules are removed. I find spaceships are the most fun way of setting up interplanetary transport networks and dislike the way cargo rockets and delivery 
capsules simply instantly teleport between surfaces, losing the sense of scale that the Space Exploration mod is capable of.

All the changes are optional and controlled via mod settings in the GUI, except the changes listed below which must be
made by manually patching the SE mod code.

Manual changes
--------------

The following changes to make spaceships and personal transport capsules cheaper to build and operate and more useful.

### Setup

First, find the Space Exploration mod .zip file.
On Linux this will be `mods` underneath the directory where the game files were unpacked to.

Unzip the original mod using the command line `unzip <filename>` or by using Windows Explorer.

### Reduce fuel and cargo rocket sections cost for launching personal transport capsules

Edit `scripts/capsule.lua` (around line 311) and change:

    return total_fuel_cost, sections_cost

to:

    return math.min(total_fuel_cost/10, 10000000000), 0

### Enable larger cargo capacity for transport capsules

Find `scripts/capsule.lua` and change the line (around line 16) from:

    Capsule.max_stacks = 200

to:

    Capsule.max_stacks = 2000

### Remove the display of rocket sections and cargo limits in the capsule gui

Edit `scripts/capsule-gui.lua` and find the following lines around 83:

    -- Capacity
    local property_flow = subheader_frame.add{type="flow", direction="horizontal"}

Change to:

    -- Capacity
    local property_flow = subheader_frame.add{type="flow", direction="horizontal", visible=false}

And change:

    -- First stage
    property_flow = subheader_frame.add{type="flow", direction="horizontal"}

to:

    -- First stage
    property_flow = subheader_frame.add{type="flow", direction="horizontal", visible=false}

### Reduce launch costs for spaceships

Edit ``scripts/spaceship.lua`` around line 378 at the end of function Spaceship.get_launch_energy_cost() from:

    return energy_cost

to:

    return energy_cost / 100

### Finishing up

You can run the game directly from the unzipped source files - the directory of individual files will take precedent over the original .zip file. Or if you prefer, re-compress the changed files and delete the directory of individual files.

### Diffs

The source code for this mod on gitlab includes `.patch` files for applying these changes.
