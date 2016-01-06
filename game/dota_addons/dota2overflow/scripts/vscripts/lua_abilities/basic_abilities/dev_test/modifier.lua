if dev_test_modifier == nil then
    dev_test_modifier = class({})
end


function dev_test_modifier:GetAttributes()
    return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end


function dev_test_modifier:OnCreated(kv)
    if IsServer() then
		self.distance = kv.maxdistance or 925
		self.steal = kv.steal or 5
    end
end

function dev_test_modifier:IsPurgable()
    return false
end

function dev_test_modifier:DeclareFunctions()
    local funcs = {
	MODIFIER_EVENT_ON_DEATH
    }

    return funcs
end

function dev_test_modifier:OnDeath(kv)
    if IsServer() then
		if kv.unit:IsRealHero() and self:GetParent():IsRealHero() and kv.unit ~= self:GetParent() then
			if kv.unit:GetTeam() ~= self:GetParent():GetTeam() then
				if (self:GetParent():GetAbsOrigin() - kv.unit:GetAbsOrigin()):Length2D() <= self.distance or kv.attacker == self:GetParent() then
					local stolen = 0
					if kv.unit:GetBaseIntellect() > 1 then
						if kv.unit:GetBaseIntellect() > self.steal + 1 then
							kv.unit:SetBaseIntellect(kv.unit:GetBaseIntellect() - self.steal)
							stolen = self.steal
							kv.unit:CalculateStatBonus()
						else
							local old = kv.unit:GetBaseIntellect()
							kv.unit:SetBaseIntellect(1)
							local new = kv.unit:GetBaseIntellect()
							stolen = old - new
						end
					end
					self:GetParent():SetBaseIntellect(self:GetParent():GetBaseIntellect() + stolen)
					self:SetStackCount(self:GetStackCount() + stolen)
					self:GetParent():CalculateStatBonus()
					--particle
					local life_time = 2.0
					local digits = string.len( math.floor( stolen ) ) + 1
					local numParticle = ParticleManager:CreateParticle( "particles/msg_fx/msg_miss.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
					ParticleManager:SetParticleControl( numParticle, 1, Vector( 10, stolen, 0 ) )
					ParticleManager:SetParticleControl( numParticle, 2, Vector( life_time, digits, 0 ) )
					ParticleManager:SetParticleControl( numParticle, 3, Vector( 100, 100, 255 ) )
				end
			end
		end
	end
end
