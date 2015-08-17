if item_balls == nil then
	item_balls = class({})
end

function item_balls:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES
	return behav
end

function item_balls:GetManaCost()
	return self.BaseClass.GetManaCost( self, 1 )
end

function item_balls:GetCooldown( nLevel )
	return self.BaseClass.GetCooldown( self, nLevel )
end

function item_balls:GetCastAnimation( )
	local anim = ACT_DOTA_FLAIL
	return anim
end

function item_balls:OnSpellStart()
	local hCaster = self:GetCaster() --We will always have Caster.
	local vPoint = self:GetCursorPosition() --We will always have Vector for the point.
	local vOrigin = hCaster:GetAbsOrigin() --Our caster's location
	local nRange = self:GetSpecialValueFor( "range" ) --How far can we actually blink?
	local projectile = {
	--EffectName = "particles/test_particle/ranged_tower_good.vpcf",
	--EffectName = "particles/units/heroes/hero_lina/lina_spell_dragon_slave.vpcf",
	EffectName = "particles/econ/courier/courier_trail_hw_2012/courier_trail_hw_2012.vpcf",
	--EeffectName = "",
	--vSpawnOrigin = hero:GetAbsOrigin(),
	vSpawnOrigin = hCaster:GetAbsOrigin() + Vector(0,0,80),--{unit=hero, attach="attach_attack1", offset=Vector(0,0,0)},
	fDistance = nRange,
	fStartRadius = 100,
	fEndRadius = 100,
	Source = hCaster,
	fExpireTime = 8.0,
	vVelocity = hCaster:GetForwardVector() * 300, -- RandomVector(1000),
	UnitBehavior = PROJECTILES_DESTROY,
	bMultipleHits = false,
	bIgnoreSource = true,
	TreeBehavior = PROJECTILES_NOTHING,
	bCutTrees = true,
	bTreeFullCollision = false,
	WallBehavior = PROJECTILES_NOTHING,
	GroundBehavior = PROJECTILES_NOTHING,
	fGroundOffset = 80,
	nChangeMax = 1,
	bRecreateOnChange = true,
	bZCheck = false,
	bGroundLock = true,
	bProvidesVision = true,
	iVisionRadius = 350,
	iVisionTeamNumber = hCaster:GetTeam(),
	bFlyingVision = false,
	fVisionTickTime = .1,
	fVisionLingerDuration = 1,
	draw = true,--             draw = {alpha=1, color=Vector(200,0,0)},
	--iPositionCP = 0,
	--iVelocityCP = 1,
	--ControlPoints = {[5]=Vector(100,0,0), [10]=Vector(0,0,1)},
	--ControlPointForwards = {[4]=hero:GetForwardVector() * -1},
	--ControlPointOrientations = {[1]={hero:GetForwardVector() * -1, hero:GetForwardVector() * -1, hero:GetForwardVector() * -1}},
	--[[ControlPointEntityAttaches = {[0]={
		unit = hero,
		pattach = PATTACH_ABSORIGIN_FOLLOW,
		attachPoint = "attach_attack1", -- nil
		origin = Vector(0,0,0)
	}},]]
	--fRehitDelay = .3,
	--fChangeDelay = 1,
	--fRadiusStep = 10,
	--bUseFindUnitsInRadius = false,
	
	UnitTest = function(self, unit) return unit:GetUnitName() ~= "npc_dummy_unit" and unit:GetTeamNumber() ~= hCaster:GetTeamNumber() end,
	OnUnitHit = function(self, unit) 
		print ('HIT UNIT: ' .. unit:GetUnitName())
	end,
	--OnTreeHit = function(self, tree) ... end,
	--OnWallHit = function(self, gnvPos) ... end,
	--OnGroundHit = function(self, groundPos) ... end,
	--OnFinish = function(self, pos) ... end,
	}
	
	Projectiles:CreateProjectile(projectile)
end
