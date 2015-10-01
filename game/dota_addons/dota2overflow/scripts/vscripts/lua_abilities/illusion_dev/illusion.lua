if illusion_lua == nil then
	illusion_lua = class({})
end

LinkLuaModifier( "illusion_lua_modifier", "lua_abilities/illusion_dev/illusion_lua_modifier.lua", LUA_MODIFIER_MOTION_NONE )

function illusion_lua:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
	return behav
end

function illusion_lua:OnSpellStart()
	local hCaster = self:GetCaster()
	local hTarget = false
	if not self:GetCursorTargetingNothing() then
		hTarget = self:GetCursorTarget()
	end
	if hTarget then
	hTarget:AddNewModifier( self:GetCaster(), self, "illusion_lua_modifier", { duration = 30 } )
	end
end