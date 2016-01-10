if item_ovf_book_eldri == nil then
	item_ovf_book_eldri = class({})
end

LinkLuaModifier( "book_eldri_modifier", "lua_items/overflow/basics/eldri_book.lua", LUA_MODIFIER_MOTION_NONE )

function item_ovf_book_eldri:GetBehavior() 
	local behav = DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_CHANNELLED
	return behav
end

function item_ovf_book_eldri:OnSpellStart()
	 self.start_time = GameRules:GetGameTime()
	 self.cc_interval = self:GetSpecialValueFor("think_interval")
	 self.cc_timer = 0
end

function item_ovf_book_eldri:OnChannelThink(flInterval)
	self.cc_timer = self.cc_timer + flInterval
	 if self.cc_timer >= self.cc_interval then
		self.cc_timer = self.cc_timer - self.cc_interval
		 self:CustomChannelThink()
	 end
end

 function item_ovf_book_eldri:CustomChannelThink()
	self:GetCaster():SetBaseIntellect(self:GetCaster():GetBaseIntellect() + 1)
	EmitSoundOn( "Hero_Omniknight.GuardianAngel", self:GetCaster() )
	self:GetCaster():CalculateStatBonus()
 end

 
function item_ovf_book_eldri:OnChannelFinish(bInterrupted)
	local hCaster = self:GetCaster()
--	local bFound = false
--	local bHasModifier = hCaster:HasModifier("book_eldri_modifier")
--	local bTreshold = false
--	if bHasModifier then
--		bTreshold = (hCaster:FindModifierByName("book_eldri_modifier"):GetStackCount() > 5)
--	end
--	if bTreshold == false then
--		while bFound == false do
--			local nAbId = RandomInt(1,6)
--			if hCaster:GetAbilityByIndex(nAbId) then
--				hCaster:SetAbilityPoints(hCaster:GetAbilityPoints() + hCaster:GetAbilityByIndex(nAbId):GetLevel())
--				hCaster:RemoveAbility(hCaster:GetAbilityByIndex(nAbId):GetAbilityName())
--				bFound = true
--			end
--		end
--	else
--		if hCaster:FindModifierByName("book_eldri_modifier"):GetStackCount() == 6 then
if bInterrupted then
	self:GetCaster():RemoveItem(self)
else
	GameRules:SetCustomGameTeamMaxPlayers(DOTA_TEAM_CUSTOM_1, 10)
	hCaster:SetTeam(DOTA_TEAM_CUSTOM_1)
	PlayerResource:SetCustomTeamAssignment(hCaster:GetPlayerOwnerID(), DOTA_TEAM_CUSTOM_1)
	hCaster:AddNewModifier( hCaster, self, "book_eldri_modifier", { stacks = 1 } )
end
--			PrecacheItemByNameAsync("eat_tree_eldri", function()
--				hCaster:AddAbility("eat_tree_eldri")
--			end)
--		end
--		
--		if hCaster:FindModifierByName("book_eldri_modifier"):GetStackCount() == 7 then
--			PrecacheItemByNameAsync("missile_eldri", function()
--				hCaster:AddAbility("missile_eldri")
--			end)
--		end
--		
--		if hCaster:FindModifierByName("book_eldri_modifier"):GetStackCount() == 8 then
--			PrecacheItemByNameAsync("eldri_step", function()
--				hCaster:AddAbility("eldri_step")
--			end)
--		end
--		
--		if hCaster:FindModifierByName("book_eldri_modifier"):GetStackCount() == 9 then
--			PrecacheItemByNameAsync("eldri_6_gon", function()
--				hCaster:AddAbility("eldri_6_gon")
--			end)
--		end
--		--
--		--if hCaster:FindModifierByName("book_eldri_modifier"):GetStackCount() == 10 then
--		--	PrecacheItemByNameAsync("eldri_step", function()
--		--		hCaster:AddAbility("eldri_step")
--		--	end)
--		--end
--		
--		if hCaster:FindModifierByName("book_eldri_modifier"):GetStackCount() == 11 then
--			PrecacheItemByNameAsync("master_eldri", function()
--				hCaster:AddAbility("master_eldri")
--			end)
--		end
--	end
end

function item_ovf_book_eldri:OnOwnerDied()
	self:SetPurchaser(nil)
	self:GetCaster():DropItemAtPositionImmediate(self, self:GetCaster():GetOrigin()) 
end