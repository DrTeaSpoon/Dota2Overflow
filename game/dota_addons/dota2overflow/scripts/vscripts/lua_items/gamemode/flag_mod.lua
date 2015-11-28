if flag_mod == nil then
	flag_mod = class({})
end

function flag_mod:OnCreated( kv )	
	if IsServer() then
			self.f_team = self:GetAbility().f_team
			print(self.f_team)
	end
end

function flag_mod:IsHidden()
	return false
end

function flag_mod:OnCreated()
	if IsServer() then
		self.PosA = self:GetParent():GetAbsOrigin()
		self.PosB = self:GetParent():GetAbsOrigin()
		self:StartIntervalThink( 0.25 )
	end
end

function flag_mod:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_MULTIPLE
end

function flag_mod:OnIntervalThink()
	if IsServer() then
		self.PosA = self:GetParent():GetAbsOrigin()
		local vDiff = self.PosA - self.PosB
		if vDiff:Length2D() > 350 then
			self:DropIt()
		else
			self.PosB = self:GetParent():GetAbsOrigin()
			self:CheckForGoal()
		end
	end
end

function flag_mod:DropIt()
	local vPoint = self.PosB
	local hItem = self:GetAbility()
	local hCaster = self:GetParent()
	hCaster:DropItemAtPositionImmediate(hItem, vPoint)
end

function flag_mod:CheckForGoal()
	if IsServer() then
		local hItem = self:GetAbility()
		local hCaster = self:GetParent()
		local sMod = "flag_goal_" .. self.f_team .. "mod"
		local vPoint = self.PosB
		if hCaster:GetTeam() == self.f_team then
			if hCaster:HasModifier(sMod) then
				print("returned!")
				hCaster:DropItemAtPositionImmediate(hItem, vPoint)
			end
		else
			if hCaster:HasModifier(sMod) then
				print("goal!")
				hCaster:DropItemAtPositionImmediate(hItem, vPoint)
			end
		end
	end
end