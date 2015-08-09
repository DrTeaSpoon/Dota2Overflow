if item_multicast == nil then
	item_multicast = class({})
end

LinkLuaModifier( "item_multicast_spell_modifier", "lua_items/multicast/multicast_spell_modifier.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "item_multicast_dummy_kill_modifier", "lua_items/multicast/multicast_dummy_kill_modifier.lua", LUA_MODIFIER_MOTION_NONE )

function item_multicast:GetIntrinsicModifierName()
	return "item_multicast_spell_modifier"
end


