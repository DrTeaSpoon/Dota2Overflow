
if fire_wall == nil then
	fire_wall = class({})
end
LinkLuaModifier("fire_wall_hidden", "lua_abilities/basic_abilities/fire_wall/modifier.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("element_fire", "lua_mods/element_fire", LUA_MODIFIER_MOTION_NONE)

function fire_wall:GetCastAnimation()
	return ACT_DOTA_ATTACK
end

function fire_wall:GetPlaybackRateOverride()
	return 0.5
end

function fire_wall:OnSpellStart()
    local caster = self:GetCaster()
    local data = {}
	data.effect_length = self:GetSpecialValueFor("effect_length")
	data.effect_duration = self:GetSpecialValueFor("effect_duration")
	data.effect_radius = self:GetSpecialValueFor("effect_radius")
	data.stack_actual = self:GetSpecialValueFor("stack_actual")
	data.burn_interval = self:GetSpecialValueFor("burn_interval")
	--self.DamageReport = 0
	local midPos = self:GetMidpointPosition()
	local vForward = self:GetDirectionVector()
	local endPos = midPos + vForward * (data.effect_length/2+50)
	local startPos = midPos + (vForward*-1) * (data.effect_length/2+50)
    local expireTime = GameRules:GetGameTime() + data.effect_duration
    
    local particleName = "particles/units/heroes/hero_jakiro/jakiro_macropyre.vpcf"
	local pfx = ParticleManager:CreateParticle( particleName, PATTACH_ABSORIGIN, caster )
	ParticleManager:SetParticleControl( pfx, 0, startPos )
	ParticleManager:SetParticleControl( pfx, 1, endPos )
	ParticleManager:SetParticleControl( pfx, 2, Vector( data.effect_duration, 0, 0 ) )
	ParticleManager:SetParticleControl( pfx, 3, startPos )
    
	local projectileRadius = data.effect_radius
	local numProjectiles = math.floor( data.effect_length / (data.effect_radius) ) + 1
	local stepLength = data.effect_length / ( numProjectiles - 1 )
	
	EmitSoundOnLocationWithCaster(midPos, "Hero_EmberSpirit.FireRemnant.Cast", hCaster )
    
    --destroy trees in area upon cast
    for i=1, numProjectiles do
        local pos = startPos + self:GetDirectionVector() * (i-1) * stepLength
        GridNav:DestroyTreesAroundPoint(pos, projectileRadius, false)
		--DebugDrawCircle(pos, Vector(255,255,255), 1, projectileRadius, false, data.effect_duration ) 
        --DebugDrawCircle(pos, Vector(255,0,0), 1, pathRadius, true, data.effect_duration)
    end
    --start effect timer
    local elapsed = 0
    Timers:CreateTimer(data.burn_interval, function()
        for i=1, numProjectiles do
            local pos = startPos + self:GetDirectionVector() * (i-1) * stepLength
            local ents = 
                FindUnitsInRadius(caster:GetTeam(), pos, nil, projectileRadius, self:GetAbilityTargetTeam(), self:GetAbilityTargetType(), self:GetAbilityTargetFlags(), FIND_ANY_ORDER, false)
            for _, ent in pairs(ents) do
				if not ent:HasModifier("fire_wall_hidden") then
                ent:AddNewModifier(caster, self, "fire_wall_hidden", {
					stack = data.stack_actual,
                    duration = 0.49
                })
				end
            end
        end
        elapsed = elapsed + data.burn_interval
        if elapsed < data.effect_duration then
            return data.burn_interval
		else
			--print("Damage report: " .. self.DamageReport)
        end
    end)
end

function fire_wall:OnUpgrade()
	if not self.isVectorTarget then
		VectorTarget:WrapAbility(self, {

            PointOfCast = "midpoint"
		})
	end
end