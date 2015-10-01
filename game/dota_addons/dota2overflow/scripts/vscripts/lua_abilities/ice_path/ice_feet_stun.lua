if aa_ice_feet_stun == nil then
	aa_ice_feet_stun = class({})
end

--function aa_ice_feet_stun:OnCreated( kv )	
--	if IsServer() then
--		if self:GetCaster() ~= self:GetParent() then
--			local nFXIndex = ParticleManager:CreateParticle("particles/items_fx/armlet.vpcf", PATTACH_ROOTBONE_FOLLOW, self:GetParent())
--			self:AddParticle( nFXIndex, false, false, -1, false, false )
--		end
--	end
--end

--function aa_ice_feet_stun:GetAttributes() 
--	return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
--end

function aa_ice_feet_stun:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE
	}
 
	return funcs
end
 
 
function aa_ice_feet_stun:CheckState()
	local state = {
	[MODIFIER_STATE_STUNNED] = true,
	}
 
	return state
end

function aa_ice_feet_stun:IsHidden()
--	if self:GetCaster() == self:GetParent() then
	return false
--	else
--	return false
--	end
end


function aa_ice_feet_stun:IsDebuff()
	return true
end
 
--------------------------------------------------------------------------------
 
function aa_ice_feet_stun:IsStunDebuff()
	return true
end
 
--------------------------------------------------------------------------------
 
function aa_ice_feet_stun:GetEffectName()
	return "particles/units/heroes/hero_ancient_apparition/ancient_apparition_cold_feet_frozen.vpcf"
end
 
--------------------------------------------------------------------------------
 
function aa_ice_feet_stun:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
 
--------------------------------------------------------------------------------
 
--------------------------------------------------------------------------------
 
function aa_ice_feet_stun:GetOverrideAnimation( params )
	return ACT_DOTA_DISABLED
end

function aa_ice_feet_stun:GetOverrideAnimationRate()
	return 0.0
end