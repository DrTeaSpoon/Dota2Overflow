if item_radiance_ovf_mod == nil then
	item_radiance_ovf_mod = class({})
end

function item_radiance_ovf_mod:DeclareFunctions()
	local funcs = {-
MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
	}
	return funcs
end

function item_radiance_ovf_mod:OnCreated()
	if IsServer() then
		self:StartIntervalThink( 1 )
	end
end

function item_radiance_ovf_mod:IsHidden()
	return true
end

function item_radiance_ovf_mod:GetAttributes() 
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_MULTIPLE
end

function item_radiance_ovf_mod:GetModifierPreAttack_BonusDamage()
	if self:GetAbility() then
	return self:GetAbility():GetSpecialValueFor("damage_bonus")
	else
	return 0
	end
end

function item_radiance_ovf_mod:OnIntervalThink()
	if IsServer() then
		if not self:GetParent():IsAlive() then return end
		local dmg = self:GetAbility():GetSpecialValueFor("fire_damage")
		if self:GetParent():IsIllusion() then dmg = math.ceil(dmg/2) end
		local aoe = self:GetAbility():GetSpecialValueFor("radius")
		local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetOrigin(), self:GetParent(), aoe, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
		if #enemies > 0 then
			for _,enemy in pairs(enemies) do
				if enemy ~= nil and ( not enemy:IsMagicImmune() ) and ( not enemy:IsInvulnerable() ) then
					enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "element_fire", {
						stacks = dmg
					})
				end
			end
		end
	end
end