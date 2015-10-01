if multicast == nil then
	multicast = class({})
end

LinkLuaModifier( "multicast_spell_modifier", "lua_abilities/multicast/multicast_spell_modifier.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "multicast_dummy_kill_modifier", "lua_abilities/multicast/multicast_dummy_kill_modifier.lua", LUA_MODIFIER_MOTION_NONE )

function multicast:GetIntrinsicModifierName()
	return "multicast_spell_modifier"
end


