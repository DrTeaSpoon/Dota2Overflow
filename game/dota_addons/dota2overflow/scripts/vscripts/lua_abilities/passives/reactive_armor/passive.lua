if reactive_armor == nil then
	reactive_armor = class({})
end

LinkLuaModifier( "react_arm_mod", "lua_abilities/passives/reactive_armor/p_mod.lua", LUA_MODIFIER_MOTION_NONE )

function reactive_armor:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function reactive_armor:GetIntrinsicModifierName() return "react_arm_mod" end