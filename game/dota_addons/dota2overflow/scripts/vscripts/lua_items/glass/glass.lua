if item_glass == nil then
	item_glass = class({})
end

LinkLuaModifier( "glass_passive", "lua_items/glass/glass_passive.lua", LUA_MODIFIER_MOTION_NONE )

function item_glass:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_RUNE_TARGET + DOTA_ABILITY_BEHAVIOR_OPTIONAL_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_NO_TARGET
	return behav
end

function item_glass:OnSpellStart()
	local hTarget = false
	if not self:GetCursorTargetingNothing() then
	hTarget = self:GetCursorTarget()
	self:GetCaster():AddSpeechBubble(1, "#dota_chatwheel_message_Pause", 2, 0, 0) 
	print("Ent index: " .. hTarget:GetEntityIndex())
	end
end

function item_glass:GetIntrinsicModifierName()
	return "glass_passive"
end