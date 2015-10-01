if critical == nil then
	critical = class({})
end

LinkLuaModifier( "critical_mod", "lua_abilities/passives/critical/p_mod.lua", LUA_MODIFIER_MOTION_NONE )

function critical:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function critical:GetIntrinsicModifierName() return "critical_mod" end