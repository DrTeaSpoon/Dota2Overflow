if hex_6_gon == nil then
	hex_6_gon = class({})
end

LinkLuaModifier( "hex_6_gon_effect_modifier", "lua_abilities/dev/effect_modifier.lua", LUA_MODIFIER_MOTION_NONE )

function hex_6_gon:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
	return behav
end

function hex_6_gon:GetManaCost()
	return self.BaseClass.GetManaCost( self, 1 )
end

function hex_6_gon:GetCooldown( nLevel )
	return self.BaseClass.GetCooldown( self, nLevel )
end

function hex_6_gon:OnSpellStart()
	local hCaster = self:GetCaster() --We will always have Caster.
	if not self:GetCursorTargetingNothing() then
		hTarget = self:GetCursorTarget()
	end
	local mod = "hex_6_gon_effect_modifier"
	if hTarget then
		local fDuration = self:GetSpecialValueFor("duration")
		local sModel = self:GetRandomModel()
		hTarget:AddNewModifier( hCaster, self, mod, {duration = fDuration, model = sModel} ) 
		local nFXIndex = ParticleManager:CreateParticle("particles/basic_projectile/basic_projectile_explosion.vpcf", PATTACH_WORLDORIGIN, nil )
		ParticleManager:SetParticleControl( nFXIndex, 0, hTarget:GetOrigin() )
		ParticleManager:SetParticleControl( nFXIndex, 3, hTarget:GetOrigin() )
		ParticleManager:ReleaseParticleIndex( nFXIndex )
		EmitSoundOnLocationWithCaster( hTarget:GetOrigin(), "Hero_Lion.Voodoo", self:GetCaster() )
		
	end
end

function hex_6_gon:GetRandomModel()
	local tModel_list = {
	"models/items/hex/fish_hex/fish_hex.vmdl"
	,"models/items/hex/sheep_hex/sheep_hex.vmdl"
	,"models/props_gameplay/pig.vmdl"
	,"models/props_gameplay/frog.vmdl"
	,"models/props_gameplay/chicken.vmdl"
	,"models/items/courier/billy_bounceback/billy_bounceback.vmdl"
	,"models/items/courier/echo_wisp/echo_wisp.vmdl"
	,"models/items/courier/itsy/itsy.vmdl"
	,"models/items/courier/nexon_turtle_01_grey/nexon_turtle_01_grey.vmdl"
	,"models/items/courier/tinkbot/tinkbot.vmdl"
	}
	local model = tModel_list[RandomInt(1,#tModel_list)]
	return model
end