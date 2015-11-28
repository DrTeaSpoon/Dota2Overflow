if flag_goal_blue_mod == nil then
	flag_goal_blue_mod = class({})
end

function flag_goal_blue_mod:OnCreated( kv )	
	if IsServer() then
	end
end

function flag_goal_blue_mod:OnRefresh( kv )	
	if IsServer() then
	
	end
end

function flag_goal_blue_mod:IsHidden()
	return true
end

function flag_goal_blue_mod:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end