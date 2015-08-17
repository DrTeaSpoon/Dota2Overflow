if glass_passive == nil then
	glass_passive = class({})
end

function glass_passive:DeclareFunctions()
	local funcs = {
MODIFIER_EVENT_ON_ORDER
	}
	return funcs
end

function glass_passive:OnCreated()
	if IsServer() then
	end
end

function glass_passive:IsHidden()
	return true
end

function glass_passive:GetAttributes() 
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end

function glass_passive:OnOrder(params)
	if IsServer() then
		if params.order_type == DOTA_UNIT_ORDER_PICKUP_RUNE then
		local hCaster = self:GetParent()
		local vPoint = hCaster:GetCursorPosition()
		local hRune = Entities:FindByClassnameNearest("dota_item_rune", vPoint, 300) 
		local nRune = hRune:entindex()
			local hItem = self:GetAbility()
			local nItem = hItem:GetEntityIndex()
			local tOrder = {
			UnitIndex = hCaster:GetEntityIndex(), 
			OrderType = DOTA_UNIT_ORDER_CAST_RUNE,
			TargetIndex = nRune,
			AbilityIndex = nItem,
		}
		ExecuteOrderFromTable(tOrder)
		end
	end
end