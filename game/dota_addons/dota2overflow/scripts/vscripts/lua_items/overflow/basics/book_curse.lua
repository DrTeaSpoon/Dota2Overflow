if item_ovf_book_curse == nil then
	item_ovf_book_curse = class({})
end

LinkLuaModifier( "book_curse_modifier", "lua_items/overflow/basics/curse_book.lua", LUA_MODIFIER_MOTION_NONE )

function item_ovf_book_curse:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function item_ovf_book_curse:GetIntrinsicModifierName()
	return "book_curse_modifier"
end