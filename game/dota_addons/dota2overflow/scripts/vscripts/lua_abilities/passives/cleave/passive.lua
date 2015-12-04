
if cleave == nil then
	cleave = class({})
end

LinkLuaModifier( "cleave_mod", "lua_abilities/passives/cleave/p_mod.lua", LUA_MODIFIER_MOTION_NONE )

function cleave:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function cleave:GetIntrinsicModifierName() return "cleave_mod" end