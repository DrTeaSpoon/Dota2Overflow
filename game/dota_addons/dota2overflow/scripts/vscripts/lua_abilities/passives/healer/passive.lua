if healer == nil then
	healer = class({})
end

LinkLuaModifier( "healer_mod", "lua_abilities/passives/healer/p_mod.lua", LUA_MODIFIER_MOTION_NONE )

function healer:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function healer:GetIntrinsicModifierName() return "healer_mod" end