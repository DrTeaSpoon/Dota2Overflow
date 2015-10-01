if modifer_abaddon_soul_rip_heal == nil then
	modifer_abaddon_soul_rip_heal = class({})
end

function modifer_abaddon_soul_rip_heal:OnCreated( kv )	
	if IsServer() then
		self.heal = kv.heal
		local hAbility = self:GetAbility()
		self.duration_time = hAbility:GetSpecialValueFor("heal_duration")
		self.thinkinterval = hAbility:GetSpecialValueFor("heal_interval")
		self.heal_fraction = self.heal / (self.duration_time/self.thinkinterval)
		--Lets run the first tick immidietly!
		self:OnIntervalThink()
		self:StartIntervalThink( self.thinkinterval )
		local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_witchdoctor/witchdoctor_voodoo_restoration_heal.vpcf", PATTACH_CUSTOMORIGIN, nil );
		ParticleManager:SetParticleControlEnt( nFXIndex, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetOrigin(), true );
		self:AddParticle(nFXIndex, false, false, 1, false, false) 
	end
end
 
function modifer_abaddon_soul_rip_heal:IsHidden()
	return false
end

function modifer_abaddon_soul_rip_heal:IsPurgable()
	return true
end

function modifer_abaddon_soul_rip_heal:GetAttributes() 
	return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE 
end
 
function modifer_abaddon_soul_rip_heal:OnIntervalThink()
	if IsServer() then
		self:GetParent():Heal(self.heal_fraction, self:GetAbility())
	end 
end