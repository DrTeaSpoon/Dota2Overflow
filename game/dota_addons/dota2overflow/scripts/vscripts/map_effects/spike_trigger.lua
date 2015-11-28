
LinkLuaModifier( "generic_lua_stun", "lua_abilities/moddota_help/generic_stun.lua", LUA_MODIFIER_MOTION_NONE )
function SpikeTrigger(trigger)
    local ent = trigger.activator
    if not ent then return end
    if ent:IsAlive() then
		
        return
    end
end
function SpikeTriggerDamage(trigger)
    local ent = trigger.activator
    if not ent then return end
    if ent:IsAlive() then
	
		local nLevel = ent:GetLevel()
		local nDur = 0.10*nLevel
		ent:AddNewModifier( ent, nil, "generic_lua_stun", { duration = nDur } )
		local nLevel = ent:GetLevel()
		local damageTable = {
			victim = ent,
			attacker = ent,
			damage = 150*nLevel,
			damage_type = DAMAGE_TYPE_PHYSICAL,
		}
		ApplyDamage(damageTable)
        return
    end
end
