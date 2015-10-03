if metamorphosis_mod == nil then
	metamorphosis_mod = class({})
end

function metamorphosis_mod:OnCreated( kv )	
	if IsServer() then
		self.nFXIndex = ParticleManager:CreateParticle( "particles/neutral_fx/roshan_spawn.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
		ParticleManager:SetParticleControl(self.nFXIndex, 0, self:GetCaster():GetOrigin()) 
		ParticleManager:ReleaseParticleIndex(self.nFXIndex)
		self.AttackBonus = (self:GetParent():GetAttackRange() - self:GetAbility():GetSpecialValueFor("attack_range")) * -1
		self.OriginalAtkCap = self:GetParent():GetAttackCapability() 
		self:GetParent():SetAttackCapability(DOTA_UNIT_CAP_MELEE_ATTACK) 
	end
end
 

function metamorphosis_mod:OnDestroy()
	if IsServer() then
		self:GetParent():SetAttackCapability(self.OriginalAtkCap) 
	end
end
 
function metamorphosis_mod:DeclareFunctions()
	local funcs = {
MODIFIER_PROPERTY_MODEL_CHANGE,
MODIFIER_PROPERTY_MODEL_SCALE,
MODIFIER_PROPERTY_MOVESPEED_BASE_OVERRIDE,
MODIFIER_PROPERTY_MOVESPEED_LIMIT,
MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
MODIFIER_EVENT_ON_ATTACK_LANDED
	}
	return funcs
end

function metamorphosis_mod:IsHidden()
	return false
end

function metamorphosis_mod:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE 
end

function metamorphosis_mod:AllowIllusionDuplicate() 
	return true
end

function metamorphosis_mod:OnAttackLanded( params )
	if IsServer() then
		if params.attacker == self:GetParent() then
			EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "Roshan.Attack", self:GetCaster() )
			if RandomInt(1, 100) < self:GetAbility():GetSpecialValueFor("stun_chance") then
				EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "Roshan.Bash", self:GetCaster() )
				params.target:AddNewModifier( self:GetCaster(), self:GetAbility(), "generic_lua_stun", { duration = self:GetAbility():GetSpecialValueFor("stun_duration") } )
			end
		end
	end
end
function metamorphosis_mod:GetModifierModelChange() return "models/creeps/roshan/roshan.vmdl" end
function metamorphosis_mod:GetModifierModelScale() return self:GetAbility():GetLevel()*0.5 end
function metamorphosis_mod:GetModifierMoveSpeedOverride() return self:GetAbility():GetSpecialValueFor("move_speed") end
function metamorphosis_mod:GetModifierMoveSpeedLimit() return self:GetAbility():GetSpecialValueFor("move_speed") end
function metamorphosis_mod:GetModifierAttackRangeBonus() return self.AttackBonus end
function metamorphosis_mod:GetModifierBaseAttack_BonusDamage() return self:GetAbility():GetSpecialValueFor("base_damage") end


