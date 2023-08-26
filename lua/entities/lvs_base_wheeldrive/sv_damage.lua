
ENT.FireTrailScale = 0.35
ENT.DSArmorBulletPenetrationAdd = 50

DEFINE_BASECLASS( "lvs_base" )

function ENT:IsEngineStartAllowed()
	if hook.Run( "LVS.IsEngineStartAllowed", self ) == false then return false end

	if self:GetHP() <= self:GetMaxHP() * 0.25 then return false end

	if self:WaterLevel() > self.WaterLevelPreventStart then return false end

	local FuelTank = self:GetFuelTank()

	if IsValid( FuelTank ) and FuelTank:GetFuel() <= 0 then return false end

	return true
end

function ENT:OnTakeDamage( dmginfo )
	self.LastAttacker = dmginfo:GetAttacker() 
	self.LastInflictor = dmginfo:GetInflictor()

	BaseClass.OnTakeDamage( self, dmginfo )

	if self:GetEngineActive() and self:GetHP() <= self:GetMaxHP() * 0.25 then
		self:ShutDownEngine()

		net.Start( "lvs_car_break" )
			net.WriteEntity( self )
		net.Broadcast()
	end
end

function ENT:ShutDownEngine()
	if not self:GetEngineActive() then return end

	self:SetThrottle( 0 )
	self:StopEngine()
end

function ENT:TakeCollisionDamage( damage, attacker )
end

function ENT:Explode()
	if self.ExplodedAlready then return end

	self.ExplodedAlready = true

	local Driver = self:GetDriver()

	if IsValid( Driver ) then
		self:HurtPlayer( Driver, 1000, self.FinalAttacker, self.FinalInflictor )
	end

	if istable( self.pSeats ) then
		for _, pSeat in pairs( self.pSeats ) do
			if not IsValid( pSeat ) then continue end

			local psgr = pSeat:GetDriver()
			if not IsValid( psgr ) then continue end

			self:HurtPlayer( psgr, 1000, self.FinalAttacker, self.FinalInflictor )
		end
	end

	local ent = ents.Create( "lvs_destruction" )

	if IsValid( ent ) then
		ent:SetModel( self:GetModel() )
		ent:SetPos( self:GetPos() )
		ent:SetAngles( self:GetAngles() )
		ent.GibModels = self.GibModels
		ent.Vel = self:GetVelocity()
		ent:Spawn()
		ent:Activate()
		self:DeleteOnRemove( ent )
	end

	if self.DeleteOnExplode then

		self:Remove()

		return
	end

	self:RemoveWeapons()

	if self.MDL_DESTROYED then
		self:SetModel( self.MDL_DESTROYED )
		self:PhysicsDestroy()
		self:PhysicsInit( SOLID_VPHYSICS )
	else
		for id, group in pairs( self:GetBodyGroups() ) do
			for subid, subgroup in pairs( group.submodels ) do
				if subgroup == "" then
					self:SetBodygroup( id - 1, subid )
				end
			end
		end
	end

	for _, ent in pairs( self:GetCrosshairFilterEnts() ) do
		if not IsValid( ent ) or ent == self then continue end

		ent:Remove()
	end

	for _, ent in pairs( self:GetChildren() ) do
		ent:Remove()
	end

	self:StopMotionController()

	self.DoNotDuplicate = true

	self:OnExploded()
end

function ENT:RemoveWeapons()
	self:WeaponsFinish()

	for _, pod in pairs( self:GetPassengerSeats() ) do
		local weapon = pod:lvsGetWeapon()

		if not IsValid( weapon ) or not weapon._activeWeapon then continue end

		local CurWeapon = self.WEAPONS[ weapon:GetPodIndex() ][ weapon._activeWeapon ]

		if not CurWeapon then continue end

		if CurWeapon.FinishAttack then
			CurWeapon.FinishAttack( weapon )
		end
	end

	self:WeaponsOnRemove()

	table.Empty( self.WEAPONS )

	self.WEAPONS[1] = {}
end

function ENT:OnExploded()
	self:Ignite( 30 )

	local PhysObj = self:GetPhysicsObject()

	if not IsValid( PhysObj ) then return end

	PhysObj:SetVelocity( self:GetVelocity() + Vector(math.random(-5,5),math.random(-5,5),math.random(150,250)) )
end
