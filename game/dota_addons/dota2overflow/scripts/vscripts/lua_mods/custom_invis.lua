if custom_invisibility_modifier == nil then
	custom_invisibility_modifier = class({})
end

function custom_invisibility_modifier:OnCreated( kv )	
	if IsServer() then
	end
end

function custom_invisibility_modifier:DeclareFunctions()
	local funcs = {
MODIFIER_EVENT_ON_ATTACK_LANDED,
MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
MODIFIER_EVENT_ON_ABILITY_EXECUTED
	}
	return funcs
end

function custom_invisibility_modifier:OnAbilityExecuted(params)
	if IsServer() then
		self:Destroy()
	end
end

function custom_invisibility_modifier:CheckState()
	local hAbility = self:GetAbility()
	local invis = false
	if self:GetElapsedTime() > hAbility:GetSpecialValueFor("fade_time") then invis = true end
	if IsServer() then
	if not GameRules:IsDaytime() then invis = true end
	end
	local state = {
	[MODIFIER_STATE_INVISIBLE] = invis
	}
	return state
end

function custom_invisibility_modifier:GetModifierInvisibilityLevel()
	return math.min(self:GetElapsedTime(),1.0)
end

function custom_invisibility_modifier:OnAttackLanded( params )
	if IsServer() then
		if params.attacker == self:GetParent() then
			self:Destroy()
		end
	end
end

function custom_invisibility_modifier:IsHidden()
	return false
end

function custom_invisibility_modifier:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE 
end

function custom_invisibility_modifier:AllowIllusionDuplicate() 
	return false
end
function custom_invisibility_modifier:IsPurgable() 
	return true
end

function custom_invisibility_modifier:GetEffectName()
	return "particles/items_fx/ghost.vpcf"
end
 
function custom_invisibility_modifier:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end





