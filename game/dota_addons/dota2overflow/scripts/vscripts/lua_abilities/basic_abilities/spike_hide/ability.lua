if spike_hide == nil then
	spike_hide = class({})
end

LinkLuaModifier( "spike_hide_mod", "lua_abilities/basic_abilities/spike_hide/modifier.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "generic_lua_stun", "lua_abilities/moddota_help/generic_stun.lua", LUA_MODIFIER_MOTION_NONE )

function spike_hide:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_NO_TARGET
	return behav
end

function spike_hide:OnSpellStart()

	EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "Hero_Disruptor.KineticField.End", self:GetCaster() )

	self:GetCaster():AddNewModifier( self:GetCaster(), self, "spike_hide_mod", { duration = self:GetSpecialValueFor("duration") } )
end