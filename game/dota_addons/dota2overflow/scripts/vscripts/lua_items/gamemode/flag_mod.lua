if flag_mod == nil then
	flag_mod = class({})
end

function flag_mod:DeclareFunctions()
	local funcs = {
MODIFIER_EVENT_ON_ABILITY_START
	}
	return funcs
end
  
function flag_mod:OnAbilityExecuted( params )
	if IsServer() then
		if params.unit == self:GetParent() then
			
			params.ability
		end
	end
	return 0
end

function flag_mod:OnCreated( kv )	
	if IsServer() then
			self.f_team = self:GetParent():GetTeam()
			self.f_texture = "flag_team" .. self.f_team
		end
	end
end

function flag_mod:IsHidden()
	return false
end

function flag_mod:GetTexture() 
	return self.f_texture
end