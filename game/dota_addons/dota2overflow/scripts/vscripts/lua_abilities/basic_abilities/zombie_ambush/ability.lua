if zombie_ambush == nil then
	zombie_ambush = class({})
end

LinkLuaModifier("zombie_ambush_modifier", "lua_abilities/basic_abilities/zombie_ambush/modifier.lua", LUA_MODIFIER_MOTION_NONE)
function zombie_ambush:OnSpellStart()
	local hPoint = self:GetCursorPosition() 
	local hCaster = self:GetCaster()
	local particleName = "particles/units/heroes/hero_undying/undying_zombie_spawn.vpcf"
	--self.end_fx = ParticleManager:CreateParticle( particleName, PATTACH_ABSORIGIN, hCaster )
	--ParticleManager:SetParticleControl( self.end_fx, 0, self.point )
	EmitSoundOnLocationWithCaster(self:GetCursorPosition() , "Hero_Undying.Tombstone", hCaster)
	local z_dur = self:GetSpecialValueFor("duration")
	AddFOWViewer(self:GetCaster():GetTeam(), self:GetCursorPosition(), self:GetSpecialValueFor("radius")+40, z_dur, false) 
	--print("Dance!")
	local unit_name = "npc_dota_furion_treant"
	local center = hPoint
	local radius = self:GetSpecialValueFor("radius")
	local units = radius/20
	local count = units
	local fwdVec = hCaster:GetForwardVector()
	local b_damage = self:GetSpecialValueFor("zombie_damage")
	
	local v_x = 0
	local v_y = 0
	local v_len2 = v_x*v_x + v_y*v_y;
	if v_len2 > 0.001 then
		local v_len = math.sqrt( v_len2 )
		v_x = v_x / v_len
		v_y = v_y / v_len
	else
		v_x = 1
		v_y = 0
	end
	
	
	v_x = v_x * radius
	v_y = v_y * radius
	local point_list = {}
	local unit_list = {}
	local hUnit = false
	local prev_point = false
	PrecacheUnitByNameAsync(unit_name, function( )
		for i = 1, units do
			local theta = (math.pi * 2) * ( ( i - 1 ) / count )
			local p_x = math.cos( theta ) * v_x + math.sin( theta ) * v_y
			local p_y = -math.sin( theta ) * v_x + math.cos( theta ) * v_y
			local v = center + Vector( p_x, p_y, 0 )
			CreateTempTree(v, z_dur) 
			hUnit = CreateUnitByName(unit_name, v, false, hCaster, hCaster, hCaster:GetTeamNumber() ) 
			local abnum = hUnit:GetAbilityCount() -1
			for m = 0,abnum do 
				local ab = hUnit:GetAbilityByIndex(m)
				if ab then
				ab:SetLevel(ab:GetMaxLevel() )
				end
			end
			--
			local fxIndex = ParticleManager:CreateParticle( particleName, PATTACH_ABSORIGIN, hCaster )
			ParticleManager:SetParticleControl( fxIndex , 0, v )
			ParticleManager:ReleaseParticleIndex(fxIndex)
			--
			hUnit:SetForwardVector(hPoint-v)
			hUnit:AddNewModifier(hCaster, nil, "modifier_kill", {duration = z_dur})
			hUnit:AddNewModifier( hCaster, self, "zombie_ambush_modifier", { damage = b_damage} )
		end
	end
	,hCaster:GetOwner():GetPlayerID())
	
	
		Timers:CreateTimer(0.2, -- Start this timer 30 game-time seconds later
		function()
				local enemies = FindUnitsInRadius( hCaster:GetTeamNumber(), hPoint, nil, self:GetSpecialValueFor("radius")+50, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
				if #enemies > 0 then
					for _,enemy in pairs(enemies) do
						if enemy:GetName() ~= unit_name then
						FindClearSpaceForUnit(enemy, enemy:GetAbsOrigin(), true) 
						end
					end
				end
		end)
end

function zombie_ambush:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function zombie_ambush:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
	return behav
end