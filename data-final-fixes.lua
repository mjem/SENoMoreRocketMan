--
--- Utility functions
--

-- Disable `tech` (sort of)
local function hide_tech(tech)
   -- data.raw.technology[tech].prerequisites = {"se-teleportation"}
   data.raw.technology[tech].hidden = true
end

-- Remove `ingredient` from `recipe`
-- Only works if the recipe was created using tuples for ingredients
-- if they are given are {name=xxx, amount=yyy} this function silently fails
local function remove_ingredient(recipe, ingredient)
   local new_ingredients = {}
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
   if mods["Krastorio2"] then
	  data.raw.technology["space-science-pack"].prerequisites = {
		 "kr-advanced-lab",
		 "se-space-decontamination-facility",
	  }
   else
	  data.raw.technology["space-science-pack"].prerequisites = {
		 "se-meteor-defence",
		 "se-space-decontamination-facility",
	  }
   end

   -- detach space assembling from delivery canon
   data.raw.technology["se-space-assembling"].prerequisites = {
	  "se-thruster-suit",
	  "advanced-electronics-2",
   }

   -- make spaceship automation (clamps) available with space science
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
		 {"se-astronomic-science-pack-1", 1},
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
-- Cheaper and earlier spaceship parts
--

if settings.startup["senomorerocketman-cheaper-spaceships"] then
   if mods["Krastorio2"] then
	  data.raw.technology["se-spaceship-integrity-1"].unit = {
		 count = 100,
		 ingredients = {
			{"automation-science-pack", 1},
			{"logistic-science-pack", 1},
			{"chemical-science-pack", 1},
			{"se-rocket-science-pack", 1},
			{"space-science-pack", 1},
			{"production-science-pack", 1},
			{"utility-science-pack", 1},
			{"kr-optimization-tech-card", 1},
			{"se-astronomic-science-pack-1", 1},
			{"se-material-science-pack-1", 1},
		 },
		 time = 60,
	  }
   else
	  data.raw.technology["se-spaceship-integrity-1"].unit = {
		 count = 100,
		 ingredients = {
			{"automation-science-pack", 1},
			{"logistic-science-pack", 1},
			{"chemical-science-pack", 1},
			{"se-rocket-science-pack", 1},
			{"space-science-pack", 1},
			{"utility-science-pack", 1},
			{"production-science-pack", 1},
			{"se-astronomic-science-pack-1", 1},
			{"se-material-science-pack-1", 1},
		 },
		 time = 60,
	  }
   end
   data.raw.recipe["se-liquid-rocket-fuel"].normal = {
      ingredients={
		 {name="rocket-fuel", amount=1}
      },
      results={
		 {name="se-liquid-rocket-fuel", type="fluid", amount=100}
	  }
    }
   -- data.raw.recipe["se-liquid-rocket-fuel"].expensive = {
      -- ingredients = {
		 -- { name = "rocket-fuel", amount = 2 },
      -- },
      -- results = {name = "se-liquid-rocket-fuel", type="fluid", amount=50}
    -- }
   -- data.raw.recipe["se-liquid-rocket-fuel"].ingredients = {
      -- { name = "rocket-fuel", amount = 2 },
   -- }
   -- data.raw.recipe["se-liquid-rocket-fuel"].results = {
      -- {name = "se-liquid-rocket-fuel", type="fluid", amount=100},
    -- }
end

--
--- Remove cargo rockets
--

if settings.startup["senomorerocketman-remove-cargo-rockets"].value == true then
   -- Hide the relevant techs
   hide_tech("se-rocket-launch-pad")
   hide_tech("se-rocket-landing-pad")
   hide_tech("se-rocket-cargo-safety-1")
   hide_tech("se-rocket-cargo-safety-2")
   hide_tech("se-rocket-cargo-safety-3")
   hide_tech("se-rocket-cargo-safety-4")
   hide_tech("se-rocket-reusability-1")
   hide_tech("se-rocket-reusability-2")
   hide_tech("se-rocket-reusability-3")
   hide_tech("se-rocket-reusability-4")
   hide_tech("se-rocket-survivability-1")
   hide_tech("se-rocket-survivability-2")
   hide_tech("se-rocket-survivability-3")
   hide_tech("se-rocket-survivability-4")
   -- We still need space probe rockets to collect asteroid belt probe data for astro 4 science
   remove_ingredient("se-space-probe-rocket", "se-cargo-rocket-section")
end

--
--- Remove delivery cannons
--

if settings.startup["senomorerocketman-remove-delivery-canons"].value == true then
   hide_tech("se-delivery-cannon")
   hide_tech("se-delivery-cannon-capsule-iridium")
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
--- Earlier space railways
--

