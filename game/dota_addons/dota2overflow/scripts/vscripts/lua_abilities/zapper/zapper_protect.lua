if zapper_protect == nil then
	zapper_protect = class({})
end

function zapper_protect:OnCreated( kv )	
	if IsServer() then
		self.instance = kv.instance
	end
end
 
function zapper_protect:IsHidden()
	return true
end

function zapper_protect:IsPurgable()
	return false
end

function zapper_protect:GetAttributes() 
	return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end