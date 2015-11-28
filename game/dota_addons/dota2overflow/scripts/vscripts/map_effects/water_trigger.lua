LinkLuaModifier( "element_water", "lua_mods/element_water.lua", LUA_MODIFIER_MOTION_NONE )

function water_element_on(trigger)
    local ent = trigger.activator
    if not ent then return end
    if ent:IsAlive() then
    ent:AddNewModifier( ent, self, "element_water", {} )
        return
    end
end

function water_element_off(trigger)
    local ent = trigger.activator
    if not ent then return end
    if ent:IsAlive() then
    ent:RemoveModifierByName("element_water") 
        return
    end
end