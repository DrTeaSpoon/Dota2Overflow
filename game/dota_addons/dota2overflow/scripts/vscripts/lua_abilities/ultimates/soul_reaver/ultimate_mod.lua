if soul_reaver_mod == nil then
	soul_reaver_mod = class({})
end

function soul_reaver_mod:OnCreated( kv )	
	if IsServer() then
		local nFXIndex = ParticleManager:CreateParticle( "particles/neutral_fx/roshan_spawn.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
		ParticleManager:SetParticleControl(nFXIndex, 0, self:GetCaster():GetOrigin()) 
		ParticleManager:ReleaseParticleIndex(nFXIndex)
		self.AttackBonus = (self:GetParent():GetAttackRange() - self:GetAbility():GetSpecialValueFor("attack_range")) * -1
		self.OriginalAtkCap = self:GetParent():GetAttackCapability() 
		self:GetParent():SetAttackCapability(DOTA_UNIT_CAP_MELEE_ATTACK) 
		self:StartIntervalThink( 1 )
		local hCaster = self:GetParent()
		hCaster:StartGesture(ACT_DOTA_SPAWN)
		
		self.nFXIndex_Hands = ParticleManager:CreateParticle( "particles/generic_attack_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
		ParticleManager:SetParticleControl(self.nFXIndex_Hands, 0, self:GetCaster():GetOrigin()) 
		ParticleManager:SetParticleControl(self.nFXIndex_Hands, 15, Vector(50,255,150)) 
		self:AddParticle( self.nFXIndex_Hands, false, false, -1, false, false )
		self.above = true
	end
end

function soul_reaver_mod:IconUpdate()
		local hCaster = self:GetParent()
		if hCaster:IsIllusion() then return end
		local nHPerc = hCaster:GetHealthPercent()
		if (self:GetAbility():GetSpecialValueFor("treshold") > nHPerc) == self.above then
			self:GetAbility():MarkAbilityButtonDirty()
			self.above = not self.above
		end
end

function soul_reaver_mod:OnIntervalThink()
	if IsServer() then
		local hCaster = self:GetParent()
		if hCaster:IsIllusion() then return end
		local nHPerc = hCaster:GetHealthPercent()
		if self:GetAbility():GetSpecialValueFor("treshold") > nHPerc then
		local nHealth = hCaster:GetHealth()
		local nHMax = hCaster:GetMaxHealth()
		local nDamage = nHealth*(self:GetAbility():GetSpecialValueFor("health_drain") / 100)
		local damage = {
			victim = hCaster,
			attacker = hCaster,
			damage = nDamage,
			damage_type = self:GetAbility():GetAbilityDamageType(),
			ability = self:GetAbility()
		}
		ApplyDamage( damage )
		end
		self:IconUpdate()
	end
end

function soul_reaver_mod:OnDestroy()
	if IsServer() then
		self:GetParent():SetAttackCapability(self.OriginalAtkCap) 
		local nFXIndex = ParticleManager:CreateParticle( "particles/neutral_fx/roshan_spawn.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
		ParticleManager:SetParticleControl(nFXIndex, 0, self:GetCaster():GetOrigin()) 
		ParticleManager:ReleaseParticleIndex(nFXIndex)
	end
end
 
function soul_reaver_mod:DeclareFunctions()
	local funcs = {
MODIFIER_PROPERTY_MODEL_CHANGE,
MODIFIER_PROPERTY_MODEL_SCALE,
MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
MODIFIER_EVENT_ON_ATTACK_LANDED
	}
	return funcs
end

function soul_reaver_mod:IsHidden()
	return false
end

function soul_reaver_mod:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE 
end

function soul_reaver_mod:AllowIllusionDuplicate() 
	return true
end

function soul_reaver_mod:OnAttackLanded( params )
	if IsServer() then
		if params.attacker == self:GetParent() then
			--EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "Roshan.Attack", self:GetCaster() )
			local hCaster = self:GetParent()
			local hTarget = params.target
			EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "Hero_WarlockGolem.PreAttack", self:GetCaster() )
			if hTarget:IsBuilding() or hTarget:IsMechanical() or hTarget:IsIllusion() then return end
			local nDamage = (hCaster:GetMaxMana() + hCaster:GetMaxHealth())  * (self:GetAbility():GetSpecialValueFor("total_damage") / 100)
			local nMana = hTarget:GetMana()
			local nSManaBurn = self:GetAbility():GetSpecialValueFor("mana_burn") / 100
			local nManaBurn = nDamage*nSManaBurn
			nDamage = nDamage - nManaBurn
			local bStun = false
			if nMana < nManaBurn then
			nDamage = nDamage + nManaBurn - nMana
			bStun = true
			end
					local damage = {
						victim = hTarget,
						attacker = hCaster,
						damage = nDamage,
						damage_type = self:GetAbility():GetAbilityDamageType(),
						ability = self:GetAbility()
					}
			if not hCaster:IsIllusion() then
				local dmg = math.floor(ApplyDamage( damage ))
				hCaster:Heal(dmg * (self:GetAbility():GetSpecialValueFor("vampiric") / 100), self:GetAbility())
				hTarget:ReduceMana(nManaBurn)
				local life_time = 2.0
				local digits = string.len( math.floor( dmg ) ) + 1
				
				local numParticle = ParticleManager:CreateParticle( "particles/burn_msg.vpcf", PATTACH_OVERHEAD_FOLLOW, hTarget )
				ParticleManager:SetParticleControl( numParticle, 3, Vector( 10, dmg, 5 ) )
				ParticleManager:SetParticleControl( numParticle, 4, Vector( life_time, digits, 0 ) )
			if bStun and RandomInt(1, 100) < self:GetAbility():GetSpecialValueFor("stun_chance") then
				EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "Roshan.Bash", self:GetCaster() )
				params.target:AddNewModifier( self:GetCaster(), self:GetAbility(), "generic_lua_stun", { duration = self:GetAbility():GetSpecialValueFor("stun_duration") } )
			end
			end
		end
	end
end
function soul_reaver_mod:GetModifierModelChange() return "models/items/warlock/golem/hellsworn_golem/hellsworn_golem.vmdl" end
function soul_reaver_mod:GetModifierModelScale() return 0.25 end
function soul_reaver_mod:GetModifierAttackRangeBonus() return self.AttackBonus end



