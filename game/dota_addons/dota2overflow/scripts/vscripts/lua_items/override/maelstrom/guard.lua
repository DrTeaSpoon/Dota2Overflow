if item_maelstrom_ovf_guard == nil then
	item_maelstrom_ovf_guard = class({})
end

function item_maelstrom_ovf_guard:OnCreated( kv )	
	if IsServer() then
		self.instance = kv.instance
	end
end
 
function item_maelstrom_ovf_guard:IsHidden()
	return true
end

function item_maelstrom_ovf_guard:IsPurgable()
	return false
end

function item_maelstrom_ovf_guard:GetAttributes() 
	return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end