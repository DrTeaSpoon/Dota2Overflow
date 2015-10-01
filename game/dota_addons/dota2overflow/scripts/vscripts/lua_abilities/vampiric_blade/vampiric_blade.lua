vampiric_blade = class({})
LinkLuaModifier( "modifier_vampiric_blade", "lua_abilities/vampiric_blade/modifier_vampiric_blade.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_vampiric_blade_fade", "lua_abilities/vampiric_blade/modifier_vampiric_blade_fade.lua", LUA_MODIFIER_MOTION_NONE )
--LinkLuaModifier( "modifier_vampiric_blade_curse", "lua_abilities/vampiric_blade/modifier_vampiric_blade_curse.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_vampiric_blade_passive", "lua_abilities/vampiric_blade/modifier_vampiric_blade_passive.lua", LUA_MODIFIER_MOTION_NONE )

--------------------------------------------------------------------------------

function vampiric_blade:CastFilterResultTarget( hTarget )
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

function vampiric_blade:GetCastRange( vLocation, hTarget )
	return self.BaseClass.GetCastRange( self, vLocation, hTarget )
end
--------------------------------------------------------------------------------

function vampiric_blade:OnSpellStart()
	local hTarget = self:GetCursorTarget()
	if hTarget ~= nil then
		hTarget:TriggerSpellReflect( self )
		local absorb = hTarget:TriggerSpellAbsorb( self )
		if not absorb then
			local damage_delay = self:GetSpecialValueFor( "damage_delay" )
			--if self:GetCaster():HasScepter() then
			--	damage_delay = self:GetSpecialValueFor( "scepter_delay" )
			--end
		
			hTarget:AddNewModifier( self:GetCaster(), self, "modifier_vampiric_blade", { duration = damage_delay, fade_id = GameRules:GetGameTime() } )
				EmitSoundOnLocationWithCaster(hTarget:GetOrigin(),"Hero_Pudge.Dismember", self:GetCaster()) 
		end

		local nFXIndex = ParticleManager:CreateParticle( "particles/black_laguna.vpcf", PATTACH_CUSTOMORIGIN, nil );
		ParticleManager:SetParticleControlEnt( nFXIndex, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetCaster():GetOrigin() + Vector( 0, 0, 96 ), true );
		ParticleManager:SetParticleControlEnt( nFXIndex, 1, hTarget, PATTACH_POINT_FOLLOW, "attach_hitloc", hTarget:GetOrigin(), true );
		
			local Colour = {255,0,0}
			ParticleManager:SetParticleControl(nFXIndex, 15, Vector(Colour[1],Colour[2],Colour[3])) 
			
		--ParticleManager:SetParticleControl(nFXIndex, 15, Vector(120,20,255)) 
		ParticleManager:ReleaseParticleIndex( nFXIndex );
	end
end

--------------------------------------------------------------------------------
function vampiric_blade:OnHeroCalculateStatBonus() 
end

function vampiric_blade:OnAbilityPinged(nPlayerID)
	if IsServer() then
		print("Vampire Level: " .. self:GetLevel())
	end
end

function vampiric_blade:GetTexture()
	return "dark_sphere"
end

function vampiric_blade:GetAbilityTexture()
	return "dark_sphere"
end
function vampiric_blade:Texture()
	return "dark_sphere"
end
function vampiric_blade:AbilityTexture()
	return "dark_sphere"
end

function vampiric_blade:GetAOERadius()
	return self:GetSpecialValueFor("aoe_range")
end

function vampiric_blade:GetAbilityDamageType()
	if self:GetCaster():HasScepter() then
		return DAMAGE_TYPE_PURE
	else
		return DAMAGE_TYPE_MAGICAL
	end
end