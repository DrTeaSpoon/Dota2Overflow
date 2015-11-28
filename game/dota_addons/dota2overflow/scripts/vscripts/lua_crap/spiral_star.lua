function( hPoint, hAbility, hCaster  )
	print("Star!")
	local units = 5
	local unit_name = hAbility.CurrentUnit
	local center = hPoint
	local radius = 25*units
	local count = units
	local fwdVec = hCaster:GetForwardVector()
	
	local v_x = 0
	local v_y = 0
	local v_len2 = v_x*v_x + v_y*v_y;
	if v_len2 > 0.001 then
		local v_len = math.sqrt( v_len2 )
		v_x = v_x / v_len
		v_y = v_y / v_len
	else
		v_x = 1
		v_y = 0
	end
	
	
	v_x = v_x * radius
	v_y = v_y * radius
	local point_list = {}
	local unit_list = {}
	local hUnit = false
	local prev_point = false
	
		for i = 1, units do
			for t = 1,4 do
			local theta = (math.pi * 2) * ( ( i - 1 + t*t/20 ) / count )
			local p_x = math.cos( theta ) * v_x + math.sin( theta ) * v_y
			local p_y = -math.sin( theta ) * v_x + math.cos( theta ) * v_y
			local v = center + Vector( p_x*(t/2), p_y*(t/2), 0 )
			
			hUnit = CreateUnitByName(unit_name, v, false, hCaster, hCaster, hCaster:GetTeamNumber() ) 
			local abnum = hUnit:GetAbilityCount() -1
				for m = 0,abnum do 
					local ab = hUnit:GetAbilityByIndex(m)
					if ab then
					ab:SetLevel(ab:GetMaxLevel() )
					end
				end
			
			
			hUnit:SetForwardVector(hPoint-v)
			hUnit:AddNewModifier(hCaster, nil, "modifier_kill", {duration = 10})
			hUnit:AddNewModifier( hCaster, hAbility, "item_bug_staff_target_modifier", { } )
			end
		end
	end