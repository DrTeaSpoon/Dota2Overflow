if earthshaker_fissure_lua == nil then
	earthshaker_fissure_lua = class({})
end

LinkLuaModifier( "earthshaker_fissure_lua_stun", "heroes/hero_earthshaker/earthshaker_fissure_stun.lua", LUA_MODIFIER_MOTION_NONE )

function earthshaker_fissure_lua:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING
	return behav
end

function earthshaker_fissure_lua:OnSpellStart()
	local hCaster = self:GetCaster()
	local vPoint = self:GetCursorPosition() 
	local nLenght = self:GetCastRange( self:GetCursorPosition(), nil)
	local vForward = self:GetCursorPosition() - hCaster:GetAbsOrigin()
	vForward = vForward:Normalized() 
	local nDuration	= self:GetSpecialValueFor( "fissure_duration" )
	local nRadius	= self:GetSpecialValueFor( "fissure_radius" )
	local vStartPos = hCaster:GetAbsOrigin()
	local vEndPos = vStartPos + vForward * nLenght
	EmitSoundOnLocationWithCaster(vEndPos, "Hero_EarthShaker.Fissure.Cast", hCaster )
	local particleName = "particles/units/heroes/hero_earthshaker/earthshaker_fissure.vpcf"
	local nFXIndex = ParticleManager:CreateParticle( particleName, PATTACH_ABSORIGIN, hCaster )
	print(nFXIndex)
	ParticleManager:SetParticleControl( nFXIndex, 0, vStartPos )
	ParticleManager:SetParticleControl( nFXIndex, 0, vStartPos )
	ParticleManager:SetParticleControl( nFXIndex, 1, vEndPos )
	ParticleManager:SetParticleControl( nFXIndex, 2, Vector( nDuration, 0, 0 ) )
	local hObs = Entities:CreateByClassname("point_simple_obstruction") 
	hObs:SetOrigin(vStartPos + Vector(0,0,0))
	DebugDrawCircle(hObs:GetAbsOrigin(), Vector(255,255,255), 1, 50, true, 5) 
	
	--hObs:SetSize( Vector( nRadius, nRadius, nRadius ), Vector( nRadius, nRadius, nRadius )) 
	hObs:SetEnabled(true, true)
	GameRules:GetGameModeEntity():ClientLoadGridNav()
end