if aa_ice_feet == nil then
	aa_ice_feet = class({})
end

LinkLuaModifier( "aa_ice_feet_stun", "lua_abilities/AA/ice_feet_stun.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "aa_ice_feet_freezing", "lua_abilities/AA/ice_feet_freezing.lua", LUA_MODIFIER_MOTION_NONE )
function aa_ice_feet:GetCastAnimation()
	return ACT_DOTA_ATTACK
end

function aa_ice_feet:GetPlaybackRateOverride()
	return 2.0
end

function aa_ice_feet:OnSpellStart()
	local hCaster = self:GetCaster()
	local hTarget = self:GetCursorTarget()
	local nLevel = self:GetLevel()
	local fDuration = self:GetLevelSpecialValueFor("duration", nLevel)
	hTarget:AddNewModifier( hCaster, self, "aa_ice_feet_freezing", { duration = fDuration } )
end

