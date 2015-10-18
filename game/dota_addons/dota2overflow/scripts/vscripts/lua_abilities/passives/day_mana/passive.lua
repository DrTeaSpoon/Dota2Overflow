if day_mana == nil then
	day_mana = class({})
end

LinkLuaModifier( "day_mana_mod", "lua_abilities/passives/day_mana/p_mod.lua", LUA_MODIFIER_MOTION_NONE )

function day_mana:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function day_mana:GetIntrinsicModifierName() return "day_mana_mod" end