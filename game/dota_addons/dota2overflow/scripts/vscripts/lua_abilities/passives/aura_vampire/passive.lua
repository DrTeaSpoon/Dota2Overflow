if aura_vampire == nil then
	aura_vampire = class({})
end

LinkLuaModifier( "aura_vampire_mod", "lua_abilities/passives/aura_vampire/p_mod.lua", LUA_MODIFIER_MOTION_NONE )

function aura_vampire:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function aura_vampire:GetIntrinsicModifierName() return "aura_vampire_mod" end
