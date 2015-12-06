if dev_test == nil then
	dev_test = class({})
end

LinkLuaModifier("dev_test_modifier", "lua_abilities/basic_abilities/dev_test/modifier.lua", LUA_MODIFIER_MOTION_NONE)

function dev_test:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_DONT_CANCEL_MOVEMENT + DOTA_ABILITY_BEHAVIOR_TOGGLE
	return behav
end

function dev_test:OnToggle()

	if self:GetToggleState() then
		self.toggle_mod = self:GetCaster():AddNewModifier( self:GetCaster(), self, "dev_test_modifier", { } )
	else
		if self.toggle_mod then self.toggle_mod:Destroy() end
	end
end