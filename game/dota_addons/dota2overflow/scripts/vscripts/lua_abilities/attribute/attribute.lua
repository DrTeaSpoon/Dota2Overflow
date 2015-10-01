if lua_attribute == nil then
	lua_attribute = class({})
end

function lua_attribute:OnUpgrade()
	local n = 2
	self:GetCaster():ModifyStrength(n) 
	self:GetCaster():ModifyAgility(n) 
	self:GetCaster():ModifyIntellect(n) 
end

