if multicast_spell_modifier == nil then
	multicast_spell_modifier = class({})
end

function multicast_spell_modifier:DeclareFunctions()
	local funcs = {
MODIFIER_EVENT_ON_ABILITY_EXECUTED,
	}
	return funcs
end

  
  
function multicast_spell_modifier:OnAbilityExecuted( params )
	if IsServer() then
		if params.unit == self:GetParent() then
			if self:GetParent():PassivesDisabled() then
				return 0
			end
			local hMulticast = self:GetAbility()
			local xIV = hMulticast:GetSpecialValueFor( "mult_x4" ) 
			local xIII = hMulticast:GetSpecialValueFor( "mult_x3" ) 
			local xII = hMulticast:GetSpecialValueFor( "mult_x2" ) 
			local hAbility = params.ability 
			if hAbility ~= nil and ( not hAbility:IsItem() or self:GetParent():HasScepter() ) and bit.band(DOTA_ABILITY_BEHAVIOR_AUTOCAST , hAbility:GetBehavior() ) ~= DOTA_ABILITY_BEHAVIOR_AUTOCAST and bit.band(DOTA_ABILITY_BEHAVIOR_TOGGLE , hAbility:GetBehavior() ) ~= DOTA_ABILITY_BEHAVIOR_TOGGLE then
				local dummy = "npc_multicast"
				if self:GetStackCount() < 1 then
					local MultCastRand = RandomInt(1,100)
					local num_mult = 0
					if MultCastRand < xIV then
						num_mult = 3
					elseif MultCastRand < xIII then
						num_mult = 2
					elseif MultCastRand < xII then
						num_mult = 1
					end
					if hAbility:IsItem() and (hAbility:GetCurrentCharges() > 0 or self:IsItemBanned(hAbility))then
						num_mult = 0
					end
					self:SetStackCount(num_mult)
					if num_mult > 0 then
						self:MulticastEffect( num_mult + 1 )
					end
				end
				
				local hCaster = self:GetParent()
				local delay = hMulticast:GetSpecialValueFor( "delay" ) 
				local radius = hMulticast:GetSpecialValueFor( "radius" ) 
				local playerID = hCaster:GetPlayerID()
				local vPoint = hCaster:GetCursorPosition()
				--DebugDrawCircle(vPoint, Vector(255,255,255), 1, radius, false, 2) 
				local hTarget = false
				local tTargets = false
				if not hAbility:GetCursorTargetingNothing() then
					hTarget = hAbility:GetCursorTarget()
				end
				local nFlag = hAbility:GetAbilityTargetFlags() or DOTA_UNIT_TARGET_FLAG_NONE
				local nTeam = hAbility:GetAbilityTargetTeam() or DOTA_UNIT_TARGET_TEAM_BOTH
				local nType = hAbility:GetAbilityTargetType() or DOTA_UNIT_TARGET_ALL
				if nTeam == DOTA_UNIT_TARGET_TEAM_CUSTOM then nTeam = DOTA_UNIT_TARGET_TEAM_BOTH end
				if nType == DOTA_UNIT_TARGET_CUSTOM  then nType = DOTA_UNIT_TARGET_ALL  end
                if hTarget then
				--FindUnitsInRadius(int teamNumber, Vector position, handle cacheUnit, float radius, int teamFilter, int typeFilter, int flagFilter, int order, bool canGrowCache) 
                    tTargets = FindUnitsInRadius(hCaster:GetTeam(),
                        hTarget:GetOrigin(),
                        nil,
                        radius,
                        nTeam,
                        nType,
                        nFlag,
                        FIND_ANY_ORDER,
                        false
                    )
					--print("found " .. #tTargets .. " units in range of " .. radius)
                end
					
				if  bit.band(DOTA_ABILITY_BEHAVIOR_CHANNELLED , hAbility:GetBehavior() ) == DOTA_ABILITY_BEHAVIOR_CHANNELLED then
				if not self.ChannelEnabled then self:SetStackCount(0) end
				while self:GetStackCount() > 0 do
					local multUnit = CreateUnitByName(dummy, hCaster:GetAbsOrigin(), true, hCaster, hCaster, hCaster:GetTeam()) 
					if not self.MultUnits then
					 self.MultUnits = {}
					end
					table.insert(self.MultUnits, multUnit)
					local sMAbName = hAbility:GetAbilityName()
                  multUnit:AddAbility(sMAbName)
                  local multAb = multUnit:FindAbilityByName(sMAbName)
                  if multAb then
                      multAb:SetLevel(hAbility:GetLevel())
					
					local sPrimAb = hAbility:GetAssociatedPrimaryAbilities()
					if sPrimAb then
						multUnit:AddAbility(sPrimAb)
						local hSAb = multUnit:FindAbilityByName(sPrimAb)
						if hSAb then
						hSAb:SetLevel(hAbility:GetLevel())
						end
					end
					
					local sSecoAb = hAbility:GetAssociatedSecondaryAbilities()
					if sSecoAb then
						multUnit:AddAbility(sSecoAb)
						local hSAb = multUnit:FindAbilityByName(sSecoAb)
						if hSAb then
						hSAb:SetLevel(hAbility:GetLevel())
						end
					end
					
                    local dummySpell = multUnit:FindAbilityByName('mult_dummy_unit')
                    if dummySpell then
                        dummySpell:SetLevel(1)
                    end
					multUnit:AddNewModifier(multUnit, self:GetAbility() , "multicast_dummy_kill_modifier", {})
					if hCaster:HasModifier('modifier_item_ultimate_scepter') then
                         multUnit:AddNewModifier(multUnit, nil, 'modifier_item_ultimate_scepter', {
							bonus_all_stats = 0,
							bonus_health = 0,
							bonus_mana = 0
                            })
                    end
					multUnit:AddNewModifier(multUnit, nil, 'modifier_invulnerable', {})
					local n = self:GetStackCount()
					if hTarget then
						local hTargetT = hTarget
						if tTargets[n] then
						 hTargetT = tTargets[n]
						--print("found " .. n)
						end
						
						Timers:CreateTimer({
							endTime = delay*n, -- when this timer should first execute, you can omit this if you want it to run first on the next frame
							callback = function()
								multUnit:SetCursorCastTarget(hTargetT)
								multAb:OnSpellStart()
							end
						})
					else
						local vRVec = RandomVector(RandomInt(1,radius))
						local vSpPoint = vPoint + vRVec
						--DebugDrawLine(vPoint, vSpPoint, 255, 255, 255, false, 1) 
						--DebugDrawCircle(vSpPoint, Vector(255,0,0), 1, 10, false, 2) 
						Timers:CreateTimer({
							endTime = delay*n, -- when this timer should first execute, you can omit this if you want it to run first on the next frame
							callback = function()
							multUnit:SetCursorPosition(vSpPoint) 
							multAb:OnSpellStart()
							end
						})
					end
					
					--print("multicast " .. n .. " done")
					self:DecrementStackCount() 
					else
					--print("multicast failed")
					self:DecrementStackCount() 
					end
				end
			else
				while self:GetStackCount() > 0 do
					local n = self:GetStackCount()
					if hTarget then
						local hTargetT = hTarget
						if tTargets[n] then
						 hTargetT = tTargets[n]
						--print("found " .. n)
						end
						Timers:CreateTimer({
							endTime = delay*n, -- when this timer should first execute, you can omit this if you want it to run first on the next frame
							callback = function()
								hCaster:SetCursorCastTarget(hTargetT)
								if hAbility then
								hAbility:OnSpellStart()
								end
							end
						})
					else
						local vRVec = RandomVector(RandomInt(1,radius))
						local vSpPoint = vPoint - vRVec
						
						--DebugDrawCircle(vSpPoint, Vector(255,0,0), 1, 10, false, 2) 
						Timers:CreateTimer({
							endTime = delay*n, -- when this timer should first execute, you can omit this if you want it to run first on the next frame
							callback = function()
								hCaster:SetCursorPosition(vSpPoint) 
								
								if hAbility then
								hAbility:OnSpellStart()
								end
							end
						})
					end
					--print("multicast " .. n .. " done")
					self:DecrementStackCount() 
				end
			end
			end
		end
	end
 
	return 0
end

function multicast_spell_modifier:OnCreated( kv )	
	self.ChannelEnabled = true
end

function multicast_spell_modifier:IsHidden()
	return true
end

function multicast_spell_modifier:MulticastEffect( nMult )
	if IsServer() then
		local hCaster = self:GetParent()
		local prt = ParticleManager:CreateParticle('particles/multicast_item/multicast.vpcf', PATTACH_OVERHEAD_FOLLOW, hCaster)
		ParticleManager:SetParticleControl(prt, 3, Vector(90, 0, 0))
		ParticleManager:SetParticleControl(prt, 1, Vector(nMult, 0, 0))
		ParticleManager:ReleaseParticleIndex(prt)
		prt = ParticleManager:CreateParticle('particles/multicast_item/multicast_b.vpcf', PATTACH_OVERHEAD_FOLLOW, hCaster:GetCursorCastTarget() or hCaster)
		prt = ParticleManager:CreateParticle('particles/multicast_item/multicast_b.vpcf', PATTACH_OVERHEAD_FOLLOW, hCaster)
		ParticleManager:ReleaseParticleIndex(prt)
		prt = ParticleManager:CreateParticle('particles/multicast_item/multicast_c.vpcf', PATTACH_OVERHEAD_FOLLOW, hCaster:GetCursorCastTarget() or hCaster)
		ParticleManager:SetParticleControl(prt, 1, Vector(nMult, 0, 0))
		ParticleManager:ReleaseParticleIndex(prt)
		hCaster:EmitSound('Hero_OgreMagi.Fireblast.x'..(nMult-1))
	end
end

function multicast_spell_modifier:IsItemBanned(hAbility)
	if IsServer() then
		if not self.ItemBans then
			self.ItemBans = LoadKeyValues("scripts/kv/multicast_item_bans.txt")
		end
		--DeepPrintTable(self.ItemBans)
		for k,v in pairs(self.ItemBans) do
			if hAbility:GetAbilityName() == k then
				if v > 0 then v = true else v = false end
				return v
			end
		end
		return false
	end
end