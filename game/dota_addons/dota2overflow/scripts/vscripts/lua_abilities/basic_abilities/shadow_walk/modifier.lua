if shadow_walk_modifier == nil then
	shadow_walk_modifier = class({})
end

function shadow_walk_modifier:OnCreated( kv )	
	if IsServer() then
	end
end

function shadow_walk_modifier:DeclareFunctions()
	local funcs = {
MODIFIER_EVENT_ON_ATTACK_LANDED,
MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
MODIFIER_EVENT_ON_ABILITY_EXECUTED 
	}
	return funcs
end

function shadow_walk_modifier:OnAbilityExecuted(params)
	if IsServer() then
		--DeepPrintTable(params)
		if params.unit == self:GetParent() and GameRules:IsDaytime() then
	EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "Hero_Nevermore.Pick", self:GetCaster() )
	local hAbility = self:GetAbility()
	local hTarget = self:GetParent()
		local nFXIndex = ParticleManager:CreateParticle( "particles/shadow_raze_gen/raze.vpcf", PATTACH_ABSORIGIN, self:GetCaster() )
		ParticleManager:SetParticleControl( nFXIndex, 0, hTarget:GetAbsOrigin() )
		ParticleManager:SetParticleControl( nFXIndex, 15, Vector( 133, 0, 162 ) )
		local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), hTarget:GetOrigin(), nil, hAbility:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )

		if #enemies > 0 then
			for _,enemy in pairs(enemies) do
				if enemy ~= nil and ( not enemy:IsMagicImmune() ) and ( not enemy:IsInvulnerable() ) then
					local damage = {
						victim = enemy,
						attacker = self:GetCaster(),
						damage = hAbility:GetSpecialValueFor("poison_damage"),
						damage_type = hAbility:GetAbilityDamageType(),
						ability = self:GetAbility()
					}
					ApplyDamage( damage )
				end
			end
		end
		
					local damage = {
						victim = self:GetParent(),
						attacker = self:GetCaster(),
						damage = hAbility:GetSpecialValueFor("poison_damage"),
						damage_type = hAbility:GetAbilityDamageType(),
						ability = self:GetAbility()
					}
					ApplyDamage( damage )
		
	self:Destroy()
			
		end
	end
end

function shadow_walk_modifier:CheckState()
	local hAbility = self:GetAbility()
	local invis = false
	if self:GetElapsedTime() > hAbility:GetSpecialValueFor("fade_time") then invis = true end
	if IsServer() then
	if not GameRules:IsDaytime() then invis = true end
	end
	local state = {
	[MODIFIER_STATE_INVISIBLE] = invis
	}
	return state
end

function shadow_walk_modifier:GetModifierInvisibilityLevel()
	return 1
end

function shadow_walk_modifier:OnAttackLanded( params )
	if IsServer() then
		if params.attacker == self:GetParent() then
	EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "Hero_Nevermore.Pick", self:GetCaster() )
	self:AttackProc(params)
	self:Destroy()
		end
	end
end


function shadow_walk_modifier:IsHidden()
	return false
end

function shadow_walk_modifier:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE 
end

function shadow_walk_modifier:AllowIllusionDuplicate() 
	return false
end
function shadow_walk_modifier:IsPurgable() 
	return true
end

function shadow_walk_modifier:GetEffectName()
	return "particles/items_fx/ghost.vpcf"
end
 
--------------------------------------------------------------------------------
 
function shadow_walk_modifier:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end



function shadow_walk_modifier:AttackProc(params)
	local hAbility = self:GetAbility()
	local hTarget = params.target
		local nFXIndex = ParticleManager:CreateParticle( "particles/shadow_raze_gen/raze.vpcf", PATTACH_ABSORIGIN, self:GetCaster() )
		ParticleManager:SetParticleControl( nFXIndex, 0, hTarget:GetAbsOrigin() )
		ParticleManager:SetParticleControl( nFXIndex, 15, Vector( 133, 0, 162 ) )
		local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), hTarget:GetOrigin(), nil, hAbility:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )

		if #enemies > 0 then
			for _,enemy in pairs(enemies) do
				if enemy ~= nil and ( not enemy:IsInvulnerable() ) then
					local damage = {
						victim = enemy,
						attacker = self:GetCaster(),
						damage = hAbility:GetSpecialValueFor("poison_damage"),
						damage_type = hAbility:GetAbilityDamageType(),
						ability = self:GetAbility()
					}
					ApplyDamage( damage )
				end
			end
		end
end





