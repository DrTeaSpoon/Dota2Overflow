if arc_lightning_lua_protect == nil then
	arc_lightning_lua_protect = class({})
end

function arc_lightning_lua_protect:OnCreated( kv )	
	if IsServer() then
		self.instance = kv.instance
	end
end
 
function arc_lightning_lua_protect:IsHidden()
	return true
end

function arc_lightning_lua_protect:IsPurgable()
	return false
end

function arc_lightning_lua_protect:GetAttributes() 
	return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end