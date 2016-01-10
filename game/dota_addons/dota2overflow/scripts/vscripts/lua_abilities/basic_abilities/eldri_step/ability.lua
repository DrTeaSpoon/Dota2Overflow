if eldri_step == nil then
	eldri_step = class({})
end

LinkLuaModifier("eldri_step_modifier", "lua_abilities/basic_abilities/eldri_step/modifier.lua", LUA_MODIFIER_MOTION_NONE)

function eldri_step:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_MOVEMENT + DOTA_ABILITY_BEHAVIOR_IGNORE_CHANNEL
	return behav
end

function eldri_step:OnSpellStart()

	EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "Hero_FacelessVoid.TimeWalk", self:GetCaster() )
	EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "Hero_Omniknight.GuardianAngel", self:GetCaster() )

	self:GetCaster():AddNewModifier( self:GetCaster(), self, "eldri_step_modifier", { duration = self:GetSpecialValueFor("duration") } )
end
--Hero_EarthShaker.Totem
--Hero_EarthShaker.Totem.Attack