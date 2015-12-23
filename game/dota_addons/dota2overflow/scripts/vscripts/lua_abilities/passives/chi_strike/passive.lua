if chi_strike == nil then
	chi_strike = class({})
end

LinkLuaModifier( "chi_strike_mod", "lua_abilities/passives/chi_strike/p_mod.lua", LUA_MODIFIER_MOTION_NONE )

function chi_strike:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function chi_strike:GetIntrinsicModifierName() return "chi_strike_mod" end

function chi_strike:OnProjectileHit(hTarget, vLocation)
	if self.original_target and self.original_target == hTarget then
	return false
	end
	local cap = self:GetCaster():GetAttackCapability()
	local acq = self:GetCaster():GetAcquisitionRange()
	self:GetCaster():SetAttackCapability(DOTA_UNIT_CAP_MELEE_ATTACK)
	self:GetCaster():SetAcquisitionRange(99999)
	self:GetCaster():PerformAttack(hTarget, true, true, true, true,false) 
	self:GetCaster():SetAcquisitionRange(acq)
	self:GetCaster():SetAttackCapability(cap) 
	return false
end