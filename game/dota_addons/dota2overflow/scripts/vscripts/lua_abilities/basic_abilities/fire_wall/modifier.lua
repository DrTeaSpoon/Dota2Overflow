if fire_wall_hidden == nil then
	fire_wall_hidden = class({})
end

function fire_wall_hidden:OnCreated( kv )	
	if IsServer() then
		self.stack = kv.stack
	end
end

function fire_wall_hidden:IsHidden()
	return true
end

function fire_wall_hidden:OnDestroy()
	if IsServer() then
        self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "element_fire", {
            stacks = self.stack
        })
	end
end