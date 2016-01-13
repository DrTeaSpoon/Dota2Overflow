if earthshaker_fissure_lua_thinker == nil then
	earthshaker_fissure_lua_thinker = class({})
end
 
function earthshaker_fissure_lua_thinker:OnCreated( kv )	
	if IsServer() then
	self:GetParent():SetHullRadius(kv.radius) 
	end
end

function earthshaker_fissure_lua_thinker:OnRefresh( kv )	
	if IsServer() then
	end
end

function earthshaker_fissure_lua_thinker:OnDestroy()
	if IsServer() then
		UTIL_Remove( self:GetParent() )
	end
end

function earthshaker_fissure_lua_thinker:IsHidden()
	return true
end

function earthshaker_fissure_lua_thinker:IsPurgable() 
	return false
end

function earthshaker_fissure_lua_thinker:IsPurgeException()
	return false
end

function earthshaker_fissure_lua_thinker:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE 
end

function earthshaker_fissure_lua_thinker:AllowIllusionDuplicate() 
	return false
end
