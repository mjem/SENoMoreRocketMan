data:extend({
	  {
		 -- Allow all spaceship components at T1 science
        type = "bool-setting",
        name = "senomorerocketman-earlier-spaceships",
        -- setting_type = "runtime-global",
        setting_type = "startup",
        default_value = true,
		order = 1
	},
	{
	   -- reduce cost of rocket fuel and spaceship expansion
        type = "bool-setting",
        name = "senomorerocketman-cheaper-spaceships",
        setting_type = "startup",
        default_value = true,
		order = 1
	},
	-- {
	-- Manual patch
        -- type = "bool-setting",
        -- name = "senomorerocketman-improve-capsulse",
        -- setting_type = "startup",
        -- default_value = true,
		-- order = 1
	-- },
	-- {
	-- Manual patch
        -- type = "bool-setting",
        -- name = "senomorerocketman-cheaper-spaceship-takeoff",
        -- setting_type = "startup",
        -- default_value = true,
		-- order = 1
	-- },
	{
	   -- Remove cargo rockets
        type = "bool-setting",
        name = "senomorerocketman-remove-cargo-rockets",
        -- setting_type = "runtime-global",
        setting_type = "startup",
        default_value = true,
		order = 1
	},
	{
	   -- Remove delivery canons
        type = "bool-setting",
        name = "senomorerocketman-remove-delivery-canons",
        -- setting_type = "runtime-global",
        setting_type = "startup",
        default_value = true,
		order = 1
	},
	{
	   -- Enable space railways and elevator with T1 science
        type = "bool-setting",
        name = "senomorerocketman-earlier-space-railway",
        setting_type = "startup",
        default_value = true,
		order = 1
	},
	{
	   -- by the time we launch satellites everyone's tired of carrying things around mnaually
	   type = "bool-setting",
	   name = "senomorerocketman-earlier-logistics-system",
	   -- setting_type = "runtime-global",
	   setting_type = "startup",
	   default_value = true,
	   order = 1
	},
	{
	   -- lets get into orbit a bit quicker after launching satellites by dropping life support
	   -- cannister requirement from blue to red circuit
	   type = "bool-setting",
	   name = "senomorerocketman-earlier-life-support",
	   -- setting_type = "runtime-global",
	   setting_type = "startup",
	   default_value = true,
	   order = 1
	},

})
