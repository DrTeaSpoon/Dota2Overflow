if purge_burn == nil then
	purge_burn = class({})
end

LinkLuaModifier("purge_burn_mod", "lua_abilities/basic_abilities/purge_burn/modifier.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("element_fire", "lua_mods/element_fire", LUA_MODIFIER_MOTION_NONE)

function purge_burn:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_MOVEMENT + DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL + DOTA_ABILITY_BEHAVIOR_UNRESTRICTED + DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE
	return behav
end

function purge_burn:OnSpellStart()
	self:GetCaster():AddNewModifier( self:GetCaster(), self, "purge_burn_mod", { duration = self:GetSpecialValueFor("duration") , stack = 1 } )
end