if collapsing_armor == nil then
	collapsing_armor = class({})
end

LinkLuaModifier( "collapse_arm_mod", "lua_abilities/passives/collapsing_armor/p_mod.lua", LUA_MODIFIER_MOTION_NONE )

function collapsing_armor:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function collapsing_armor:GetIntrinsicModifierName() return "collapse_arm_mod" end