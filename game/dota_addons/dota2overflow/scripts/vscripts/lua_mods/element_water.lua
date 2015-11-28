if element_water == nil then
	element_water = class({})
end

function element_water:OnCreated( kv )	
	if IsServer() then
		self.nFXIndex = ParticleManager:CreateParticle( "particles/econ/courier/courier_flopjaw/courier_flopjaw_ambient_water.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
		self:AddParticle( self.nFXIndex, false, false, -1, false, false )
	end
end

function element_water:OnRefresh( kv )	
	if IsServer() then
	
	end
end

function element_water:IsHidden()
	return false
end

function element_water:GetAttributes()
	return MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_MULTIPLE
end

function element_water:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
 
	return funcs
end

function element_water:GetModifierPhysicalArmorBonus()
	return self:GetParent():GetLevel()
end


function element_water:GetTexture()
	return "element_water"
end