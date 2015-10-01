if swift == nil then
	swift = class({})
end

LinkLuaModifier( "swift_mod", "lua_abilities/passives/swift/p_mod.lua", LUA_MODIFIER_MOTION_NONE )

function swift:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function swift:GetIntrinsicModifierName() return "swift_mod" end