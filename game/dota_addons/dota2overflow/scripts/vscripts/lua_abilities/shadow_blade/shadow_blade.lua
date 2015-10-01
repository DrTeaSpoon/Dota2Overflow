shadow_blade = class({})
LinkLuaModifier( "modifier_shadow_blade", "lua_abilities/shadow_blade/modifier_shadow_blade.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_shadow_blade_fade", "lua_abilities/shadow_blade/modifier_shadow_blade_fade.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_shadow_blade_curse", "lua_abilities/shadow_blade/modifier_shadow_blade_curse.lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function shadow_blade:CastFilterResultTarget( hTarget )
	if IsServer() then

		if hTarget ~= nil and hTarget:IsMagicImmune() and ( not self:GetCaster():HasScepter() ) then
			return UF_FAIL_MAGIC_IMMUNE_ENEMY
		end

		local nResult = UnitFilter( hTarget, self:GetAbilityTargetTeam(), self:GetAbilityTargetType(), self:GetAbilityTargetFlags(), self:GetCaster():GetTeamNumber() )
		return nResult
	end

	return UF_SUCCESS
end

--------------------------------------------------------------------------------

function shadow_blade:GetCastRange( vLocation, hTarget )
	return self.BaseClass.GetCastRange( self, vLocation, hTarget )
end

--------------------------------------------------------------------------------

function shadow_blade:OnSpellStart()
	local hTarget = self:GetCursorTarget()
	if hTarget ~= nil then
		hTarget:TriggerSpellReflect( self )
		local absorb = hTarget:TriggerSpellAbsorb( self )
		if not absorb then
			local damage_delay = self:GetSpecialValueFor( "damage_delay" )
			--if self:GetCaster():HasScepter() then
			--	damage_delay = self:GetSpecialValueFor( "scepter_delay" )
			--end
		
			hTarget:AddNewModifier( self:GetCaster(), self, "modifier_shadow_blade", { duration = damage_delay, fade_id = GameRules:GetGameTime() } )
			EmitSoundOn( "Hero_Nightstalker.Void.Nihility", hTarget )
		end

		local nFXIndex = ParticleManager:CreateParticle( "particles/black_laguna.vpcf", PATTACH_CUSTOMORIGIN, nil );
		ParticleManager:SetParticleControlEnt( nFXIndex, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetCaster():GetOrigin() + Vector( 0, 0, 96 ), true );
		ParticleManager:SetParticleControlEnt( nFXIndex, 1, hTarget, PATTACH_POINT_FOLLOW, "attach_hitloc", hTarget:GetOrigin(), true );
		
			local Colour = {150,0,255}
			ParticleManager:SetParticleControl(nFXIndex, 15, Vector(Colour[1],Colour[2],Colour[3])) 
			
		--ParticleManager:SetParticleControl(nFXIndex, 15, Vector(120,20,255)) 
		ParticleManager:ReleaseParticleIndex( nFXIndex );
	end
end

--------------------------------------------------------------------------------


function shadow_blade:GetAOERadius()
	return self:GetSpecialValueFor("aoe_range")
end

function shadow_blade:GetAbilityDamageType()
	if self:GetCaster():HasScepter() then
		return DAMAGE_TYPE_PURE
	else
		return DAMAGE_TYPE_MAGICAL
	end
end