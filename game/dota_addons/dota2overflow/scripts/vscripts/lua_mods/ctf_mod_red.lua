if flag_goal_red_mod == nil then
	flag_goal_red_mod = class({})
end

function flag_goal_red_mod:OnCreated( kv )	
	if IsServer() then
	end
end

function flag_goal_red_mod:OnRefresh( kv )	
	if IsServer() then
	
	end
end

function flag_goal_red_mod:IsHidden()
	return true
end

function flag_goal_red_mod:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE
end