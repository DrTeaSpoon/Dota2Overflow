LinkLuaModifier( "lava_map_ability_modifier", "map_effects/lava_hurt_mod.lua", LUA_MODIFIER_MOTION_NONE )

function OnLavaEnter(trigger)
    local ent = trigger.activator
	if not ent then return end
	if ent:IsAlive() then
	ent:AddNewModifier( ent, self, "lava_map_ability_modifier", {} )
		return
	end
end

function OnLavaExit(trigger)
    local ent = trigger.activator
	if not ent then return end
	if ent:IsAlive() then
	ent:RemoveModifierByName("lava_map_ability_modifier") 
		return
	end
end