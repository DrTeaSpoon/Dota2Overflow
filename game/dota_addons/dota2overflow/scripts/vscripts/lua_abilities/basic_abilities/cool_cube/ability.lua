if cool_cube == nil then
	cool_cube = class({})
end

LinkLuaModifier( "generic_lua_stun", "lua_abilities/moddota_help/generic_stun.lua", LUA_MODIFIER_MOTION_NONE )
 function cool_cube:OnSpellStart()
	local hCaster = self:GetCaster()
	print("cube check call")
	self:CheckCube(self:GetCursorPosition() ,100,hCaster:GetForwardVector() )
	print("cube check call_end")
 end

 function cool_cube:GetBehavior() 
	 local behav = DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
	 return behav
 end
 
 function cool_cube:GetAOERadius()
	 return 100
 end
 
function cool_cube:CheckCube(vPoint,fSize,vDirection)
	local hCaster = self:GetCaster()
	local vStart = vPoint - vDirection * fSize
	local vEnd = vPoint + vDirection * fSize
	DebugDrawBoxDirection(vPoint, vStart, vEnd, vDirection, Vector(255,0,0), 1, 2) 
	DebugDrawCircle(vPoint, Vector(0,0,255), 1, fSize, false, 2 ) 
	
	DebugDrawLine(vStart,vEnd,255,255,255, false, 2) 
	
	local units = FindUnitsInLine( hCaster:GetTeamNumber(), vStart, vEnd , nil, fSize, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, FIND_ANY_ORDER  )
	print("cube check test")
	for k,v in pairs(units) do
		DebugDrawCircle(v:GetAbsOrigin(), Vector(0,255,0), 1, 50, false, 2 ) 
	end
end