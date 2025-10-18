-- Property System
-- Allows players to own and manage businesses and properties

local PropertySystem = {}

local Properties = {
	{name = "Small Store", cost = 10000, income = 50},
	{name = "Restaurant", cost = 50000, income = 150},
	{name = "Shopping Mall", cost = 200000, income = 500},
	{name = "Office Building", cost = 1000000, income = 2000},
	{name = "Casino", cost = 5000000, income = 5000},
	{name = "Theme Park", cost = 20000000, income = 10000},
	{name = "City District", cost = 100000000, income = 50000},
	{name = "Resort Island", cost = 500000000, income = 100000},
}

function PropertySystem.BuyProperty(player, propertyIndex)
	local property = Properties[propertyIndex]
	if not property then return false, "Property not found" end
	
	local currentMoney = player:GetAttribute("Money") or 0
	if currentMoney < property.cost then
		return false, "Not enough money"
	end
	
	-- Deduct cost
	player:SetAttribute("Money", currentMoney - property.cost)
	
	-- Add property to player's collection
	local playerProperties = player:GetAttribute("OwnedProperties") or {}
	table.insert(playerProperties, {name = property.name, income = property.income, bought = os.time()})
	player:SetAttribute("OwnedProperties", playerProperties)
	
	print(player.Name .. " bought " .. property.name .. "!")
	return true, "Property purchased!"
end

function PropertySystem.GetPropertyIncome(player)
	local playerProperties = player:GetAttribute("OwnedProperties") or {}
	local totalIncome = 0
	
	for _, prop in ipairs(playerProperties) do
		totalIncome = totalIncome + prop.income
	end
	
	return totalIncome
end

function PropertySystem.CollectPropertyIncome(player)
	local incomePerCycle = PropertySystem.GetPropertyIncome(player)
	player:SetAttribute("Money", (player:GetAttribute("Money") or 0) + incomePerCycle)
	return incomePerCycle
end

function PropertySystem.GetAvailableProperties()
	return Properties
end

function PropertySystem.SellProperty(player, propertyIndex)
	local playerProperties = player:GetAttribute("OwnedProperties") or {}
	
	if propertyIndex > #playerProperties then
		return false, "Property not owned"
	end
	
	-- Sell at 60% of original value
	local property = playerProperties[propertyIndex]
	local salePrice = Properties[propertyIndex].cost * 0.6
	
	player:SetAttribute("Money", (player:GetAttribute("Money") or 0) + salePrice)
	table.remove(playerProperties, propertyIndex)
	player:SetAttribute("OwnedProperties", playerProperties)
	
	return true, "Property sold for $" .. salePrice
end

return PropertySystem
