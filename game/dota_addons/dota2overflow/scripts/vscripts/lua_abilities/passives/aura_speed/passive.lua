if aura_speed == nil then
	aura_speed = class({})
end

LinkLuaModifier( "aura_speed_mod", "lua_abilities/passives/aura_speed/p_mod.lua", LUA_MODIFIER_MOTION_NONE )

function aura_speed:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function aura_speed:GetIntrinsicModifierName() return "aura_speed_mod" end
