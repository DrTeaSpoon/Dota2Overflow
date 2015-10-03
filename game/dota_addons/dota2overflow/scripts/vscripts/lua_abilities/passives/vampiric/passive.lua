if vampiric == nil then
	vampiric = class({})
end

LinkLuaModifier( "vampiric_mod", "lua_abilities/passives/vampiric/p_mod.lua", LUA_MODIFIER_MOTION_NONE )

function vampiric:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function vampiric:GetIntrinsicModifierName() return "vampiric_mod" end
