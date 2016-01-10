if master_eldri_mod == nil then
	master_eldri_mod = class({})
end

function master_eldri_mod:OnCreated( kv )	
	if IsServer() then
		self.nFXIndex = ParticleManager:CreateParticle( "particles/master_eldri.vpcf", PATTACH_POINT_FOLLOW, self:GetParent() )
		ParticleManager:SetParticleControlEnt(self.nFXIndex, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetParent():GetAbsOrigin(), true) 
		self:AddParticle( self.nFXIndex, false, false, -1, false, false )
	end
end
 
function master_eldri_mod:OnRefresh( kv )	
	if IsServer() then
		local hAbility = self:GetAbility()
		self:SetDuration(self:GetDuration()+kv.duration, true) 
	end
end

function master_eldri_mod:OnDestroy()
	if IsServer() then
	end
end
 
function master_eldri_mod:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST
	}
	return funcs
end

function master_eldri_mod:OnAbilityFullyCast(params)
	if IsServer() then
		if params.unit == self:GetParent() then
			if params.ability.IsRefreshable and not params.ability:IsRefreshable() then return end
			if params.ability ~= self:GetAbility() and  params.ability:GetAbilityName() ~= "item_refresher" and params.ability:GetAbilityName() ~= "item_hand_of_midas" and params.ability:GetAbilityName() ~= "item_ovf_book_eldri" and bit.band(DOTA_ABILITY_BEHAVIOR_AUTOCAST , params.ability:GetBehavior() ) ~= DOTA_ABILITY_BEHAVIOR_AUTOCAST and bit.band(DOTA_ABILITY_BEHAVIOR_TOGGLE , params.ability:GetBehavior() ) ~= DOTA_ABILITY_BEHAVIOR_TOGGLE then
				params.ability:EndCooldown()
				EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "Hero_Omniknight.GuardianAngel", self:GetCaster() )
			end
		end
	end
end

function master_eldri_mod:IsHidden()
	return false
end

function master_eldri_mod:IsPurgable() 
	return true
end

function master_eldri_mod:IsPurgeException()
	return true
end

function master_eldri_mod:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE 
end

function master_eldri_mod:AllowIllusionDuplicate() 
	return false
end
