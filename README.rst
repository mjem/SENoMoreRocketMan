Space Exploration - No More Rocket Man
======================================

Introduction
------------

This mod makes spaceships and personal transport capsules cheaper and available earlier when using the Space Exploration mod, and removes cargo rockets and cargo delivery cannons. It also moves the logistics system much higher up the tech tree so it's available sooner.

Why?
----

I feel that spaceships are one of the best mechanisms in Space Exploration - building and designing them, and setting up and automatinc interplanetary transport and logistics is in interesting and fun challenge. And personal transport capsules are a nice and adventourous way to make your first explorations of the nearby planets. Whereas cargo rockets and cargo delivery canons, with their fixed cargo sizes and instant transport speed, always felt both too magical and too restrictive. 

The Space Elevator is also a great part of the mod so I've moved it forward to SE players can enjoy it sooner.

Logistics system is just moved because in vanilla SE, I just feel it arrived much later than it should and you spend far too long making fringe recipes by hand.

Changes
-------

The mod makes the following changes (each is optional):

- Personal transport capsules have their own unique recipe to create them and are cheaper to make
- (see below) fuel costs reduced and rocket cargo section costs eliminated for capsules
- Basic spaceships are available much earlier and parts are cheaper to build without requiring interplanetary travel
- (see below) launch sots for spaceships are reduced
- Spaceship automation (clamp) technology is available earlier, shortly after reaching Nauvis orbit
- Spaceship ion drive (fuel, tank, booster) technology is available earlier
- Cargo rockets are removed
- Delivery cannons are removed
- Logistics system available with only rocket tech
- (Space elevator available earlier)

Manual changes
--------------

Setup
~~~~~

The following changes make transport capsules a useful early space age transport mechanism.
They have to be applied by editing files from the Space Exploration mod source code.

First, find the Space Exploration mod .zip file.
Note for the version of the mod currently in use and find your mods directory.
On Linux this will be ``mods`` underneath the directory where the game files were unpacked to.
On Windows this is normally c:///

Now unzip the files. On Linux run "unzip <filename>" or on Windows double click the archive and drag the
directory inside it into the ``mods`` directory.

Lower launch cost and grater capacity for transport capsules
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

1. Enable large cargo capacity on transport capsules

Find ``scripts/capsule.lua`` and change the line (around line 16) from::

  Capsule.max_stacks = 200

to::

  Capsule.max_stacks = 2000

2. Reduce fuel cost and eliminate cargo rocket sections cost
Edit ``scripts/capsule.lua`` to change (around line 311)::

  return total_fuel_cost, sections_cost

to::

  return math.min(Zone.get_launch_delta_v(current_zone)*Capsule.base_weight*3*Capsule.hop_fuel_cost_energy_coefficient,
				  10000000000), 0

3. Remove the display of rocket sections and cargo limits in the capsule gui.

Edit ``scripts/capsule-gui.lua`` and find the following lines around 83::

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

Lower launch costs for spaceships
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Edit ``scripts/spaceship.lua`` edit line 378 at the end of function Spaceship.get_launch_energy_cost()::

  return energy_cost

to::

  return energy_cost / 100

Done
~~~~

You can now run the game without making more changes - the directory of individual files will take precident over the original .zip file. Or if you prefer to have a single archive, re-compress the changed files and delete the directory.

Either way if you upgrade Space Exploration mod the changes above need to be re-applied


License and copyright
---------------------

Copyright 2023 Mike Elson. Released under the MIT license.
