if item_blessed_ring_modifier == nil then
	item_blessed_ring_modifier = class({})
end

function item_blessed_ring_modifier:DeclareFunctions()
	local funcs = {
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	MODIFIER_EVENT_ON_DEATH
	}
	return funcs
end

function item_blessed_ring_modifier:IsHidden()
	return true
end

function item_blessed_ring_modifier:GetAttributes() 
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_MULTIPLE
end

function item_blessed_ring_modifier:GetModifierBonusStats_Strength()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("all") + self:GetAbility():GetSpecialValueFor("str")
	end
end

function item_blessed_ring_modifier:GetModifierBonusStats_Agility()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("all") + self:GetAbility():GetSpecialValueFor("agi")
	end
end

function item_blessed_ring_modifier:GetModifierBonusStats_Intellect()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("all") + self:GetAbility():GetSpecialValueFor("int")
	end
end

function item_blessed_ring_modifier:OnDeath(kv)
    if IsServer() then
		if kv.unit:IsRealHero() and self:GetParent():IsRealHero() and kv.unit ~= self:GetParent() then
			if kv.unit:GetTeam() ~= self:GetParent():GetTeam() then
				if (self:GetParent():GetAbsOrigin() - kv.unit:GetAbsOrigin()):Length2D() <= self:GetAbility():GetSpecialValueFor("distance") or kv.attacker == self:GetParent() then
					local stat = RandomInt(0, 2)
					local color = Vector(255,255,255)
					if stat == 0 then
						self:GetParent():SetBaseStrength(self:GetParent():GetBaseStrength() + 1)
						color = Vector(255,100,100)
					elseif stat == 1 then
						self:GetParent():SetBaseAgility(self:GetParent():GetBaseAgility() + 1)
						color = Vector(100,255,100)
					elseif stat == 2 then
						self:GetParent():SetBaseIntellect(self:GetParent():GetBaseIntellect() + 1)
						color = Vector(100,100,255)
					end
					self:GetParent():CalculateStatBonus()
					--particle
					local life_time = 2.0
					local digits = 2
					local numParticle = ParticleManager:CreateParticle( "particles/msg_fx/msg_miss.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
					ParticleManager:SetParticleControl( numParticle, 1, Vector( 10, 1, 0 ) )
					ParticleManager:SetParticleControl( numParticle, 2, Vector( life_time, digits, 0 ) )
					ParticleManager:SetParticleControl( numParticle, 3, color )
				end
			end
		end
	end
end