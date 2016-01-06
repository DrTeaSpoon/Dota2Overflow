if item_ovf_book_curse == nil then
	item_ovf_book_curse = class({})
end

function item_ovf_book_curse:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_PASSIVE
	return behav
end