if spell_resistance == nil then
	spell_resistance = class({})
end

LinkLuaModifier( "spell_resistance_mod", "lua_abilities/passives/spell_resistance/p_mod.lua", LUA_MODIFIER_MOTION_NONE )

function spell_resistance:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function spell_resistance:GetIntrinsicModifierName() return "spell_resistance_mod" end