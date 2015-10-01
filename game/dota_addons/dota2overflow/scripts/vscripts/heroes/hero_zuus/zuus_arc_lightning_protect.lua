if zuus_arc_lightning_lua_protect == nil then
	zuus_arc_lightning_lua_protect = class({})
end

function zuus_arc_lightning_lua_protect:OnCreated( kv )	
	if IsServer() then
		self.instance = kv.instance
	end
end
 
function zuus_arc_lightning_lua_protect:IsHidden()
	return true
end

function zuus_arc_lightning_lua_protect:IsPurgable()
	return false
end

function zuus_arc_lightning_lua_protect:GetAttributes() 
	return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end