if heroes_base_mod == nil then
	heroes_base_mod = class({})
	LinkLuaModifier( "element_water", "lua_mods/element_water.lua", LUA_MODIFIER_MOTION_NONE )
end

function heroes_base_mod:IsHidden()
	return true
end

function heroes_base_mod:OnCreated(kv)
	self.gain_agi = kv.gain_agi
	self.gain_str = kv.gain_str
	self.gain_int = kv.gain_int
	self.bottlefound = false
	self.waterapplied = false
	self:StartIntervalThink( 0.5 )
end

function heroes_base_mod:OnIntervalThink()
	if IsServer() then
		if not self:GetParent():IsAlive() then return end
		if self:GetParent():IsIllusion() then return end
		if not self.bottlefound and self:GetParent():HasModifier("modifier_bottle_regeneration") then
			self.bottlefound = true
			if not self.waterapplied then
			self:GetParent():AddNewModifier( self:GetParent(), self, "element_water", {} )
			self.waterapplied = true
			end
		elseif not self:GetParent():HasModifier("modifier_bottle_regeneration") and self.waterapplied then
			self.waterapplied = false
			self.bottlefound = false
			self:GetParent():RemoveModifierByName( "element_water" )
		end
	end
end
function heroes_base_mod:GetAttributes() 
	return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end


function heroes_base_mod:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_ABILITY_LAYOUT
	}
 
	return funcs
end

function heroes_base_mod:GetModifierBonusStats_Intellect() return self.gain_int * (self:GetParent():GetLevel()-1) end
function heroes_base_mod:GetModifierBonusStats_Agility()   return self.gain_agi * (self:GetParent():GetLevel()-1) end
function heroes_base_mod:GetModifierBonusStats_Strength()  return self.gain_str * (self:GetParent():GetLevel()-1) end
function heroes_base_mod:GetModifierAbilityLayout() return 6 end