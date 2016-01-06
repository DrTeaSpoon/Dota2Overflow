if item_blessed_robe == nil then
	item_blessed_robe = class({})
end

LinkLuaModifier( "item_blessed_robe_modifier", "lua_items/overflow/blessed/robe/modifier.lua", LUA_MODIFIER_MOTION_NONE )

function item_blessed_robe:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_ROOT_DISABLES
	return behav
end

function item_blessed_robe:GetIntrinsicModifierName()
	return "item_blessed_robe_modifier"
end

function item_blessed_robe:OnSpellStart()
	local hCaster = self:GetCaster() --We will always have Caster.
	local vPoint = self:GetCursorPosition() --We will always have Vector for the point.
	local nMaxBlink = self:GetSpecialValueFor( "max_blink" ) --How far can we actually blink?
	local nClamp = self:GetSpecialValueFor( "blink_clamp" ) --If we try to over reach we use this value instead. (this is mechanic from blink dagger.)
	self:Blink(hCaster, vPoint, nMaxBlink, nClamp) --BLINK!
end

function item_blessed_robe:Blink(hTarget, vPoint, nMaxBlink, nClamp)
	local vOrigin = hTarget:GetAbsOrigin() --Our units's location
	ProjectileManager:ProjectileDodge(hTarget)  --We disjoint disjointable incoming projectiles.
	ParticleManager:CreateParticle("particles/items_fx/blink_dagger_start.vpcf", PATTACH_ABSORIGIN, hTarget) --Create particle effect at our caster.
	hTarget:EmitSound("DOTA_Item.BlinkDagger.Activate") --Emit sound for the blink
	local vDiff = vPoint - vOrigin --Difference between the points
	if vDiff:Length2D() > nMaxBlink then  --Check caster is over reaching.
		vPoint = vOrigin + (vPoint - vOrigin):Normalized() * nClamp -- Recalculation of the target point.
	end
	hTarget:SetAbsOrigin(vPoint) --We move the caster instantly to the location
	FindClearSpaceForUnit(hTarget, vPoint, false) --This makes sure our caster does not get stuck
	ParticleManager:CreateParticle("particles/items_fx/blink_dagger_end.vpcf", PATTACH_ABSORIGIN, hTarget) --Create particle effect at our caster.
end