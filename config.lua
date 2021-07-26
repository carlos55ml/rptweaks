Config = {}

Config.PedFrequency = 1.0     -- Alters the ped and traffic frequency. Values MUST be between 1.0 and 0.0 (1.0 > x > 0.0)
Config.TrafficFrequency = 1.0 -- For example: 0.4 is valid but 1.6 or 5.0 is NOT valid. -- Leave both to 0.0 to disable all NPC.

Config.NoGangsAttack = true -- prevent gangs from attacking you.

Config.NoHeadshots = true -- prevents 1 shot headshot kill players.

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

Config.HideHUD = {
    Reticle = false,     -- hide reticle when aiming.
    WeaponStats = false, -- hide weapon stats when selecting gun.
    CarName = true,     -- hide car name and class in the bottom right corner. regular HUD scripts should do this as well.
    StreetName = true,  -- hide street name and area in the bottom right corner. Regular HUD scripts should do this as well.
}

Config.AlterWeaponDamage = false
Config.WpDmgMult = {        -- Individual damage multiplier for the most used weapons. Only works when "Config.AlterWeaponDamage = true"
    dagger          = 1.0,
    bat             = 1.0,
    bottle          = 1.0,
    crowbar         = 1.0,
    unarmed         = 1.0,
    flashlight      = 1.0,
    golfclub        = 1.0,
    hammer          = 1.0,
    hatchet         = 1.0,
    knuckle         = 1.0,
    knife           = 1.0,
    machete         = 1.0,
    switchblade     = 1.0,
    nightstick      = 1.0,
    wrench          = 1.0,
    battleaxe       = 1.0,
    poolcue         = 1.0,
    stonehatchet    = 1.0,

    pistol          = 1.0,
    combatpistol    = 1.0,
    appistol        = 1.0,
    pistol50        = 1.0,
    snspistol       = 1.0,
    heavypistol     = 1.0,
    vintagepistol   = 1.0,
    revolver        = 1.0,
    doubleaction    = 1.0,
    ceramicpistol   = 1.0,
    navyrevolver    = 1.0,

    microsmg        = 1.0,
    smg             = 1.0,
    assaultsmg      = 1.0,
    combatpdw       = 1.0,
    machinepistol   = 1.0,
    minismg         = 1.0,

    pumpshotgun     = 1.0,
    sawnoffshotgun  = 1.0,
    assaultshotgun  = 1.0,
    bullpupshotgun  = 1.0,
    musket          = 1.0,
    heavyshotgun    = 1.0,
    dbshotgun       = 1.0,
    autoshotgun     = 1.0,

    assaultrifle    = 1.0,
    carbinerifle    = 1.0,
    advancedrifle   = 1.0,
    specialcarbine  = 1.0,
    bullpuprifle    = 1.0,
    compactrifle    = 1.0,

    gusenberg       = 1.0,

    sniperrifle     = 1.0,
    heavysniper     = 1.0,
    marksmanrifle   = 1.0,
}