if settings.startup["senomorerocketman-earlier-space-railway"] then
   -- Remove holmium cable tech prereq to space railways
   if mods["Krastorio2"] then
	  data.raw.technology["se-space-rail"].prerequisites = {
		 "kr-lithium-sulfur-battery",
	  }
   else
	  data.raw.technology["se-space-rail"].prerequisites = {
		 "se-space-hypercooling-1",
	  }
   end
   -- Remove energy science packs from space railway tech
   data.raw.technology["se-space-rail"].unit = {
	  count = 50,
	  ingredients = {
		 {"automation-science-pack", 1},
		 {"logistic-science-pack", 1},
		 {"chemical-science-pack", 1},
		 {"se-rocket-science-pack", 1},
		 {"space-science-pack", 1},
		 {"production-science-pack", 1},
		 {"utility-science-pack", 1},
	  },
	  time = 60,
   }
   -- Remove holmium cable from space train recipie
   -- (remove_ingredient needs adapting to the way these recipies are specified)
   -- remove_ingredient("se-space-rail", "se-holmium-cable")
   -- remove_ingredient("se-space-rail", "se-energy-catalogue-1")
   data.raw.recipe["se-space-rail"].ingredients = {
    { name = "rail", amount = 100},
    { name = "steel-plate", amount = 100},
   }
   -- Remove Astro 1 requirement from aeroframe pole, which is a prereq to space elevator tech...
   data.raw.technology["se-aeroframe-pole"].prerequisites = {
	  "se-space-astrometrics-laboratory",
   }
   -- ...and drop the Astro tech ingredient
   data.raw.technology["se-aeroframe-pole"].unit = {
	  count = 50,
	  ingredients = {
		 {"automation-science-pack", 1},
		 {"logistic-science-pack", 1},
		 {"chemical-science-pack", 1},
		 {"se-rocket-science-pack", 1},
		 {"space-science-pack", 1},
		 {"utility-science-pack", 1},
	  },
	  time = 60,
   }
   -- Remove all material science prereq from space elevator, leaving holmium and beryllium techs
   data.raw.technology["se-space-elevator"].prerequisites = {
	  "se-space-mechanical-laboratory",
	  "se-holmium-cable",
	  "se-aeroframe-pole"
   }
   -- Allow space elevator to be researched with the production + utility science
   data.raw.technology["se-space-elevator"].unit = {
	  count = 50,
	  ingredients = {
		 {"automation-science-pack", 1},
		 {"logistic-science-pack", 1},
		 {"chemical-science-pack", 1},
		 {"se-rocket-science-pack", 1},
		 {"space-science-pack", 1},
		 {"production-science-pack", 1},
		 {"utility-science-pack", 1},
	  },
	  time = 60,
   }
   -- Original construction of space elevator needs
   --  holmium cable - energy 1, holmium
   --  processing unit
   --  heavy girder
   --  heavy bearing
   --  aeroframe pole
   --  refined concrete
   -- To allow the elevator to be created and used earlier we:
   --  ease holmium cable by removing energy 1 as prerequisite
   --  remove heavy girder and heavy bearing as they need material 1 and 2
   --  add steel, big electric motors and low density structures to compensate
   data.raw.technology["se-holmium-cable"].unit = {
	  count = 20,
	  ingredients = {
		 {"automation-science-pack", 1},
		 {"logistic-science-pack", 1},
		 {"chemical-science-pack", 1},
		 {"se-rocket-science-pack", 1},
		 {"space-science-pack", 1},
		 {"production-science-pack", 1},
		 {"utility-science-pack", 1},
	  },
	  time = 60,
   }
   data.raw.technology["se-holmium-cable"].prerequisites = {
	  "se-space-hypercooling-1",
	  "se-space-radiation-laboratory",
	  "se-space-laser-laboratory",
   }
   data.raw.recipe["se-space-elevator"].ingredients = {
    { name = "se-holmium-cable", amount = 500},
    { name = "processing-unit", amount = 500},
    { name = "se-aeroframe-pole", amount = 2000},
    { name = "refined-concrete", amount = 1000},
    { name = "steel-plate", amount = 1000},
    { name = "electric-engine-unit", amount = 100},
    { name = "low-density-structure", amount = 500},
   }
   -- Original cable recipe needs
   --  holmium cable
   --  heavy girder
   --  aeroframe pole
   --  coal
   -- We remove heavy girder, add heat shielding and reduce aeroframe pole from 3 to 1
   data.raw.recipe["se-space-elevator-cable"].ingredients = {
    { name = "se-holmium-cable", amount = 1},
    { name = "se-aeroframe-pole", amount = 1},
    { name = "coal", amount = 2},
    { name = "se-heat-shielding", amount = 1},
   }
end

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

--
-- Earlier life support (get to orbit without blue circuits)
--

if settings.startup["senomorerocketman-earlier-life-support"] then
   data.raw.recipe["se-empty-lifesupport-canister"].ingredients = {
	  {"advanced-circuit", 1},
	  {"se-canister", 1},
   }
end
