if metamorphosis == nil then
	metamorphosis = class({})
end

LinkLuaModifier( "generic_lua_stun", "lua_abilities/moddota_help/generic_stun.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "metamorphosis_mod", "lua_abilities/ultimates/metamorph/metamorphosis_mod.lua", LUA_MODIFIER_MOTION_NONE )

function metamorphosis:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_NO_TARGET
	return behav
end

function metamorphosis:OnSpellStart()
	EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "RoshanDT.Scream", self:GetCaster() )
	self:GetCaster():AddNewModifier( self:GetCaster(), self, "metamorphosis_mod", { duration = self:GetDuration() } )
end