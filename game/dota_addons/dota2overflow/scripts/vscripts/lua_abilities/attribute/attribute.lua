if lua_attribute == nil then
	lua_attribute = class({})
end

LinkLuaModifier( "lua_attribute_modifier", "lua_abilities/attribute/attribute_modifier.lua", LUA_MODIFIER_MOTION_NONE )

function lua_attribute:GetIntrinsicModifierName()
	return "lua_attribute_modifier"
end


