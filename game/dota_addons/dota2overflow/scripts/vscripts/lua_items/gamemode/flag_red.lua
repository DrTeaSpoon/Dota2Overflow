if item_ctf_red == nil then
	item_ctf_red = class({})
end

LinkLuaModifier( "flag_red_mod", "lua_items/gamemode/flag_red_mod.lua", LUA_MODIFIER_MOTION_NONE )

function item_ctf_red:GetIntrinsicModifierName()
	return "flag_red_mod"
end

function item_ctf_red:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_ITEM + DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end

function item_ctf_red:OnOwnerDied()
	local hCaster = self:GetCaster()
	local vPoint = hCaster:GetAbsOrigin()
		if hCaster:GetTeam() == DOTA_TEAM_GOODGUYS then
			Notifications:TopToAll({text="Radiant Has Dropped The Flag!", duration=2.0})
		end
	hCaster:DropItemAtPositionImmediate(self, vPoint)
end