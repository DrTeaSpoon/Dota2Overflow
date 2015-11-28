if shock_weapon == nil then
	shock_weapon = class({})
end

LinkLuaModifier( "shock_weapon_mod", "lua_abilities/passives/shock_weapon/p_mod.lua", LUA_MODIFIER_MOTION_NONE )

function shock_weapon:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function shock_weapon:GetIntrinsicModifierName() return "shock_weapon_mod" end