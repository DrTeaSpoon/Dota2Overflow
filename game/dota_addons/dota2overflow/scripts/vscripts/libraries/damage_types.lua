
		-- local damageTable = {
			-- victim = self:GetParent(),
			-- attacker = self:GetCaster(),
			-- damage = 2*self:GetStackCount(),
			-- damage_type = DAMAGE_TYPE_MAGICAL,
		-- }
		-- --print("Fire Damage: " .. 2*self:GetStackCount())

LinkLuaModifier("element_fire", "lua_mods/element_fire", LUA_MODIFIER_MOTION_NONE)
function ApplyDamageFire( info )
	local damage = info.damage
	local target = info.victim
	local attacker = info.attacker
	local source = info.source
        self:GetParent():AddNewModifier(attacker, source, "element_fire", {
            stacks = damage
        })
	return 
end

function ApplyDamageElectric( info )
	local damage = info.damage
	local target = info.victim
	local attacker = info.attacker
	local source = info.source
        self:GetParent():AddNewModifier(attacker, source, "element_fire", {
            stacks = damage
        })
	return 
end

function ApplyDamagePoison( info )
	local damage = info.damage
	local target = info.victim
	local attacker = info.attacker
	local source = info.source
        self:GetParent():AddNewModifier(attacker, source, "element_fire", {
            stacks = damage
        })
	return 
end

function ApplyDamageCold( info )
	local damage = info.damage
	local target = info.victim
	local attacker = info.attacker
	local source = info.source
        self:GetParent():AddNewModifier(attacker, source, "element_fire", {
            stacks = damage
        })
	return 
end