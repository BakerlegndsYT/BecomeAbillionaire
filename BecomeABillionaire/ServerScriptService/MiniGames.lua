-- Mini-Games Module
-- Provides various mini-games to earn money

local MiniGames = {}

-- CLICKER GAME: Tap to earn money
function MiniGames.ClickerGame(player, duration)
	duration = duration or 10
	local startMoney = player:GetAttribute("Money") or 0
	local clicks = 0
	local gameActive = true
	
	-- Simulate clicks per second (difficulty increases with level)
	local baseClick = (player:GetAttribute("Level") or 1) * 5
	
	for i = 1, duration do
		wait(1)
		clicks = clicks + baseClick + math.random(-5, 10)
		if not gameActive then break end
	end
	
	local earnings = math.max(0, clicks)
	player:SetAttribute("Money", startMoney + earnings)
	
	return earnings
end

-- LUCKY SPIN: Random money multiplier
function MiniGames.LuckySpin(player)
	local currentMoney = player:GetAttribute("Money") or 0
	local spinResults = {0.5, 1, 1.5, 2, 2.5, 3, 0.1} -- Last one is "bankrupt"
	
	local randomResult = spinResults[math.random(1, #spinResults)]
	local newMoney = currentMoney * randomResult
	
	player:SetAttribute("Money", newMoney)
	player:SetAttribute("Experience", (player:GetAttribute("Experience") or 0) + 10)
	
	return newMoney - currentMoney
end

-- INVESTOR CHALLENGE: Buy and sell stocks
function MiniGames.InvestorChallenge(player, initialInvestment)
	initialInvestment = initialInvestment or math.min(1000, (player:GetAttribute("Money") or 0) * 0.1)
	local currentMoney = player:GetAttribute("Money") or 0
	
	if currentMoney < initialInvestment then
		return 0
	end
	
	-- Remove initial investment
	player:SetAttribute("Money", currentMoney - initialInvestment)
	
	-- Random market return (30-200%)
	local returnPercentage = math.random(30, 200) / 100
	local profit = initialInvestment * returnPercentage
	
	player:SetAttribute("Money", (player:GetAttribute("Money") or 0) + initialInvestment + profit)
	player:SetAttribute("Experience", (player:GetAttribute("Experience") or 0) + 25)
	
	return profit
end

-- BUSINESS SIMULATION: Run a business for set time
function MiniGames.BusinessSimulation(player, duration)
	duration = duration or 15
	local level = player:GetAttribute("Level") or 1
	local startMoney = player:GetAttribute("Money") or 0
	local totalEarnings = 0
	
	-- Generate random business events
	for i = 1, duration do
		wait(1)
		
		local luck = math.random(1, 100)
		if luck > 70 then -- 30% chance of good event
			local gain = level * 20
			totalEarnings = totalEarnings + gain
		elseif luck < 10 then -- 10% chance of bad event
			local loss = level * 10
			totalEarnings = totalEarnings - loss
		else -- Normal business
			local normal = level * 5
			totalEarnings = totalEarnings + normal
		end
	end
	
	player:SetAttribute("Money", startMoney + totalEarnings)
	player:SetAttribute("Experience", (player:GetAttribute("Experience") or 0) + 50)
	
	return totalEarnings
end

-- UPGRADE SYSTEM: Purchase upgrades to boost income
function MiniGames.PurchaseUpgrade(player, upgradeName, cost)
	local currentMoney = player:GetAttribute("Money") or 0
	
	if currentMoney < cost then
		return false, "Not enough money"
	end
	
	player:SetAttribute("Money", currentMoney - cost)
	
	-- Store upgrades as an attribute (in a real game, use a more robust system)
	local level = player:GetAttribute("Level") or 1
	player:SetAttribute("Level", level + 1)
	
	return true, "Upgrade purchased!"
end

return MiniGames
