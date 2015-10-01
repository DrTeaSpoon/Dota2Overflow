
if summon_basic == nil then
	summon_basic = class({})
end

LinkLuaModifier("element_fire", "lua_mods/element_fire", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("suicide_mod", "lua_abilities/moddota_help/summon_mod.lua", LUA_MODIFIER_MOTION_NONE)
function summon_basic:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_POINT
	return behav
end

function summon_basic:OnSpellStart()
	local sUnit = "npc_suicide_unit"
	local iNum = self:GetSpecialValueFor("units")
	local vPoint = self:GetCursorPosition()
	PrecacheUnitByNameAsync(sUnit,
	function()
	for i = 1 , iNum do
	local hUnit = CreateUnitByName(sUnit, vPoint, true, self:GetCaster():GetPlayerOwner(), self:GetCaster(), self:GetCaster():GetTeam() ) 
                hUnit:AddNewModifier(self:GetCaster(), self, "modifier_kill", {
                    duration = self:GetSpecialValueFor("duration")
                })
				hUnit:AddNewModifier(self:GetCaster(), self, "suicide_mod", {
                })
				hUnit:SetControllableByPlayer(self:GetCaster():GetPlayerOwnerID(), false)
				FindClearSpaceForUnit(hUnit, vPoint, true) 
	end
	end
	,
	self:GetCaster():GetPlayerOwnerID()
	
	
	)
end