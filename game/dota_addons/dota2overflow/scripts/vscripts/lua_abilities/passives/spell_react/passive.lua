if spell_react == nil then
	spell_react = class({})
end

LinkLuaModifier( "spell_react_mod", "lua_abilities/passives/spell_react/p_mod.lua", LUA_MODIFIER_MOTION_NONE )

function spell_react:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function spell_react:GetIntrinsicModifierName() return "spell_react_mod" end


function spell_react:GetCooldown( nLevel ) 
	return 10
end