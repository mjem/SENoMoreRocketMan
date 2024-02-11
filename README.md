Space Exploration - No More Rocket Man
======================================

Summary
-------

Alter the Space Exploration mod to make spaceships cheaper and available sooner, plus other changes to encourage using 
spaceships and transport capsules for interplanetary transport instead of cargo rockets and delivery canons.

Changes
-------

Spaceships become available soon after reaching Nauvis orbit, and their launch costs are reduced making them a viable transport option from the start of the space age. Transport capsules are still for at least the first trip to Nauvis orbit.

For balance, and to further encourage use of spaceships, cargo rockets and delivery capsules are removed. I find spaceships are the most fun way of setting up interplanetary transport networks and dislike the way cargo rockets and delivery
capsules instantly teleport between surfaces, which loses the sense of scale that the Space Exploration mod excels at.

The mod also has options to make logistics, space trains and elevators and life support capsule canisters available 
 earlier than usual.

Manual changes
--------------

Some changes are not made automatically and require manual edits to the Space Exploration mod code.
They help to compensate for loss of cargo rockets.

### Setup

First, find the Space Exploration mod .zip file.
On Linux this will be `mods` underneath the directory where the game files were unpacked to.

Unzip the original mod using the command line `unzip <filename>` or by using Windows Explorer.

### Reduce fuel cost and eliminate cargo rocket section cost for launching personal transport capsules

Edit `scripts/capsule.lua` (around line 311) and change:

    return total_fuel_cost, sections_cost

to:

    return math.min(total_fuel_cost/10, 10000000000), 0

### Enable larger cargo capacity for transport capsules

Find `scripts/capsule.lua` and change the line (around line 16) from:

    Capsule.max_stacks = 200

to:

    Capsule.max_stacks = 2000

### Remove the display of rocket sections and cargo limits from the capsule GUI

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

    return energy_cost / 3

### Finishing up

You can run the game directly from the unzipped source files - the directory of individual files will take precedent over the original .zip file. Or if you prefer, re-compress the changed files and delete the directory of individual files.
