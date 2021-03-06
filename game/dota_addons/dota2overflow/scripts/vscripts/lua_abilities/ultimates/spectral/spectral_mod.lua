if spectral_form_mod == nil then
	spectral_form_mod = class({})
end

function spectral_form_mod:OnCreated( kv )	
	if IsServer() then
	end
end
 

function spectral_form_mod:OnDestroy()
	if IsServer() then
	end
end
 
function spectral_form_mod:DeclareFunctions()
	local funcs = {
MODIFIER_PROPERTY_EVASION_CONSTANT,
MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
MODIFIER_PROPERTY_OVERRIDE_ATTACK_MAGICAL,
MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
	}
	return funcs
end

function spectral_form_mod:GetModifierConstantHealthRegen() return self:GetAbility():GetSpecialValueFor("health_regen") end
function spectral_form_mod:GetModifierConstantManaRegen()   return self:GetAbility():GetSpecialValueFor("mana_regen") end

function spectral_form_mod:GetModifierEvasion_Constant()
		return self:GetAbility():GetSpecialValueFor("evasion")
end

function spectral_form_mod:GetModifierMagicalResistanceBonus()
	return self:GetAbility():GetSpecialValueFor("magic_weak")
end

function spectral_form_mod:GetOverrideAttackMagical()
	return 1
end

function spectral_form_mod:IsHidden()
	return false
end

function spectral_form_mod:IsPurgable() 
	return true
end

function spectral_form_mod:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE 
end

function spectral_form_mod:AllowIllusionDuplicate() 
	return true
end


function spectral_form_mod:GetEffectName()
	return "particles/items_fx/ghost.vpcf"
end
 
--------------------------------------------------------------------------------
 
function spectral_form_mod:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function spectral_form_mod:GetStatusEffectName()
	return "particles/status_fx/status_effect_ghost.vpcf"
end

--------------------------------------------------------------------------------

function spectral_form_mod:StatusEffectPriority()
	return 1005
end

--------------------------------------------------------------------------------

function spectral_form_mod:GetHeroEffectName()
	return "particles/units/heroes/hero_sven/sven_gods_strength_hero_effect.vpcf"
end

--------------------------------------------------------------------------------

function spectral_form_mod:HeroEffectPriority()
	return 105
end