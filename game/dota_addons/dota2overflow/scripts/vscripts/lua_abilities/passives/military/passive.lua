if military == nil then
	military = class({})
end

LinkLuaModifier( "military_mod", "lua_abilities/passives/military/p_mod.lua", LUA_MODIFIER_MOTION_NONE )

function military:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function military:GetIntrinsicModifierName() return "military_mod" end

function military:OnHeroLevelUp() 
	self:GetCaster():ModifyGold( self:GetSpecialValueFor("gold") * self:GetCaster():GetLevel(), true, DOTA_ModifyGold_AbilityCost )
end