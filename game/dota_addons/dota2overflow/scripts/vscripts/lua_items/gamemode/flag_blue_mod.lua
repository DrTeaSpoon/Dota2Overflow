if flag_blue_mod == nil then
	flag_blue_mod = class({})
end


function flag_blue_mod:IsHidden()
	return true
end

function flag_blue_mod:OnCreated()
	if IsServer() then
		local hGoalBlue = Entities:FindByName(nil, "gamemode_ctf_blue")
		local hCaster = self:GetParent()
		self.Return_vPos = hGoalBlue:GetAbsOrigin()
		if self:GetParent():IsIllusion() then return end
		if self:GetParent():IsCourier() then
		hCaster:DropItemAtPositionImmediate(self:GetAbility(), self.Return_vPos)
		end
		self.PosA = self:GetParent():GetAbsOrigin()
		self.PosB = self:GetParent():GetAbsOrigin()
		self:StartIntervalThink( 0.25 )
		self.nFXIndex_Hands = ParticleManager:CreateParticle( "particles/flag_carry_blue.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
		ParticleManager:SetParticleControl(self.nFXIndex_Hands, 0, self:GetCaster():GetOrigin()) 
		self:AddParticle( self.nFXIndex_Hands, false, false, -1, false, false )
		if self:GetParent():GetTeam() == DOTA_TEAM_BADGUYS and not self:GetParent():IsCourier() then
			Notifications:TopToAll({text="Dire Has Taken The Flag!", duration=2.0})
		end
		self.CTeam = self:GetParent():GetTeam()
	end
end

function flag_blue_mod:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_MULTIPLE
end

function flag_blue_mod:OnIntervalThink()
	if IsServer() then
		if self:GetParent():IsIllusion() then return end
		self.PosA = self:GetParent():GetAbsOrigin()
		local vDiff = self.PosA - self.PosB
		if self:GetParent():IsCourier() then
		self:GetParent():DropItemAtPositionImmediate(self:GetAbility(), self.Return_vPos)
		end
		if vDiff:Length2D() > 350 then
			self:DropIt()
		else
			self.PosB = self:GetParent():GetAbsOrigin()
			self:CheckTeam()
			self:CheckForGoal()
		end
	end
end

function flag_blue_mod:DropIt()
	local vPoint = self.PosB
	local hItem = self:GetAbility()
	local hCaster = self:GetParent()
		if self:GetParent():GetTeam() == DOTA_TEAM_BADGUYS then
			Notifications:TopToAll({text="Dire Has Dropped The Flag!", duration=2.0})
		end
	hCaster:DropItemAtPositionImmediate(hItem, vPoint)
end

function flag_blue_mod:CheckForGoal()
	local hItem = self:GetAbility()
	local hCaster = self:GetParent()
	local sMod = "flag_goal_red_mod"
	if hCaster:GetTeam() == DOTA_TEAM_BADGUYS then
		if hCaster:HasModifier(sMod) then
			print("goal!")
			self:GoalEvent()
			local hGoalBlue = Entities:FindByName(nil, "gamemode_ctf_blue")
			local vPoint = hGoalBlue:GetAbsOrigin()
			hCaster:DropItemAtPositionImmediate(hItem, vPoint)
		end
	end
end

function flag_blue_mod:CheckTeam()
	local hCaster = self:GetParent()
	if hCaster:GetTeam() == DOTA_TEAM_GOODGUYS then
		local sMod = "flag_goal_blue_mod"
		local hGoalBlue = Entities:FindByName(nil, "gamemode_ctf_blue")
		local vPoint = hGoalBlue:GetAbsOrigin()
		hCaster:DropItemAtPositionImmediate(self:GetAbility(), vPoint)
		if not hCaster:HasModifier(sMod) then
		Notifications:TopToAll({text="Radiant Flag Returned!", duration=2.0})	
		end
	end
end


function flag_blue_mod:GoalEvent()
	local hCaster = self:GetParent()
	local iTeam = hCaster:GetTeam()
	local pID = hCaster:GetPlayerID() 
	GameRules.Caps[iTeam] = GameRules.Caps[iTeam] + 1
	GameRules:GetGameModeEntity():SetTopBarTeamValue(iTeam, GameRules.Caps[iTeam]) 
	local to_win = 10 - GameRules.Caps[iTeam]
	Notifications:TopToAll({text="Dire Has Captured The Flag!", duration=2.0})	
	Notifications:TopToAll({text="Dire Need " .. to_win .. " More To Win!", duration=2.0})	
	EmitGlobalSound("Hero_LegionCommander.Duel.Cast")
	if GameRules.Caps[iTeam] > 9 then
      GameRules:SetSafeToLeave( true )
      GameRules:SetGameWinner( iTeam )
	end
end




