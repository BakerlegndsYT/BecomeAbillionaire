-- Special Events System
-- Provides random events and challenges for extended gameplay

local SpecialEvents = {}

local Events = {
	{name = "Market Boom", effect = 2, description = "All income doubled for 30 seconds"},
	{name = "Stock Crash", effect = 0.5, description = "Income halved for 30 seconds"},
	{name = "Lottery Win", effect = 10, description = "Random player wins $10,000"},
	{name = "Tax Season", effect = 0.9, description = "Pay 10% taxes"},
	{name = "Investors Call", effect = 1.5, description = "Investors increase funding by 50%"},
	{name = "Recession", effect = 0.7, description = "Economic downturn reduces income"},
	{name = "Promotion", effect = 1.3, description = "Get a promotion! Income +30%"},
	{name = "Strike", effect = 0, description = "Workers strike, no income for 20 seconds"},
	{name = "Patent Success", effect = 1.2, description = "Patent monetized, +20% income"},
	{name = "Equipment Failure", effect = 0.8, description = "Equipment needs repair, -20% income"},
}

function SpecialEvents.TriggerRandomEvent(player)
	local randomEvent = Events[math.random(1, #Events)]
	local currentMoney = player:GetAttribute("Money") or 0
	
	if randomEvent.effect == 0 then
		-- No income for a period
		wait(20)
	else
		-- Apply multiplier
		player:SetAttribute("Money", currentMoney * randomEvent.effect)
	end
	
	print(player.Name .. " triggered event: " .. randomEvent.name)
	return randomEvent.name
end

function SpecialEvents.StartEventLoop(player)
	while player.Parent do
		wait(math.random(60, 180)) -- Random event every 1-3 minutes
		if math.random(1, 100) > 70 then -- 30% chance
			task.spawn(function() SpecialEvents.TriggerRandomEvent(player) end)
		end
	end
end

-- PRESTIGE SYSTEM: Reset with bonus
function SpecialEvents.ActivatePrestige(player)
	local currentPrestige = player:GetAttribute("Prestige") or 0
	local level = player:GetAttribute("Level") or 1
	
	-- Can prestige after reaching level 20
	if level < 20 then
		return false, "Need Level 20 to prestige"
	end
	
	-- Grant prestige bonus
	local prestigeBonus = currentPrestige * 50000 + level * 10000
	player:SetAttribute("Money", prestigeBonus)
	player:SetAttribute("Level", 1)
	player:SetAttribute("Experience", 0)
	player:SetAttribute("Prestige", currentPrestige + 1)
	
	print(player.Name .. " is now Prestige " .. (currentPrestige + 1) .. "!")
	return true, "Prestige activated! Money: $" .. prestigeBonus
end

return SpecialEvents
