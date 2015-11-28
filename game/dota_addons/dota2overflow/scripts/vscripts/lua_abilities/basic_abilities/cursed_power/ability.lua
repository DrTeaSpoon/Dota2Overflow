if cursed_power == nil then
	cursed_power = class({})
end

LinkLuaModifier("cursed_power_mod", "lua_abilities/basic_abilities/cursed_power/modifier.lua", LUA_MODIFIER_MOTION_NONE)

function cursed_power:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_MOVEMENT
	return behav
end

function cursed_power:OnSpellStart()

	EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "DOTA_Item.Armlet.Activate", self:GetCaster() )
	local mult = self:GetSpecialValueFor("curse")/100
	local health = self:GetCaster():GetHealth()
	local self_damage = {
		attacker = self:GetCaster(),
		damage = health * mult,
		damage_type = self:GetAbilityDamageType(),
		victim = self:GetCaster(),
		ability = self
	}
	ApplyDamage( self_damage )
	self:GetCaster():AddNewModifier( self:GetCaster(), self, "cursed_power_mod", { duration = self:GetSpecialValueFor("duration") , stack = 1 } )
end
--Hero_EarthShaker.Totem
--Hero_EarthShaker.Totem.Attack