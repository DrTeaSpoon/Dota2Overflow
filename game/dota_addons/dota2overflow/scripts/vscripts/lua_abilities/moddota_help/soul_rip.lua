abaddon_soul_rip = class ({})

LinkLuaModifier( "modifer_abaddon_soul_rip_lift", "lua_abilities/moddota_help/soul_rip_lift.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifer_abaddon_soul_rip_heal", "lua_abilities/moddota_help/soul_rip_heal.lua", LUA_MODIFIER_MOTION_NONE )
--LinkLuaModifier( "modifer_lua_illusion", "lua_abilities/moddota_help/lua_illusion.lua", LUA_MODIFIER_MOTION_NONE )
 
function abaddon_soul_rip:OnSpellStart()
        local hTarget = self:GetCursorTarget()
        local  hCaster = self:GetCaster()
		if hCaster == nil or hTarget == nil or hTarget:TriggerSpellAbsorb( this ) then
				return
		end
		local fDuration = self:GetSpecialValueFor( "duration" )
		local fHealDuration = self:GetSpecialValueFor( "heal_duration" )
        hTarget:Interrupt()
		EmitSoundOnLocationWithCaster(hTarget:GetAbsOrigin(), "Hero_Abaddon.DeathCoil.Cast", hCaster) 
		
		local nPctDamage = self:GetSpecialValueFor("damage_pct") / 100
		local nDamage = hTarget:GetMaxHealth() * nPctDamage
		local tDamage = {
		victim = hTarget,
		attacker = self:GetCaster(),
		damage = nDamage,
		damage_type = self:GetAbilityDamageType(),
		ability = self
		}
        hTarget:AddNewModifier(hCaster, self, "modifer_abaddon_soul_rip_lift", {duration = fDuration})
		local nHeal = ApplyDamage(tDamage)
        hCaster:AddNewModifier(hCaster, self, "modifer_abaddon_soul_rip_heal", {duration = fHealDuration, heal = nHeal})
end