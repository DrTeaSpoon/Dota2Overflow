if wield_flame == nil then
	wield_flame = class({})
end

LinkLuaModifier("element_fire", "lua_mods/element_fire", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("wield_flame_mod", "lua_abilities/basic_abilities/wield_flame/modifier.lua", LUA_MODIFIER_MOTION_NONE)

function wield_flame:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_MOVEMENT
	return behav
end

function wield_flame:OnSpellStart()

	EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "DOTA_Item.Armlet.Activate", self:GetCaster() )
	self:GetCaster():AddNewModifier( self:GetCaster(), self, "wield_flame_mod", { duration = self:GetSpecialValueFor("duration") , stack = 1 } )
end