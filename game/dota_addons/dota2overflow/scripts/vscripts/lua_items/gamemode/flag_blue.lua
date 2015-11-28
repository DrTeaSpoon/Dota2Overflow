if item_ctf_blue == nil then
	item_ctf_blue = class({})
end

LinkLuaModifier( "flag_blue_mod", "lua_items/gamemode/flag_blue_mod.lua", LUA_MODIFIER_MOTION_NONE )

function item_ctf_blue:GetIntrinsicModifierName()
	return "flag_blue_mod"
end

function item_ctf_blue:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_ITEM + DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function item_ctf_blue:OnOwnerDied()
	local hCaster = self:GetCaster()
	local vPoint = hCaster:GetAbsOrigin()
		if hCaster:GetTeam() == DOTA_TEAM_BADGUYS then
			Notifications:TopToAll({text="Dire Has Dropped The Flag!", duration=2.0})
		end
	hCaster:DropItemAtPositionImmediate(self, vPoint)
end