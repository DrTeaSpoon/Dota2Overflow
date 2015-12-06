if spike_hide_mod == nil then
	spike_hide_mod = class({})
end

function spike_hide_mod:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACKED
	}
 
	return funcs
end

function spike_hide_mod:IsHidden()
	return false
end
function spike_hide_mod:IsPurgable() 
	return true
end
function spike_hide_mod:GetEffectName()
	return "particles/spike_shield_rock.vpcf"
end
 
--------------------------------------------------------------------------------
 
function spike_hide_mod:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end


function spike_hide_mod:OnAttacked(keys)
	if IsServer() then
			if keys.attacker ~= self:GetParent() and keys.target == self:GetParent()  then
		local hAbility = self:GetAbility()
		local fStun = hAbility:GetSpecialValueFor( "stun" )
		local iDamage = (hAbility:GetSpecialValueFor( "damage_return" )/100) * self:GetParent():GetPrimaryStatValue()
			
			
				if keys.attacker ~= nil and ( not keys.attacker:IsMagicImmune() ) and ( not keys.attacker:IsInvulnerable() ) then
				if keys.attacker:IsBuilding() then return end
	EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "Hero_Leshrac.Lightning_Storm", self:GetCaster() )
		keys.attacker:AddNewModifier( self:GetCaster(), self:GetAbility(), "generic_lua_stun", { duration = fStun } )
		local armor = keys.attacker:GetPhysicalArmorValue()
		if armor < 1 then armor = 1 end
					local damage = {
						victim = keys.attacker,
						attacker = self:GetCaster(),
						damage = iDamage * armor,
						damage_type = hAbility:GetAbilityDamageType(),
						ability = self:GetAbility()
					}
					local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_zuus/zuus_static_field.vpcf", PATTACH_WORLDORIGIN, nil )
					ParticleManager:SetParticleControl( nFXIndex, 1, Vector( 1, 1, 1 ) )
					ParticleManager:SetParticleControl( nFXIndex, 0, keys.attacker:GetOrigin()+Vector(0,0,100) )
					ParticleManager:ReleaseParticleIndex( nFXIndex )
					local dmg = ApplyDamage( damage )
					local life_time = 2.0
					local digits = string.len( math.floor( dmg ) ) + 1
					local numParticle = ParticleManager:CreateParticle( "particles/msg_fx/msg_crit.vpcf", PATTACH_OVERHEAD_FOLLOW, keys.attacker )
					ParticleManager:SetParticleControl( numParticle, 1, Vector( 0, dmg, 4 ) )
					ParticleManager:SetParticleControl( numParticle, 2, Vector( life_time, digits, 0 ) )
					ParticleManager:SetParticleControl( numParticle, 3, Vector( 0, 150, 255 ) )
				end
			
			
			end
	end
end
