if night_mana == nil then
	night_mana = class({})
end

LinkLuaModifier( "night_mana_mod", "lua_abilities/passives/night_mana/p_mod.lua", LUA_MODIFIER_MOTION_NONE )

function night_mana:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function night_mana:GetIntrinsicModifierName() return "night_mana_mod" end