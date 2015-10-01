if nth_attack == nil then
	nth_attack = class({})
end


LinkLuaModifier( "nth_attack_modifier", "lua_abilities/moddota_help/nth_attack_passive.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "generic_lua_stun", "lua_abilities/moddota_help/generic_stun.lua", LUA_MODIFIER_MOTION_NONE )

function nth_attack:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function nth_attack:GetIntrinsicModifierName()
	return "nth_attack_modifier"
end

function nth_attack:OnUpgrade()
	if IsServer() then
	end
end
