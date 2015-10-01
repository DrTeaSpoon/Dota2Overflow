if mod_pit_modifier == nil then
	mod_pit_modifier = class({})
end

function mod_pit_modifier:OnCreated( kv )	
	if IsServer() then
		self.nFXIndex = ParticleManager:CreateParticle( "particles/econ/generic/generic_buff_1/generic_buff_1.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
		ParticleManager:SetParticleControl( self.nFXIndex, 14, Vector(2, 2, 2 ) )
		local col = TEAM_COLORS[self:GetParent():GetTeam()]
		ParticleManager:SetParticleControl( self.nFXIndex, 15, Vector(col[1], col[2], col[3] ) )
		self:AddParticle( self.nFXIndex, false, false, -1, false, false )
		self:StartIntervalThink( 0.5 )
	end
end
 
function mod_pit_modifier:IsHidden() return false end
function mod_pit_modifier:IsDebuff() return true end

function mod_pit_modifier:GetTexture()
	return "lina_laguna_blade"
end


function mod_pit_modifier:OnIntervalThink()
	if IsServer() then
		if self:GetParent():IsAlive() then
			local tTargets = FindUnitsInRadius(self:GetParent():GetTeam(),
				self:GetParent():GetOrigin(),
				nil,
				500,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_ALL,
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_CLOSEST,
				false
			)
			local hTarget = false
			if tTargets then
				for k,v in pairs(tTargets) do
					if v ~= self:GetParent() then
						hTarget = v
						break
					end
				end
			end
			if hTarget then
			self:Shock(hTarget)
			end
		end
	end
end

function mod_pit_modifier:Shock(hTarget)
	local nFXIndex = ParticleManager:CreateParticle( "particles/lina_spell_laguna_chain.vpcf", PATTACH_CUSTOMORIGIN, nil );
	ParticleManager:SetParticleControlEnt( nFXIndex, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetOrigin() + Vector( 0, 0, 100 ), true );
	ParticleManager:SetParticleControlEnt( nFXIndex, 1, hTarget, PATTACH_POINT_FOLLOW, "attach_hitloc", hTarget:GetOrigin() + Vector( 0, 0, 100 ), true );
		local col = TEAM_COLORS[self:GetParent():GetTeam()]
		ParticleManager:SetParticleControl( nFXIndex, 15, Vector(col[1], col[2], col[3] ) )
	ParticleManager:ReleaseParticleIndex( nFXIndex );
	local hAttacker = self:GetParent()
	local damageTable = {
		victim = hTarget,
		attacker = self:GetParent(),
		damage = 100,
		damage_type = DAMAGE_TYPE_PHYSICAL,
	}
	ApplyDamage(damageTable)
end