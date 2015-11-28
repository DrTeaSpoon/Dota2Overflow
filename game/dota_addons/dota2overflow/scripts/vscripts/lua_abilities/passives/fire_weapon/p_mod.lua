if fire_weapon_mod == nil then
	fire_weapon_mod = class({})
end

function fire_weapon_mod:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_ATTACK_LANDED
	}
 
	return funcs
end

function fire_weapon_mod:IsHidden()
	return true
end

function fire_weapon_mod:OnAttackLanded(keys)
	if IsServer() then
		local hAbility = self:GetAbility()
			if hAbility:GetLevel() < 1 then return end
		if keys.attacker == self:GetParent() then
			if keys.target:IsBuilding() or keys.target:IsMagicImmune() then return end
		local dmg = self:GetAbility():GetSpecialValueFor("bonus")
		if self:GetParent():IsIllusion() then dmg = math.ceil(dmg/2) end
			keys.target:AddNewModifier(self:GetCaster(), self:GetAbility(), "element_fire", { stacks = dmg })
			EmitSoundOnLocationWithCaster(keys.target:GetOrigin(),  "Hero_Phoenix.FireSpirits.Launch", keys.target) 
		end
	end
end