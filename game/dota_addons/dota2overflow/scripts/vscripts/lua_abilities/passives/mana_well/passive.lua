if mana_well == nil then
	mana_well = class({})
end

LinkLuaModifier( "mana_well_mod", "lua_abilities/passives/mana_well/p_mod.lua", LUA_MODIFIER_MOTION_NONE )

function mana_well:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function mana_well:GetIntrinsicModifierName() return "mana_well_mod" end