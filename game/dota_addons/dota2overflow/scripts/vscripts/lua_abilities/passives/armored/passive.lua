if armored == nil then
	armored = class({})
end

LinkLuaModifier( "armored_mod", "lua_abilities/passives/armored/p_mod.lua", LUA_MODIFIER_MOTION_NONE )

function armored:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function armored:GetIntrinsicModifierName() return "armored_mod" end