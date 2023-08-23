include("shared.lua")
include("sh_turret.lua")
include("sh_tracks.lua")

function ENT:UpdatePoseParameters( steer, speed_kmh, engine_rpm, throttle, brake, handbrake, clutch, gear, temperature, fuel, oil, ammeter )
	self:CalcTurret()
end

function ENT:CalcViewOverride( ply, pos, angles, fov, pod )
	if ply == self:GetDriver() and not pod:GetThirdPersonMode() then
		local ID = self:LookupAttachment( "muzzle" )

		local Muzzle = self:GetAttachment( ID )

		if Muzzle then
			pos =  Muzzle.Pos - Muzzle.Ang:Up() * 130 - Muzzle.Ang:Forward() * 30
		end

	end

	return pos, angles, fov
end