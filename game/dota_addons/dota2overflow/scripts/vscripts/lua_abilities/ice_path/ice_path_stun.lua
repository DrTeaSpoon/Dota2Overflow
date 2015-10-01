if ice_path_stun == nil then
	ice_path_stun = class({})
end

--function ice_path_stun:OnCreated( kv )	
--	if IsServer() then
--		if self:GetCaster() ~= self:GetParent() then
--			local nFXIndex = ParticleManager:CreateParticle("particles/items_fx/armlet.vpcf", PATTACH_ROOTBONE_FOLLOW, self:GetParent())
--			self:AddParticle( nFXIndex, false, false, -1, false, false )
--		end
--	end
--end

--function ice_path_stun:GetAttributes() 
--	return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
--end

function ice_path_stun:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
		MODIFIER_PROPERTY_OVERRIDE_ANIMATION_RATE
	}
 
	return funcs
end
 
 
function ice_path_stun:CheckState()
	local state = {
	[MODIFIER_STATE_STUNNED] = true,
	}
 
	return state
end

function ice_path_stun:IsHidden()
--	if self:GetCaster() == self:GetParent() then
	return false
--	else
--	return false
--	end
end


function ice_path_stun:IsDebuff()
	return true
end
 
--------------------------------------------------------------------------------
 
function ice_path_stun:IsStunDebuff()
	return true
end
 
--------------------------------------------------------------------------------
 
function ice_path_stun:GetEffectName()
	return "particles/units/heroes/hero_jakiro/jakiro_icepath_debuff.vpcf"
end
 
--------------------------------------------------------------------------------
 
function ice_path_stun:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
 
--------------------------------------------------------------------------------
 
--------------------------------------------------------------------------------
 
function ice_path_stun:GetOverrideAnimation( params )
	return ACT_DOTA_DISABLED
end

function ice_path_stun:GetOverrideAnimationRate()
	return 0.0
end