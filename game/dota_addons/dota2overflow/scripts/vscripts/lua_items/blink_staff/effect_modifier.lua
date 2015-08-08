if item_blink_staff_effect_modifier == nil then
	item_blink_staff_effect_modifier = class({})
end

function item_blink_staff_effect_modifier:OnCreated( kv )	
	if IsServer() then
		if self:GetCaster() ~= self:GetParent() then
			local nFXIndex = ParticleManager:CreateParticle("particles/items_fx/armlet.vpcf", PATTACH_ROOTBONE_FOLLOW, self:GetParent())
			self:AddParticle( nFXIndex, false, false, -1, false, false )
		end
	end
end

function item_blink_staff_effect_modifier:GetAttributes() 
	return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function item_blink_staff_effect_modifier:IsHidden()
	if self:GetCaster() == self:GetParent() then
	return true
	else
	return false
	end
end