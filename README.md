Space Exploration - No More Rocket Man
======================================

Introduction
------------

This mod makes spaceships, logistics and personal transport capsules cheaper and available earlier when using the Space Exploration mod, and removes cargo rockets and cargo delivery cannons. I wrote it because spaceships are one of my favourite
mechanisms in Space Exploration, and using them to set up interplanetary networks is a fun and interesting challenge. But the
vanilla mod doesn't let players access them for a long time meaning most people use cargo rockets instead.

Also personal transport capsules are a nice and adventurous way to make your first explorations of the nearby planets and
this mod tries to make them more practical for the early space phase.

The logistics system is made available earlier because I feel playing with Space Exploration is too tedious
without it, encouraging either a lot of spaghetti factory designs or manual building items until too late in the game.

Manual changes
--------------

The following changes are recommended to make spaceships and personal transport capsules more useful and accessible. They have to be made manually by patching the Space Exploration mod source code.

### Setup

First, find the Space Exploration mod .zip file.
On Linux this will be `mods` underneath the directory where the game files were unpacked to.

Unzip the original mod using the command line `unzip <filename>` or Windows Explorer.

### Reduce fuel and cargo rocket sections cost for launching personal transport capsules

Edit `scripts/capsule.lua` (around line 311) and change:

    return total_fuel_cost, sections_cost

to:

    return math.min(Zone.get_launch_delta_v(current_zone)*Capsule.base_weight*3*Capsule.hop_fuel_cost_energy_coefficient,
        10000000000), 0

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
