--
--- Utility functions
--

-- Disable `tech` as best we can
function hide_tech(tech)
   data.raw.technology[tech].prerequisites = {"se-teleportation"}
end

-- Remove `ingredient` from `recipe`
function remove_ingredient(recipe, ingredient)
   new_ingredients = {}
   for _, ingredient_amount in ipairs(data.raw.recipe[recipe].ingredients) do
	  if ingredient_amount[1] ~= ingredient then
		 table.insert(new_ingredients, ingredient_amount)
	  end
   end
   data.raw.recipe[recipe].ingredients = new_ingredients
end

--
--- Make spaceships available sooner
--

if settings.startup["senomorerocketman-earlier-spaceships"].value then
   -- make personal transport capsules avaliable with basic rocket science
   data.raw.technology["se-space-capsule-navigation"].prerequisites = {
	  "se-rocket-science-pack"
   }
   data.raw.technology["se-space-capsule-navigation"].unit = {
	  count = 100,
	  ingredients = {
		 {"automation-science-pack", 1},
		 {"logistic-science-pack", 1},
		 {"chemical-science-pack", 1},
		 {"se-rocket-science-pack", 1},
	  },
	  time = 30,
   }

   -- Enable capsule build and refurbishment in capsule navigation tech
   data.raw.technology["se-space-capsule-navigation"].effects = {
	  {type="unlock-recipe", recipe="se-space-capsule"},
	  {type="unlock-recipe", recipe="se-space-capsule-refurbish"},
   }

   -- make spaceships available after capsules with space science
   data.raw.technology["se-spaceship"].prerequisites = {
	  "se-space-capsule-navigation",
	  "space-science-pack"
   }
   data.raw.technology["se-spaceship"].unit = {
	  count = 300,
	  ingredients = {
		 {"automation-science-pack", 1},
		 {"logistic-science-pack", 1},
		 {"chemical-science-pack", 1},
		 {"se-rocket-science-pack", 1},
		 {"space-science-pack", 1},
	  },
	  time = 30,
   }

   -- make spaceship recipes buildable without aero* components
   remove_ingredient("se-spaceship-console", "se-aeroframe-pole")
   remove_ingredient("se-spaceship-console", "se-astronomic-catalogue-3")
   remove_ingredient("se-spaceship-floor", "se-aeroframe-bulkhead")
   remove_ingredient("se-spaceship-wall", "se-aeroframe-bulkhead")
   remove_ingredient("se-spaceship-gate", "se-aeroframe-bulkhead")
   remove_ingredient("se-spaceship-rocket-engine", "se-aeroframe-scaffold")
   remove_ingredient("se-spaceship-rocket-booster-tank", "se-aeroframe-scaffold")

   -- detach space science from cargo launcher (this bit needs krastorio 2)
   data.raw.technology["space-science-pack"].prerequisites = {
	  "kr-advanced-lab",
	  "se-space-decontamination-facility",
   }

   -- detech space assembling from delivery canon
   data.raw.technology["se-space-assembling"].prerequisites = {
	  "se-thruster-suit",
	  "advanced-electronics-2",
   }

   -- make spaceship automation (clamps) available with astro 1 science
   data.raw.technology["se-spaceship-clamps"].prerequisites = {
	  "se-spaceship",
	  "se-space-belt",
   }
   data.raw.technology["se-spaceship-clamps"].unit = {
	  count = 200,
	  ingredients = {
		 {"automation-science-pack", 1},
		 {"logistic-science-pack", 1},
		 {"chemical-science-pack", 1},
		 {"se-rocket-science-pack", 1},
		 {"space-science-pack", 1},
	  },
	  time = 15,
   }

   -- allow spaceship clamps to be made with simpler ingredients
   remove_ingredient("se-spaceship-clamp", "se-aeroframe-scaffold")
   remove_ingredient("se-spaceship-clamp", "se-heavy-girder")

   -- make ion drives available with energy science 1
   data.raw.technology["se-ion-engine"].prerequisites = {
	  "se-spaceship",
	  "se-energy-science-pack-1"
   }
   data.raw.technology["se-ion-engine"].unit = {
	  count = 300,
	  ingredients = {
		 {"automation-science-pack", 1},
		 {"logistic-science-pack", 1},
		 {"chemical-science-pack", 1},
		 {"se-rocket-science-pack", 1},
		 {"space-science-pack", 1},
		 {"se-energy-science-pack-1", 1},
	  },
	  time = 15,
   }

   -- make ion engines easier to build
   remove_ingredient("se-spaceship-ion-engine", "se-holmium-cable")
   remove_ingredient("se-spaceship-ion-engine", "se-holmium-solenoid")
   remove_ingredient("se-spaceship-ion-booster-tank", "se-holmium-cable")
   remove_ingredient("se-spaceship-ion-booster-tank", "se-holmium-solenoid")
   remove_ingredient("se-spaceship-ion-booster-tank", "se-beryllium-plate")

   -- get rid of the alt recipe for cargo rocket sections
   hide_tech("se-cargo-rocket-section-beryllium")

end

--
--- Remove cargo rockets
--

if settings.startup["senomorerocketman-remove-cargo-rockets"].value == true then
   hide_tech("se-rocket-launch-pad")
   hide_tech("se-rocket-landing-pad")
   hide_tech("se-rocket-cargo-safety-1")
   hide_tech("se-rocket-reusability-1")
   hide_tech("se-rocket-survivability-1")
end

--
--- Remove delivery cannons
--

if settings.startup["senomorerocketman-remove-delivery-canons"].value == true then
   hide_tech("se-delivery-cannon")
end

--
--- Buff personal transport capsules
--

-- if settings.startup["senomorerocketman-improve-capsulse"].value then
   -- local Capsule = remote.call("space-exploration", "Capsule")
   -- Capsule.get_launch_costs = function(current_zone, jump_zone, stacks)
	  -- game.print("getting launch costings")
	  -- return 10000000000,0
   -- end
-- end

--
--- Earlier logistics
--

if settings.startup["senomorerocketman-earlier-logistics-system"] then
      data.raw.technology["logistic-system"].prerequisites = {
	  "se-rocket-science-pack",
	  "logistic-robotics"
   }
   data.raw.technology["logistic-system"].unit = {
	  count = 250,
	  ingredients = {
		 {"automation-science-pack", 1},
		 {"logistic-science-pack", 1},
		 {"chemical-science-pack", 1},
		 {"se-rocket-science-pack", 1},
	  },
	  time = 30,
   }
end