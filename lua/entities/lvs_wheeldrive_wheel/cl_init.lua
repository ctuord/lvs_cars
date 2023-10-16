include("shared.lua")
include("cl_effects.lua")
include("cl_skidmarks.lua")

function ENT:Initialize()
	if not self:GetHideModel() then return end

	local Mins, Maxs = self:GetRenderBounds()

	self:SetRenderBounds( Mins, Maxs, Vector( 50, 50, 50 ) )

	self:DrawShadow( false )
end

function ENT:Draw()
	if self:GetHideModel() then return end

	--self:SetRenderOrigin( self:LocalToWorld( Vector(25,0,0) ) )
	self:SetRenderAngles( self:LocalToWorldAngles( self:GetAlignmentAngle() ) )
	self:DrawModel()
end

function ENT:DrawTranslucent()
	self:CalcWheelEffects()
end

function ENT:Think()
	self:CalcWheelSlip()

	self:SetNextClientThink( CurTime() + 0.1 )

	return true
end

function ENT:OnRemove()
	self:StopWheelEffects()
end

function ENT:CalcWheelSlip()
	local Base = self:GetBase()

	if not IsValid( Base ) then return end

	local Vel = self:GetVelocity()
	local VelLength = Vel:Length()

	local rpmTheoretical = self:VelToRPM( VelLength )
	local rpm = math.abs( self:GetRPM() )

	self._WheelSlip = math.max( rpm - rpmTheoretical - 80, 0 ) ^ 2 + math.max( math.abs( Base:VectorSplitNormal( self:GetForward(), Vel * 4 ) ) - VelLength, 0 )
	self._WheelSkid = VelLength + self._WheelSlip
end

function ENT:GetSlip()
	return (self._WheelSlip or 0)
end

function ENT:GetSkid()
	return (self._WheelSkid or 0)
end
