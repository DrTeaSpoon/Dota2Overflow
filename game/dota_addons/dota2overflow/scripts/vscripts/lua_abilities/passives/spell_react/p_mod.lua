if spell_react_mod == nil then
	spell_react_mod = class({})
end

function spell_react_mod:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ABSORB_SPELL
	}
	return funcs
end

function spell_react_mod:IsHidden()
	return true
end

function spell_react_mod:GetAbsorbSpell(keys)
	local hAbility = self:GetAbility()
	if hAbility:IsCooldownReady() then
	self:Blink(self:GetParent(),RandomVector(500) + self:GetParent():GetAbsOrigin(),500,500)
	hAbility:StartCooldown(hAbility:GetCooldown(hAbility:GetLevel()))
	return 1
	end
	return false
end


function spell_react_mod:Blink(hTarget, vPoint, nMaxBlink, nClamp)
	local vOrigin = hTarget:GetAbsOrigin() --Our units's location
	ProjectileManager:ProjectileDodge(hTarget)  --We disjoint disjointable incoming projectiles.
	ParticleManager:CreateParticle("particles/items_fx/blink_dagger_start.vpcf", PATTACH_ABSORIGIN, hTarget) --Create particle effect at our caster.
	hTarget:EmitSound("DOTA_Item.BlinkDagger.Activate") --Emit sound for the blink
	local vDiff = vPoint - vOrigin --Difference between the points
	if vDiff:Length2D() > nMaxBlink then  --Check caster is over reaching.
		vPoint = vOrigin + (vPoint - vOrigin):Normalized() * nClamp -- Recalculation of the target point.
	end
	hTarget:SetAbsOrigin(vPoint) --We move the caster instantly to the location
	FindClearSpaceForUnit(hTarget, vPoint, false) --This makes sure our caster does not get stuck
	ParticleManager:CreateParticle("particles/items_fx/blink_dagger_end.vpcf", PATTACH_ABSORIGIN, hTarget) --Create particle effect at our caster.
end