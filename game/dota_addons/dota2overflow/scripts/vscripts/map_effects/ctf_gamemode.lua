

function red_trigger_in(trigger)
    local ent = trigger.activator
    if not ent then return end
    if ent:IsAlive() then
    ent:AddNewModifier( ent, self, "flag_goal_red_mod", {} )
        return
    end
end

function red_trigger_out(trigger)
    local ent = trigger.activator
    if not ent then return end
    if ent:IsAlive() then
    ent:RemoveModifierByName("flag_goal_red_mod") 
        return
    end
end

function blue_trigger_in(trigger)
    local ent = trigger.activator
    if not ent then return end
    if ent:IsAlive() then
    ent:AddNewModifier( ent, self, "flag_goal_blue_mod", {} )
        return
    end
end

function blue_trigger_out(trigger)
    local ent = trigger.activator
    if not ent then return end
    if ent:IsAlive() then
    ent:RemoveModifierByName("flag_goal_blue_mod") 
        return
    end
end