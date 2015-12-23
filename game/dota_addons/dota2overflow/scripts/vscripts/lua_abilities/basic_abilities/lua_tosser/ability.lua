if lua_tosser == nil then
	lua_tosser = class({})
end

LinkLuaModifier( "generic_lua_stun", "lua_abilities/moddota_help/generic_stun.lua", LUA_MODIFIER_MOTION_NONE )
 function lua_tosser:OnSpellStart()
	 self.point = self:GetCursorPosition() 
	 self.start_time = GameRules:GetGameTime()
	--enemy:AddNewModifier( self:GetCaster(), self, "generic_lua_stun", { duration = stun_dur , stacking = 1 } )
 end

 function lua_tosser:GetAOERadius()
	 return self:GetSpecialValueFor("radius")
 end

 function lua_tosser:GetBehavior() 
	 local behav = DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
	 return behav
 end