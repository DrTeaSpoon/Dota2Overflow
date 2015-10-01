if spell_block == nil then
	spell_block = class({})
end

LinkLuaModifier( "spell_block_mod", "lua_abilities/passives/spell_block/p_mod.lua", LUA_MODIFIER_MOTION_NONE )

function spell_block:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function spell_block:GetIntrinsicModifierName() return "spell_block_mod" end


function spell_block:GetCooldown( nLevel ) 
	return 10
end