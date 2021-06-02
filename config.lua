Config = {}

Config.PedFrequency = 1.0     -- Alters the ped and traffic frequency. Values MUST be between 1.0 and 0.0 (1.0 > x > 0.0)
Config.TrafficFrequency = 1.0 -- For example: 0.4 is valid but 1.6 or 5.0 is NOT valid. -- Leave both to 0.0 to disable all NPC.

Config.NoGangsAttack = true -- prevent gangs from attacking you.

Config.Populate = true -- Spawn NPCS and cars near players to prevent a ghost city. Only works when Config.PedDensity and Config.Traffic.Density > 0.0

Config.NoRandomNPCCops = true -- prevent NPC Police peds and car from spawning. Also prevents distant sirens sound from playing.

Config.Trains = true -- Freight Train and metro travelling around the city.

Config.NoPlaneTurbulence = true -- prevents plane turbulences while flying.

Config.SameHealthForMaleAndFemalesPeds = true -- sets both male and female health to 200 (100 in game).

Config.NoAutoHealthRegen = true -- disable auto health regen

Config.HideWeaponStats = true -- disable weapon stats in weapon wheel.

Config.ShowPlayerID = true -- Shows player ID on screen.
Config.PlayerID = { -- only works when "Config.ShowPlayerId = true"
    LocationX = 1.442,
    LocationY = 1.245,
    Width = 1.0,
    Height = 0.9,
    Scale = 0.40,
}