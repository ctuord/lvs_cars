
ENT.Base = "lvs_base_wheeldrive"

ENT.PrintName = "Mazda RX7"
ENT.Author = "Digger"
ENT.Information = "Luna's Vehicle Script"
ENT.Category = "[LVS] - Cars"

ENT.Spawnable			= true
ENT.AdminSpawnable		= false

ENT.MDL = "models/diggercars/mazda_rx7gsl/rx7.mdl"

ENT.MaxVelocity = 2600

ENT.EnginePower = 1800
ENT.EngineTorque = 100

ENT.TransGears = 4
ENT.TransGearsReverse = 1
ENT.TransMinGearHoldTime = 1
ENT.TransShiftSpeed = 0.3

ENT.EngineSounds = {
	{
		sound = "lvs/vehicles/dodge_charger/engine_00791.wav",
		Volume = 1,
		Pitch = 85,
		PitchMul = 25,
		SoundLevel = 75,
		SoundType = LVS.SOUNDTYPE_IDLE_ONLY,
	},
	{
		sound = "lvs/vehicles/dodge_charger/engine_02021.wav",
		Volume = 1,
		Pitch = 80,
		PitchMul = 90,
		SoundLevel = 75,
		SoundType = LVS.SOUNDTYPE_REV_UP,
		UseDoppler = true,
	},
	{
		sound = "lvs/vehicles/dodge_charger/engine_01835.wav",
		Volume = 1,
		Pitch = 80,
		PitchMul = 110,
		SoundLevel = 75,
		SoundType = LVS.SOUNDTYPE_REV_DOWN,
		UseDoppler = true,
	},
}

ENT.Lights = {
	{
		Trigger = "main",
		ProjectedTextures = {
			{ pos = Vector(87.29,-23.82,20.52), ang = Angle(0,0,0), colorB = 200, colorA = 150, shadows = true },
			{ pos = Vector(87.29,23.82,20.52), ang = Angle(0,0,0), colorB = 200, colorA = 150, shadows = true },
		},
	},
	{
		Trigger = "high",
		ProjectedTextures = {
			{ pos = Vector(87.29,23.82,20.52), ang = Angle(0,0,0), colorB = 200, colorA = 150, shadows = true },
			{ pos = Vector(87.29,-23.82,20.52), ang = Angle(0,0,0), colorB = 200, colorA = 150, shadows = true },
		},
	},
	{
	Trigger = "main+high",
		SubMaterialID = 12,
		Sprites = {
			{ pos = Vector(87.29,-23.82,20.52), colorB = 200, colorA = 150 },
			{ pos = Vector(87.29,23.82,20.52), colorB = 200, colorA = 150 },
		},
	},
	{
		Trigger = "main+brake",
		SubMaterialID = 19,
		Sprites = {
			{ pos = Vector(-79.17,-20.54,18.41), colorG = 0, colorB = 0, colorA = 150 },
			{ pos = Vector(-79.17,20.54,18.41), colorG = 0, colorB = 0, colorA = 150 },
		}
	},
	{
		Trigger = "reverse",
		SubMaterialID = 18,
		Sprites = {
			{ pos = Vector(-78.33,-13.46,17.54), height = 25, width = 25, colorA = 150 },
			{ pos = Vector(-78.33,13.46,17.54), height = 25, width = 25, colorA = 150 },
		}
	},
	{
		Trigger = "turnright",
		SubMaterialID = 17,
		Sprites = {
			{ width = 35, height = 35, pos = Vector(92.89,-26.83,11.49), colorG = 100, colorB = 0, colorA = 150 },
			{ width = 35, height = 35, pos = Vector(79.06,-33.63,12.19), colorG = 100, colorB = 0, colorA = 150 },
			{ width = 40, height = 40, pos = Vector(-68.56,-33.54,13.35), colorG = 100, colorB = 0, colorA = 150 },
			{ width = 40, height = 40, pos = Vector(-77.45,-29.64,18.06), colorG = 100, colorB = 0, colorA = 150 },
		},
	},
	{
		Trigger = "turnleft",
		SubMaterialID = 16,
		Sprites = {
			{ width = 35, height = 35, pos = Vector(92.89,26.83,11.49), colorG = 100, colorB = 0, colorA = 150 },
			{ width = 35, height = 35, pos = Vector(79.06,33.63,12.19), colorG = 100, colorB = 0, colorA = 150 },
			{ width = 40, height = 40, pos = Vector(-68.56,33.54,13.35), colorG = 100, colorB = 0, colorA = 150 },
			{ width = 40, height = 40, pos = Vector(-77.45,29.64,18.06), colorG = 100, colorB = 0, colorA = 150 },
		},
	},
}
