AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
self.Entity:SetModel("models/props_lab/crematorcase.mdl")
self.Entity:PhysicsInit(SOLID_VPHYSICS)
self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
self.Entity:SetSolid(SOLID_VPHYSICS)
self.Entity:SetUseType(SIMPLE_USE)

local phys = self.Entity:GetPhysicsObject()
if phys and phys:IsValid() then phys:Wake() end

self.Entity:SetNWBool("Usable", false)
self.Entity:SetNWBool("Plantable", true)
self.damage = 10

end

function ENT:OnTakeDamage(dmg)
	self.damage = self.damage - dmg:GetDamage()

	if (self.damage <= 0) then
		local effectdata = EffectData()
		effectdata:SetOrigin(self.Entity:GetPos())
		effectdata:SetMagnitude(2)
		effectdata:SetScale(2)
		effectdata:SetRadius(3)
		util.Effect("Sparks", effectdata)
		self.Entity:Remove()
	end
end

function ENT:Use()
	if self.Entity:GetNWBool("Usable") == true then
		self.Entity:SetNWBool("Usable", false)
		self.Entity:SetNWBool("Plantable", true)
		self.Entity:SetModel("models/props_lab/crematorcase.mdl")
		local SpawnPos = self.Entity:GetPos()
		local WeedBag = ents.Create("seed_weed")
		WeedBag:SetPos(SpawnPos + Vector(0,0,15))
		WeedBag:Spawn()
	end
end

function ENT:Touch(hitEnt)

	if hitEnt:GetClass() == "oil" then

		
		if self.Entity:GetNWBool("Plantable") == true then
			
			self.Entity:SetNWBool("Plantable", false)
			
			hitEnt:Remove()
			
			self.Entity:SetModel("models/props_lab/crematorcase.mdl")
			
			timer.Create("Stage2_"..self:EntIndex(), 1, 1, function()
				self.Entity:SetModel("models/props_lab/crematorcase.mdl")
			end)

			timer.Create("Stage3_"..self:EntIndex(), 2, 1, function()
				self.Entity:SetModel("models/props_lab/crematorcase.mdl")
			end)

			timer.Create("Stage4_"..self:EntIndex(), 3, 1, function()
				self.Entity:SetModel("models/props_lab/crematorcase.mdl")
			end)

			timer.Create("Stage5_"..self:EntIndex(), 4, 1, function()
				self.Entity:SetModel("models/props_lab/crematorcase.mdl")
			end)

			timer.Create("Stage6_"..self:EntIndex(), 5, 1, function()
				self.Entity:SetModel("models/props_lab/crematorcase.mdl")
			end)

			timer.Create("Stage7_"..self:EntIndex(), 6, 1, function()
				self.Entity:SetModel("models/props_lab/crematorcase.mdl")
			end)

			timer.Create("Stage8_"..self:EntIndex(), 7, 1, function()
				self.Entity:SetModel("models/props_lab/crematorcase.mdl")
				self.Entity:SetNWBool("Usable", true)
			end)

		end

	end

end

function ENT:OnRemove()

	if self.Entity:GetNWBool("Plantable") == false then
		timer.Destroy("Stage2")
		timer.Destroy("Stage3")
		timer.Destroy("Stage4")
		timer.Destroy("Stage5")
		timer.Destroy("Stage6")
		timer.Destroy("Stage7")
		timer.Destroy("Stage8")
	end

end 