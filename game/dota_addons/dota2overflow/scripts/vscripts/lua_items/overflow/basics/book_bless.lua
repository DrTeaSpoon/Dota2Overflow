if item_ovf_book_bless == nil then
	item_ovf_book_bless = class({})
end

LinkLuaModifier( "book_bless_modifier", "lua_items/overflow/basics/bless_book.lua", LUA_MODIFIER_MOTION_NONE )

function item_ovf_book_bless:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function item_ovf_book_bless:GetIntrinsicModifierName()
	return "book_bless_modifier"
end