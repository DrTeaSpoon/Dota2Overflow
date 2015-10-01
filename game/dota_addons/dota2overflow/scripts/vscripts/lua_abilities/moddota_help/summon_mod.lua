if suicide_mod == nil then
	suicide_mod = class({})
end

function suicide_mod:IsHidden()
	return true
end

function suicide_mod:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK,
	}
 
	return funcs
end

function suicide_mod:OnAttack( params )
	if IsServer() then
		if params.attacker == self:GetParent() then
			self:Explode()
		end
	end
 
	return 0
end

function suicide_mod:Explode()
		local dmg = self:GetAbility():GetSpecialValueFor("damage")
		local aoe = self:GetAbility():GetSpecialValueFor("radius")
		local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetOrigin(), self:GetParent(), aoe, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
		if #enemies > 0 then
			for _,enemy in pairs(enemies) do
				if enemy ~= nil and ( not enemy:IsMagicImmune() ) and ( not enemy:IsInvulnerable() ) then
					enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "element_fire", {
						stacks = dmg
					})
					local damageTable = {
						victim = enemy,
						attacker = self:GetParent(),
						damage = dmg*20,
						damage_type = DAMAGE_TYPE_MAGICAL,
					}
					ApplyDamage(damageTable)
				end
			end
		end
	local sSound = "Hero_Techies.Suicide"
	EmitSoundOnLocationWithCaster(self:GetParent():GetOrigin(), sSound, self:GetParent() )
	local particleName = "particles/units/heroes/hero_techies/techies_suicide.vpcf"
	local pfx = ParticleManager:CreateParticle( particleName, PATTACH_ABSORIGIN, self:GetParent() )
	ParticleManager:SetParticleControl( pfx, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( pfx, 2, Vector(aoe,0,0) )
	ParticleManager:ReleaseParticleIndex(pfx) 
	self:GetParent():Kill(self, self:GetParent())
end