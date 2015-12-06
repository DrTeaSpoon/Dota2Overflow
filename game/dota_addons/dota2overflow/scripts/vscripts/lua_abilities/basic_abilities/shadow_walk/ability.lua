if shadow_walk == nil then
	shadow_walk = class({})
end

LinkLuaModifier("shadow_walk_modifier", "lua_abilities/basic_abilities/shadow_walk/modifier.lua", LUA_MODIFIER_MOTION_NONE)

function shadow_walk:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_MOVEMENT + DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL
	return behav
end

function shadow_walk:OnSpellStart()

	EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "Hero_Slark.ShadowDance", self:GetCaster() )

	self:GetCaster():AddNewModifier( self:GetCaster(), self, "shadow_walk_modifier", { duration = self:GetSpecialValueFor("duration") } )
end
--Hero_EarthShaker.Totem
--Hero_EarthShaker.Totem.Attack