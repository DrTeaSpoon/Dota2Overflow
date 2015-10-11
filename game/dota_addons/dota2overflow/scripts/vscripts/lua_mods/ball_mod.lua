if ball_mod == nil then
	ball_mod = class({})
end

function ball_mod:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_TAKEDAMAGE
	}
 
	return funcs
end

function ball_mod:CheckState()
	local state = {
	[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	[MODIFIER_STATE_MAGIC_IMMUNE] = true,
	[MODIFIER_STATE_FLYING] = true,
	[MODIFIER_STATE_ROOTED] = true
	
	}
	return state
end

function ball_mod:IsHidden()
	return true
end


function ball_mod:OnTakeDamage(keys)
	if IsServer() then
			if keys.attacker ~= self:GetParent() and keys.unit == self:GetParent() then
				local vFrom = keys.attacker:GetAbsOrigin()
				local vSelf = self:GetParent():GetAbsOrigin()
				local vDiff = vSelf - vFrom
				local vVelo = vDiff:Normalized() * (keys.damage * 10)
				self:GetParent():AddPhysicsVelocity(vVelo)
				--self:StartIntervalThink( 60 )
		end
	end
end

function ball_mod:GetEffectName()
return "particles/dark_smoke_test.vpcf"
end
 
--------------------------------------------------------------------------------
 
function ball_mod:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end