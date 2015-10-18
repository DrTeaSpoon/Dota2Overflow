if ult_burrow == nil then
	ult_burrow = class({})
end

LinkLuaModifier("ult_burrow_modifier", "lua_abilities/ultimates/burrow/modifier.lua", LUA_MODIFIER_MOTION_NONE)

function ult_burrow:GetCastAnimation()
	return ACT_DOTA_CAST_ABILITY_1
end

function ult_burrow:GetPlaybackRateOverride()
	return 0.5
end

function ult_burrow:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_NO_TARGET
	return behav
end

function ult_burrow:GetManaCost(iLevel)
	local cost = 150
	if iLevel < 1 or self:GetCaster():HasModifier("ult_burrow_modifier") then cost = 0 end
	return cost
end

function ult_burrow:GetManaCost(iLevel)
	local cost = 150
	if self:GetCaster():HasModifier("ult_burrow_modifier") then cost = 0 end
	return cost
end

function ult_burrow:OnSpellStart()

	if self:GetCaster():HasModifier("ult_burrow_modifier") then
	self:GetCaster():RemoveModifierByName("ult_burrow_modifier")
	EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "Hero_NyxAssassin.Burrow.Out", self:GetCaster() )
	self:GetCaster():NotifyWearablesOfModelChange(true)
	else
	self:GetCaster():AddNewModifier( self:GetCaster(), self, "ult_burrow_modifier", {} )
	EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "Hero_NyxAssassin.Burrow.In", self:GetCaster() )
	local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_nyx_assassin/nyx_assassin_burrow.vpcf", PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( nFXIndex, 0, self:GetCaster():GetAbsOrigin() )
	self:GetCaster():NotifyWearablesOfModelChange(false)
	self:EndCooldown()
	end
	self:MarkAbilityButtonDirty() 
end