if double_step == nil then
	double_step = class({})
end

LinkLuaModifier("double_step_modifier", "lua_abilities/basic_abilities/double_step/modifier.lua", LUA_MODIFIER_MOTION_NONE)

function double_step:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_MOVEMENT
	return behav
end

function double_step:OnSpellStart()

	EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "Hero_FacelessVoid.TimeWalk", self:GetCaster() )

	self:GetCaster():AddNewModifier( self:GetCaster(), self, "double_step_modifier", { duration = self:GetSpecialValueFor("duration") } )
end
--Hero_EarthShaker.Totem
--Hero_EarthShaker.Totem.Attack