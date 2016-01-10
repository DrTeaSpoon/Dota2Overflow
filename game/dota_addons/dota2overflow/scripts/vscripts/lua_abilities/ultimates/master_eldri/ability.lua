if master_eldri == nil then
	master_eldri = class({})
end

LinkLuaModifier( "master_eldri_mod", "lua_abilities/ultimates/master_eldri/modifier.lua", LUA_MODIFIER_MOTION_NONE )

function master_eldri:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_NO_TARGET
	return behav
end

function master_eldri:OnSpellStart()
	local nElder = self:GetCaster():FindModifierByName("book_eldri_modifier"):GetStackCount()
	EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "Hero_Omniknight.GuardianAngel", self:GetCaster() )
	self:GetCaster():AddNewModifier( self:GetCaster(), self, "master_eldri_mod", { duration = self:GetSpecialValueFor("duration")*nElder, stacks= self:GetSpecialValueFor("stacks")})
end