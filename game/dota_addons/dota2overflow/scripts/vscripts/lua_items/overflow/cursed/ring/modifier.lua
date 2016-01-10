if item_cursed_ring_modifier == nil then
	item_cursed_ring_modifier = class({})
end

function item_cursed_ring_modifier:DeclareFunctions()
	local funcs = {
	MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
	MODIFIER_PROPERTY_STATS_INTELLECT_BONUS
	}
	return funcs
end

function item_cursed_ring_modifier:IsHidden()
	return true
end

function item_cursed_ring_modifier:OnCreated()
	if IsServer() then
		self:StartIntervalThink( 1 )
	end
end

function item_cursed_ring_modifier:GetAttributes() 
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_MULTIPLE
end

function item_cursed_ring_modifier:GetModifierBonusStats_Strength()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("all") + self:GetAbility():GetSpecialValueFor("str")
	end
end

function item_cursed_ring_modifier:GetModifierBonusStats_Agility()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("all") + self:GetAbility():GetSpecialValueFor("agi")
	end
end

function item_cursed_ring_modifier:GetModifierBonusStats_Intellect()
	if self:GetAbility() then
		return self:GetAbility():GetSpecialValueFor("all") + self:GetAbility():GetSpecialValueFor("int")
	end
end

function item_cursed_ring_modifier:OnIntervalThink()
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