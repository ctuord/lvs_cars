AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
include("shared.lua")

function ENT:OnSpawn( PObj )
	PObj:SetMass( 1000 )
	PObj:EnableDrag( false )

	self:AddDriverSeat( Vector(-10,16,-1), Angle(0,-90,10) )
	self:AddPassengerSeat( Vector(0,-16,8), Angle(0,-90,20) )

	self:AddEngine( Vector(45,0,20) )

	local WheelModel = "models/diggercars/highwayman/wheel.mdl"
	local WheelRadius = 13

	local FrontAxle = self:DefineAxle( {
		Axle = {
			ForwardAngle = Angle(0,0,0),
			SteerType = LVS.WHEEL_STEER_FRONT,
			SteerAngle = 30,
			TorqueFactor = 0,
			BrakeFactor = 1,
		},
		Wheels = {
			self:AddWheel( Vector(59.1,32,10), Angle(0,180,0), WheelModel, WheelRadius ),
			self:AddWheel( Vector(59.1,-32,10), Angle(0,0,0), WheelModel, WheelRadius ),
		},
		Suspension = {
			Height = 10,
			MaxTravel = 7,
			ControlArmLength = 25,
			SpringConstant = 20000,
			SpringDamping = 2000,
			SpringRelativeDamping = 2000,
		},
	} )

	local RearAxle = self:DefineAxle( {
		Axle = {
			ForwardAngle = Angle(0,0,0),
			SteerType = LVS.WHEEL_STEER_NONE,
			TorqueFactor = 1,
			BrakeFactor = 1,
		},
		Wheels = {
			self:AddWheel( Vector(-59.5,32,8), Angle(0,180,0), WheelModel, WheelRadius ),
			self:AddWheel( Vector(-59.5,-32,8), Angle(0,0,0), WheelModel, WheelRadius ),
		},
		Suspension = {
			Height = 10,
			MaxTravel = 7,
			ControlArmLength = 25,
			SpringConstant = 20000,
			SpringDamping = 2000,
			SpringRelativeDamping = 2000,
		},
	} )
end

function ENT:OnEngineActiveChanged( Active )
	if Active then
		self:EmitSound( "lvs/vehicles/highwayman/carstart.wav" )
	else
		self:EmitSound( "lvs/vehicles/kuebelwagen/engine_stop.wav" )
	end
end