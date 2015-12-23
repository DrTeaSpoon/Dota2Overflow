modifier_meat_hook_followthrough = class({})

--------------------------------------------------------------------------------

function modifier_meat_hook_followthrough:IsHidden()
	return true
end


--------------------------------------------------------------------------------

function modifier_meat_hook_followthrough:CheckState()
	local state = {
	[MODIFIER_STATE_STUNNED] = true,
	}

	return state
end

--------------------------------------------------------------------------------
