if multicast_dummy_kill_modifier == nil then
	multicast_dummy_kill_modifier = class({})
end


function multicast_dummy_kill_modifier:OnCreated( kv )	
	self:StartIntervalThink( 0.3 )
	--print("succesfully added the mod")
end

function multicast_dummy_kill_modifier:IsHidden()
	return true
end


function multicast_dummy_kill_modifier:GetAttributes() 
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function multicast_dummy_kill_modifier:OnIntervalThink()
	if IsServer() then
		local hCaster = self:GetAbility():GetCaster()
		local hTarget = self:GetParent()
		--print("multicast dummy think")
		if not hCaster:IsChanneling() then
			local hAbility = hTarget:GetAbilityByIndex(1)
			hAbility:EndChannel(false) 
			hTarget:Kill(nil, nil)
			--print("multicast kill")
		end
	end
end