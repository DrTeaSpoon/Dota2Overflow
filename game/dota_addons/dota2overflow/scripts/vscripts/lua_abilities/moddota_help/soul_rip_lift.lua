if modifer_abaddon_soul_rip_lift == nil then
	modifer_abaddon_soul_rip_lift = class({})
end

function modifer_abaddon_soul_rip_lift:OnCreated( kv )	
	if IsServer() then
		local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_rubick/rubick_telekinesis.vpcf", PATTACH_CUSTOMORIGIN, nil );
		ParticleManager:SetParticleControlEnt( nFXIndex, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetOrigin(), true );
		ParticleManager:SetParticleControlEnt( nFXIndex, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetOrigin(), true );
		ParticleManager:SetParticleControl(nFXIndex, 2, Vector(kv.duration,0,0))
		self:AddParticle(nFXIndex, false, false, 1, false, false) 
	end
end
 
function modifer_abaddon_soul_rip_lift:GetStatusEffectName()
	return "particles/status_test/status_effect_ghost_test.vpcf"
end

function modifer_abaddon_soul_rip_lift:IsHidden()
	return false
end

function modifer_abaddon_soul_rip_lift:IsPurgable()
	return true
end

function modifer_abaddon_soul_rip_lift:DeclareFunctions()
	local funcs = {
	MODIFIER_PROPERTY_OVERRIDE_ANIMATION
	}
 
	return funcs
end

function modifer_abaddon_soul_rip_lift:CheckState()
	local state = {
	[MODIFIER_STATE_STUNNED] = true
	}
 
	return state
end

function modifer_abaddon_soul_rip_lift:GetOverrideAnimation( params )
	return ACT_DOTA_FLAIL
end