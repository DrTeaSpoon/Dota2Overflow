if earthshaker_enchant_totem_lua == nil then
	earthshaker_enchant_totem_lua = class({})
end

LinkLuaModifier( "earthshaker_enchant_totem_lua_modifier", "heroes/hero_earthshaker/earthshaker_enchant_totem_modifier.lua", LUA_MODIFIER_MOTION_NONE )

function earthshaker_enchant_totem_lua:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_NO_TARGET
	return behav
end

function earthshaker_enchant_totem_lua:OnSpellStart()

	EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "Hero_EarthShaker.Totem", self:GetCaster() )

	self:GetCaster():AddNewModifier( self:GetCaster(), self, "earthshaker_enchant_totem_lua_modifier", { duration = self:GetDuration() } )
end
--Hero_EarthShaker.Totem
--Hero_EarthShaker.Totem.Attack