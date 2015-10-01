if lava_map_ability_modifier == nil then
	lava_map_ability_modifier = class({})
end

function lava_map_ability_modifier:OnCreated( kv )	
	if IsServer() then
		self:StartIntervalThink( 1 )
	end
end
 
function lava_map_ability_modifier:IsHidden() return false end
function lava_map_ability_modifier:IsDebuff() return true end

function lava_map_ability_modifier:GetTexture()
	return "lava"
end

function lava_map_ability_modifier:OnIntervalThink()
	if IsServer() then
		if self:GetParent():IsAlive() then
		local hAttacker = self:GetParent()
		local damageTable = {
			victim = self:GetParent(),
			attacker = hAttacker,
			damage = 100,
			damage_type = DAMAGE_TYPE_PHYSICAL,
		}
		ParticleManager:CreateParticle("particles/units/heroes/hero_dragon_knight/dragon_knight_transform_red_flames01.vpcf", PATTACH_ABSORIGIN , self:GetParent()) 
		
		ApplyDamage(damageTable)
		end
	end
end