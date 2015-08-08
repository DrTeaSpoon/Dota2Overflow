if item_lua_blink_staff == nil then
	item_lua_blink_staff = class({})
end

LinkLuaModifier( "item_lua_blink_staff_blink_modifier", "lua_items/item_lua_blink_staff_blink_modifier.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "item_lua_blink_staff_effect_modifier", "lua_items/item_lua_blink_staff_effect_modifier.lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "item_lua_blink_staff_stats_modifier", "lua_items/item_lua_blink_staff_stats_modifier.lua", LUA_MODIFIER_MOTION_NONE )

function item_lua_blink_staff:OnSpellStart()
	local hCaster = self:GetCaster()
	local hTarget = self:GetCursorTarget()
	local hPoint = self:GetCursorPosition()
	if hTarget and hTarget ~= hCaster then
	--Add blink mod!
		local id = hTarget:GetEntityIndex() 
		hCaster:AddNewModifier( hCaster, self, "item_lua_blink_staff_blink_modifier", { duration = 5 } )
		hCaster:SetModifierStackCount("item_lua_blink_staff_blink_modifier", hCaster, id) 
		hTarget:AddNewModifier( hCaster, self, "item_lua_blink_staff_effect_modifier", { duration = 5 } )
		self:EndCooldown()
		self:RefundManaCost() 
	else
	local vColor = Vector(RandomInt(0, 255),RandomInt(0, 255),RandomInt(0, 255))
	--Lets blink!
		if not hCaster:HasModifier("item_lua_blink_staff_blink_modifier") then
			--Self Blink
			
			ProjectileManager:ProjectileDodge(hCaster)  --Disjoints disjointable incoming projectiles.
			local nFXIndex = ParticleManager:CreateParticle("particles/generic_blink_start.vpcf", PATTACH_ABSORIGIN, hCaster)
			ParticleManager:SetParticleControl( nFXIndex, 15, vColor)
			--PrecacheResource( "particle", "particles/generic_blink_end.vpcf", context )
			--PrecacheResource( "particle", "particles/generic_blink_start.vpcf", context )
			hCaster:EmitSound("DOTA_Item.BlinkDagger.Activate")
			
			local origin_point = hCaster:GetAbsOrigin()
			local target_point = hPoint
			local difference_vector = target_point - origin_point
			local max_blink = self:GetSpecialValueFor( "max_blink" )
			local blink_clamp = self:GetSpecialValueFor( "max_blink_clamp" )
			if difference_vector:Length2D() > max_blink then  --Clamp the target point to the BlinkRangeClamp range in the same direction.
				target_point = origin_point + (target_point - origin_point):Normalized() * blink_clamp
			end
			
			hCaster:SetAbsOrigin(target_point)
			FindClearSpaceForUnit(hCaster, target_point, false)
			
			local nFXIndex = ParticleManager:CreateParticle("particles/generic_blink_end.vpcf", PATTACH_ABSORIGIN, hCaster)
			ParticleManager:SetParticleControl( nFXIndex, 15, vColor)
		else
			--ID Blink
			local ent_id = hCaster:GetModifierStackCount("item_lua_blink_staff_blink_modifier", hCaster) 
			local ent = EntIndexToHScript(ent_id)
			
			ProjectileManager:ProjectileDodge(ent)  --Disjoints disjointable incoming projectiles.
			local nFXIndex = ParticleManager:CreateParticle("particles/generic_blink_start.vpcf", PATTACH_ABSORIGIN, ent)
			ParticleManager:SetParticleControl( nFXIndex, 15, vColor)
			ent:EmitSound("DOTA_Item.BlinkDagger.Activate")
			
			local origin_point = ent:GetAbsOrigin()
			local target_point = hPoint
			local difference_vector = target_point - origin_point
			local max_blink = self:GetSpecialValueFor( "max_blink" )
			local blink_clamp = self:GetSpecialValueFor( "max_blink_clamp" )
			if difference_vector:Length2D() > max_blink then  --Clamp the target point to the BlinkRangeClamp range in the same direction.
				target_point = origin_point + (target_point - origin_point):Normalized() * blink_clamp
			end
			
			ent:SetAbsOrigin(target_point)
			FindClearSpaceForUnit(ent, target_point, false)
			
			local nFXIndex = ParticleManager:CreateParticle("particles/generic_blink_end.vpcf", PATTACH_ABSORIGIN, ent)
			ParticleManager:SetParticleControl( nFXIndex, 15, vColor)
			
			ent:RemoveModifierByNameAndCaster("item_lua_blink_staff_effect_modifier", hCaster) 
		end
	
	end
end

function item_lua_blink_staff:GetManaCost()
	return 50
end


function item_lua_blink_staff:GetCooldown( nLevel )
	return 15
end

function item_lua_blink_staff:GetAOERadius()
	return self:GetSpecialValueFor( "max_blink" )
end

function item_lua_blink_staff:GetIntrinsicModifierName()
	return "item_lua_blink_staff_stats_modifier"
end


