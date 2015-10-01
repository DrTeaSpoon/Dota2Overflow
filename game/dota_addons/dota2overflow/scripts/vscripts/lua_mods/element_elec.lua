if element_elec == nil then
	element_elec = class({})
end

function element_elec:OnCreated( kv )	
	if IsServer() then
		self:SetStackCount(kv.stacks)
		self.nFXIndex = ParticleManager:CreateParticle( "particles/econ/generic/generic_buff_1/generic_buff_1.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
		ParticleManager:SetParticleControl( self.nFXIndex, 15, Vector( 255, 50, 0 ) )
		self:AddParticle( self.nFXIndex, false, false, -1, false, false )
	end
end

function element_elec:OnRefresh( kv )	
	if IsServer() then
		local stacks = self:GetStackCount() + kv.stacks
		if stacks > 100 then stacks = 100 end
		self:SetStackCount(stacks)
	end
end


function element_elec:OnIntervalThink()
	if IsServer() then
		local damageTable = {
			victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage = 3*self:GetStackCount(),
			damage_type = DAMAGE_TYPE_MAGICAL,
		}
		ApplyDamage(damageTable)
		self:DecrementStackCount()
		if self:GetStackCount() > 0 then
			self:SetDuration( 0.5, true )
		else
			self:Destroy()
		end
	end
end

function element_elec:IsHidden()
	return false
end

function element_elec:DestroyOnExpire()
	return false
end