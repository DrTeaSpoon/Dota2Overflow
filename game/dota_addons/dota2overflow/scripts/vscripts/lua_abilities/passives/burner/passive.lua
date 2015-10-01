if burner == nil then
	burner = class({})
end

LinkLuaModifier("element_fire", "lua_mods/element_fire", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier( "burner_mod", "lua_abilities/passives/burner/p_mod.lua", LUA_MODIFIER_MOTION_NONE )

function burner:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function burner:GetIntrinsicModifierName() return "burner_mod" end