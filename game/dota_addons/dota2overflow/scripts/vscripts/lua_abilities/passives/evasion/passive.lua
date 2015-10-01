if evasion == nil then
	evasion = class({})
end

LinkLuaModifier( "evasion_mod", "lua_abilities/passives/evasion/p_mod.lua", LUA_MODIFIER_MOTION_NONE )

function evasion:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function evasion:GetIntrinsicModifierName() return "evasion_mod" end