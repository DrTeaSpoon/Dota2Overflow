if zuus_arc_lightning_lua_modifier == nil then
	zuus_arc_lightning_lua_modifier = class({})
end

function zuus_arc_lightning_lua_modifier:OnCreated( kv )	
	if IsServer() then
		self.jumps = kv.jumps - 1
		self.radius = kv.radius
		self.dmg = kv.dmg
		self.mdmg = kv.mdmg
		self.dmgtype = kv.dmgtype
		self.instance = kv.instance
	end
end
 
function zuus_arc_lightning_lua_modifier:IsHidden()
	return true
end


function zuus_arc_lightning_lua_modifier:OnDestroy()
	if IsServer() then
		local hAbility = self:GetAbility()
		if self.jumps > 0 then
			self:GetParent():AddNewModifier( self:GetCaster(), hAbility, hAbility.ProtectMod, { duration = hAbility.InsProtect , instance = self.instance })
			EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), "Hero_Zuus.ArcLightning.Target", self:GetCaster() )
			local hCaster = self:GetCaster()
			local nFlag = hAbility:GetAbilityTargetFlags() or DOTA_UNIT_TARGET_FLAG_NONE
			local nTeam = hAbility:GetAbilityTargetTeam() or DOTA_UNIT_TARGET_TEAM_BOTH
			local nType = hAbility:GetAbilityTargetType() or DOTA_UNIT_TARGET_ALL
			local tTargets = FindUnitsInRadius(hCaster:GetTeam(),
				self:GetParent():GetOrigin(),
				self:GetParent(),
				self.radius,
				nTeam,
				nType,
				nFlag,
				FIND_CLOSEST,
				false
			)
			if #tTargets > 0 then
				for _,hTarget in pairs(tTargets) do
					if hTarget ~= nil and ( not hTarget:IsMagicImmune() ) and ( not hTarget:IsInvulnerable() ) and hTarget ~= self:GetParent() then
						if not self:HasProtection(hTarget) then
							local nFXIndex = ParticleManager:CreateParticle( hAbility.Effect, PATTACH_CUSTOMORIGIN, nil );
							ParticleManager:SetParticleControlEnt( nFXIndex, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetOrigin(), true );
							ParticleManager:SetParticleControlEnt( nFXIndex, 1, hTarget, PATTACH_POINT_FOLLOW, "attach_hitloc", hTarget:GetOrigin(), true );
							ParticleManager:ReleaseParticleIndex( nFXIndex );
							hTarget:AddNewModifier( self:GetCaster(), hAbility, hAbility.MainMod, {
							duration = hAbility.JumpDelay
							,jumps = self.jumps
							,radius = self.radius
							,dmg = self.dmg
							,mdmg = self.mdmg
							,dmgtype = self.dmgtype
							,instance = self.instance
							} )
							break
						end
					end
				end
			end
		end
		self:DamageParent()
	end
end

function zuus_arc_lightning_lua_modifier:DamageParent()
	if IsServer() then
		local armor = self:GetParent():GetPhysicalArmorValue()
		if armor < 1 then armor = 1 end
		local damage = {
			victim = self:GetParent(),
			attacker = self:GetCaster(),
			damage = self.dmg * armor + self.mdmg ,
			damage_type = self.dmgtype,
			ability = self:GetAbility()
		}
		local dmg = ApplyDamage( damage )
		local life_time = 2.0
		local digits = string.len( math.floor( dmg ) ) + 1
		local numParticle = ParticleManager:CreateParticle( "particles/msg_fx/msg_crit.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
		ParticleManager:SetParticleControl( numParticle, 1, Vector( 0, dmg, 4 ) )
		ParticleManager:SetParticleControl( numParticle, 2, Vector( life_time, digits, 0 ) )
		ParticleManager:SetParticleControl( numParticle, 3, Vector( 0, 150, 255 ) )
		
	end
end

function zuus_arc_lightning_lua_modifier:HasProtection(hTarget)
	if IsServer() then
		local hAbility = self:GetAbility()
		if hTarget:HasModifier(hAbility.ProtectMod) then
			local tMods = hTarget:FindAllModifiersByName(hAbility.ProtectMod)
			if tMods then
				for k, v in pairs(tMods) do
					if v.instance == self.instance then
					return true
					end
				end
			end
		end
		return false
	end
end

function zuus_arc_lightning_lua_modifier:IsPurgable()
	return false
end

function zuus_arc_lightning_lua_modifier:GetAttributes() 
	return MODIFIER_ATTRIBUTE_MULTIPLE
end