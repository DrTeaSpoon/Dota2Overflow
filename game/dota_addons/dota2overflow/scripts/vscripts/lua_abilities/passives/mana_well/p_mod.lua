if mana_well_mod == nil then
	mana_well_mod = class({})
end

function mana_well_mod:IsHidden()
	return true
end

function mana_well_mod:OnCreated()
	if IsServer() then
		self:StartIntervalThink( 1 )
	end
end

function mana_well_mod:OnIntervalThink()
	if IsServer() then
		local mana = self:GetAbility():GetSpecialValueFor("mana")
		local aoe = self:GetAbility():GetSpecialValueFor("radius")
		local allies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetOrigin(), self:GetParent(), aoe, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
		if #allies > 0 then
			for _,ally in pairs(allies) do
				if ally ~= nil then
					ally:GiveMana(mana)
				end
			end
		end
	end
end
