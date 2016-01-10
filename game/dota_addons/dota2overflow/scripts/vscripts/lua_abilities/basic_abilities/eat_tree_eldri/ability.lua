if eat_tree_eldri == nil then
	eat_tree_eldri = class({})
end
LinkLuaModifier("eat_tree_eldri_mod", "lua_abilities/basic_abilities/eat_tree_eldri/modifier.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier( "book_eldri_modifier", "lua_items/overflow/basics/eldri_book.lua", LUA_MODIFIER_MOTION_NONE )

function eat_tree_eldri:GetCastAnimation()
	return ACT_DOTA_CAST_ABILITY_1
end

function eat_tree_eldri:OnSpellStart()
	GridNav:DestroyTreesAroundPoint( self:GetCursorPosition() , 1, true) 
	EmitSoundOnLocationWithCaster( self:GetCaster():GetOrigin(), "Hero_Omniknight.GuardianAngel", self:GetCaster() )
	self:GetCaster():AddNewModifier( self:GetCaster(), self, "eat_tree_eldri_mod", { duration = self:GetSpecialValueFor("duration") , stack = 1 } )
end

function eat_tree_eldri:GetBehavior()
	local behav = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
	return behav
end

function eat_tree_eldri:OnUpgrade()
	self:GetCaster():AddNewModifier( self:GetCaster(), self, "book_eldri_modifier", { stacks = 2 } )
end