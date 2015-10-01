if generic_lua_stun == nil then
	generic_lua_stun = class({})
end

function generic_lua_stun:OnCreated( kv )	
	if IsServer() then
	end
end


function generic_lua_stun:IsDebuff()
	return true
end
 
--------------------------------------------------------------------------------
 
function generic_lua_stun:IsStunDebuff()
	return true
end
 
--------------------------------------------------------------------------------
 
function generic_lua_stun:GetEffectName()
	return "particles/generic_gameplay/generic_stunned.vpcf"
end
 
--------------------------------------------------------------------------------
 
function generic_lua_stun:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
 

function generic_lua_stun:DeclareFunctions()
	local funcs = {
MODIFIER_PROPERTY_OVERRIDE_ANIMATION 
	}
	return funcs
end

function generic_lua_stun:GetOverrideAnimation( )
	return ACT_DOTA_DISABLED
end

function generic_lua_stun:CheckState()
	local state = {
	[MODIFIER_STATE_STUNNED ] = true,
	}
	return state
end

function generic_lua_stun:IsHidden()
	return false
end
