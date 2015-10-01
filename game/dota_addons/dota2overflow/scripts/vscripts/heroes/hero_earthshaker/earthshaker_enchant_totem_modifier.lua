if earthshaker_enchant_totem_lua_modifier == nil then
	earthshaker_enchant_totem_lua_modifier = class({})
end

function earthshaker_enchant_totem_lua_modifier:OnCreated( kv )	
	if IsServer() then
		self.nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_earthshaker/earthshaker_totem_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
		local sHeroName = self:GetCaster():GetUnitName()
		local sAttachLock = "attach_attack1"
		if sHeroName == "npc_dota_hero_rubick" or sHeroName == "npc_dota_hero_earthshaker" then sAttachLock = "attach_totem" end
		ParticleManager:SetParticleControlEnt( self.nFXIndex, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, sAttachLock, self:GetCaster():GetOrigin(), true );
		self:AddParticle( self.nFXIndex, false, false, -1, false, false )
	end
end
 
--------------------------------------------------------------------------------
 
--function earthshaker_enchant_totem_lua_modifier:GetEffectName()
--	return "particles/units/heroes/hero_earthshaker/earthshaker_totem_buff.vpcf"
--end
-- 
----------------------------------------------------------------------------------
-- 
--function earthshaker_enchant_totem_lua_modifier:GetEffectAttachType()
--	return PATTACH_OVERHEAD_FOLLOW
--end
 

function earthshaker_enchant_totem_lua_modifier:DeclareFunctions()
	local funcs = {
MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
MODIFIER_EVENT_ON_ATTACK_LANDED
	}
	return funcs
end

function earthshaker_enchant_totem_lua_modifier:IsHidden()
	return false
end

function earthshaker_enchant_totem_lua_modifier:GetModifierBaseDamageOutgoing_Percentage()
	return 100
end

function earthshaker_enchant_totem_lua_modifier:OnAttackLanded( params )
	if IsServer() then
		if params.attacker == self:GetParent() then
	EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "Hero_EarthShaker.Totem.Attack", self:GetCaster() )
	self:Destroy()
		end
	end
end