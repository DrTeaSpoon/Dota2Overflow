if spectral_form == nil then
	spectral_form = class({})
end

LinkLuaModifier( "spectral_form_mod", "lua_abilities/ultimates/spectral/spectral_mod.lua", LUA_MODIFIER_MOTION_NONE )

function spectral_form:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_NO_TARGET
	return behav
end

function spectral_form:OnSpellStart()
	EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "n_creep_fellbeast.Death", self:GetCaster() )
	self:GetCaster():AddNewModifier( self:GetCaster(), self, "spectral_form_mod", { duration = self:GetDuration() } )
end