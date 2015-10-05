if burner_mod == nil then
	burner_mod = class({})
end

function burner_mod:IsHidden()
	return true
end

function burner_mod:OnCreated()
	if IsServer() then
		self:StartIntervalThink( 1 )
	end
end

function burner_mod:OnIntervalThink()
	if IsServer() then
		if not self:GetParent():IsAlive() then return end
		local dmg = self:GetAbility():GetSpecialValueFor("damage")
		if self:GetParent():IsIllusion() then dmg = math.ceil(dmg/2) end
		local aoe = self:GetAbility():GetSpecialValueFor("radius")
		local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetOrigin(), self:GetParent(), aoe, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
		if #enemies > 0 then
			for _,enemy in pairs(enemies) do
				if enemy ~= nil and ( not enemy:IsMagicImmune() ) and ( not enemy:IsInvulnerable() ) then
					enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "element_fire", {
						stacks = dmg
					})
					--ApplyFireDamage( dmg )
				end
			end
		end
	end
end
