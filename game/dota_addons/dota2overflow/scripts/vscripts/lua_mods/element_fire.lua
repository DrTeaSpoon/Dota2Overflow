if element_fire == nil then
	element_fire = class({})
end

function element_fire:OnCreated( kv )	
	if IsServer() then
		self:SetStackCount(kv.stacks)
		self.nFXIndex = ParticleManager:CreateParticle( "particles/econ/generic/generic_buff_1/generic_buff_1.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
		ParticleManager:SetParticleControl( self.nFXIndex, 14, Vector( 1, 1, 1 ) )
		ParticleManager:SetParticleControl( self.nFXIndex, 15, Vector( 255, 50, 0 ) )
		self:AddParticle( self.nFXIndex, false, false, -1, false, false )
		self:StartIntervalThink(0.5)
	end
end

function element_fire:OnRefresh( kv )	
	if IsServer() then
		local stacks = self:GetStackCount() + kv.stacks
		if stacks > 100 then stacks = 100 end
		self:SetStackCount(stacks)
	end
end

function element_fire:GetTexture()
	return "element_fire"
end

function element_fire:OnIntervalThink()
	if IsServer() then
		local damageTable = {
			victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage = 2*self:GetStackCount(),
			damage_type = DAMAGE_TYPE_MAGICAL,
		}
		--print("Fire Damage: " .. 2*self:GetStackCount())
		local hAbility = self:GetAbility()
		if hAbility and hAbility.DamageReport then
		hAbility.DamageReport = hAbility.DamageReport + 2*self:GetStackCount()
		end
		ApplyDamage(damageTable)
		self:DecrementStackCount()
		local scale = math.ceil(self:GetStackCount()/4)
		ParticleManager:SetParticleControl( self.nFXIndex, 14, Vector( 1, 0.1*scale, 1 ) )
		if self:GetStackCount() > 0 then
			self:SetDuration( 0.5, true )
		else
			if hAbility and hAbility.DamageReport then
			print("Damage report: " .. hAbility.DamageReport)
			end
			self:Destroy()
		end
	end
end

function element_fire:IsHidden()
	return false
end

function element_fire:DestroyOnExpire()
	return false
end