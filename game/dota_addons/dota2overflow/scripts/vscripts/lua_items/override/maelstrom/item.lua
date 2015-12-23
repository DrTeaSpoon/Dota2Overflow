if item_maelstrom_ovf == nil then
	item_maelstrom_ovf = class({})
end

LinkLuaModifier("element_fire", "lua_mods/element_fire", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier( "item_maelstrom_ovf_mod", "lua_items/override/maelstrom/modifier.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "item_maelstrom_ovf_orb", "lua_items/override/maelstrom/orb.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "item_maelstrom_ovf_guard", "lua_items/override/maelstrom/guard.lua", LUA_MODIFIER_MOTION_NONE )

function item_maelstrom_ovf:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function item_maelstrom_ovf:GetIntrinsicModifierName()
	return "item_maelstrom_ovf_mod"
end

function item_maelstrom_ovf:OnItemEquipped(hItem)
	self.Sound = "Hero_Zuus.ArcLightning.Cast"
	self.Effect = "particles/units/heroes/hero_zuus/zuus_arc_lightning.vpcf"
	self.MainMod = "zuus_arc_lightning_lua_modifier"
	self.ProtectMod = "zuus_arc_lightning_lua_protect"
end