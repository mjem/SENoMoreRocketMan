Space Exploration - No More Rocket Man
======================================

Introduction
------------

If you play the Factorio SEK2 (Space Exploration + Krastorio 2) and prefer spaceships to cargo rockets and delivery cannons, this mod is for you. It modifies the tech tree and recipes to make spaceships and personal transport capsules more useful and available much earlier in the game while removing cargo rockets and delivery cannons.

They just feel too much like teleporters and take away the interesting chellenges
of getting manual and automated transport routes working.

It requires Space Exploration and Krastorio 2 installed, optionally with Very BZ.

Changes
-------

The mod makes the following changes (each is optional):

- Personal transport capsules can be built after researching "Space capsule navigation" tech, available with only rocket science
- Spaceships (console, floor, wall, tank, booster) are with only basic space science and these  items can be constructed with simpler materials available on Nauvis
- Spaceship automation (clamp) technology is available with astro science 1 and clamps cheaper to manufacture
- Spaceship ion drive (fuel, tank, booster) available with only energy science level 1 and components cheaper to make
- Cargo rockets are removed
- Delivery cannons are removed

Manual changes
--------------

The following changes make transport capsules a useful early space age transport mechanism.
They have to be applied by editing files from the Space Exploration mod source code.

Transport capsules become a viable way to fly between Nauvis and nearby planets and are particularly useful for making initial batches of space science packs.

First, find the Space Exploration mod .zip file.
Note for the version of the mod currently in use and find your mods directory.
On Linux this will be ``mods`` underneath the directory where the game files were unpacked to.
On Windows this is normally c:///

Now unzip the files. On Linux run "unzip <filename>" or on Windows double click the archive and drag the
directory inside it into the ``mods`` directory.

Now edit the files. To remove the restriction on launch a capsule while carrying cargo, find ``scripts/capsule.lua`` and change the line (around line 16) from::

  Capsule.max_stacks = 200

to::

  Capsule.max_stacks = 2000

To eliminate the need for cargo rocket sections to travel by capsule, and to reduce the fuel cost of travelling, edit ``scripts/capsule.lua`` to change (around line 311)::

  return total_fuel_cost, sections_cost

to::

  return math.min(Zone.get_launch_delta_v(current_zone)*Capsule.base_weight*3*Capsule.hop_fuel_cost_energy_coefficient,
				  10000000000), 0

To remove the display of rocket sections and cargo limits in the capsule gui (optional), edit ``scripts/capsule-gui.lua`` and find the following lines around 83::

    -- Capacity
  local property_flow = subheader_frame.add{type="flow", direction="horizontal"}

Change to::

    -- Capacity
  local property_flow = subheader_frame.add{type="flow", direction="horizontal", visible=false}

And change::

  -- First stage
  property_flow = subheader_frame.add{type="flow", direction="horizontal"}

to::

  -- First stage
  property_flow = subheader_frame.add{type="flow", direction="horizontal", visible=false}

You can now run the game without making more changes - the directory of individual files will take precident over the original .zip file. Or if you prefer to have a single archive, re-compress the changed files and delete the directory.

Either way if you upgrade Space Exploration mod the changes above need to be re-applied


License and copyright
---------------------

Copyright 2023 Mike Elson. Released under the MIT license.
