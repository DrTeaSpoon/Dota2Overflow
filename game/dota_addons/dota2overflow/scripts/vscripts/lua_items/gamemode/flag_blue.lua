if item_ctf_red == nil then
	item_ctf_red = class({})
end

LinkLuaModifier( "flag_mod", "lua_items/gamemode/flag_mod.lua", LUA_MODIFIER_MOTION_NONE )

function item_ctf_red:GetIntrinsicModifierName()
	return "flag_mod"
end


