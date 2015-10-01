if darkling_passive == nil then
	darkling_passive = class({})
end


LinkLuaModifier( "darkling_passive_mod", "monster/darkling/passive_mod.lua", LUA_MODIFIER_MOTION_NONE )

function darkling_passive:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function darkling_passive:GetIntrinsicModifierName()
	return "darkling_passive_mod"
end