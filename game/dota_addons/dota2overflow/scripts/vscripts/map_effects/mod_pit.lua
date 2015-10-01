GameRules.PitModifier = "mod_pit_modifier"
--We can define GameRules.PitModifier in our game mode file
LinkLuaModifier( GameRules.PitModifier, "map_effects/mod_pit_effect.lua", LUA_MODIFIER_MOTION_NONE )
--You can have multiple modifiers defined in same file if you want to organize it that way.
function OnPitEnter(trigger)
    local ent = trigger.activator
	if not ent then return end
	if ent:IsAlive() then
		ent:AddNewModifier( ent, nil, GameRules.PitModifier, {} ) 
		--Fail safe if something changes the modifier added
		ent.TriggerModTemp = GameRules.PitModifier
	return
	end
end

function OnPitExit(trigger)
    local ent = trigger.activator
	if not ent then return end
	if ent:IsAlive() then
--Fail safe if something changes the modifier added and game would try to remove different modifier.
		if ent.TriggerModTemp then
			ent:RemoveModifierByName(ent.TriggerModTemp) 
			ent.TriggerModTemp = nil
		end
		return
	end
end
