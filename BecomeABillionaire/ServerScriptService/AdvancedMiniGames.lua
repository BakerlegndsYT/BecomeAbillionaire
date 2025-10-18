-- Advanced Mini-Games
-- More complex and engaging mini-games for extended gameplay

local AdvancedMiniGames = {}

-- POKER GAME: Betting system with risk/reward
function AdvancedMiniGames.Poker(player, initialBet)
	initialBet = initialBet or 100
	local currentMoney = player:GetAttribute("Money") or 0
	
	if currentMoney < initialBet then
		return 0, "Not enough money"
	end
	
	-- Deduct bet
	player:SetAttribute("Money", currentMoney - initialBet)
	
	-- Random poker outcome (simplistic)
	local outcome = math.random(1, 100)
	local winnings = 0
	
	if outcome > 80 then -- 20% win
		winnings = initialBet * 5 -- 5x multiplier
	elseif outcome > 50 then -- 30% break even
		winnings = initialBet
	else -- 50% lose
		winnings = 0
	end
	
	player:SetAttribute("Money", (player:GetAttribute("Money") or 0) + winnings)
	player:SetAttribute("Experience", (player:GetAttribute("Experience") or 0) + 15)
	
	return winnings - initialBet
end

-- REAL ESTATE FLIP: Buy low, sell high simulation
function AdvancedMiniGames.RealEstateFlip(player)
	local currentMoney = player:GetAttribute("Money") or 0
	local investmentAmount = math.min(5000, currentMoney * 0.2)
	
	if investmentAmount < 100 then
		return 0, "Not enough money"
	end
	
	-- Remove investment
	player:SetAttribute("Money", currentMoney - investmentAmount)
	
	-- Simulate market movement
	local marketTrend = math.random(-30, 50) -- -30% to +50%
	local marketMultiplier = 1 + (marketTrend / 100)
	local returnValue = investmentAmount * marketMultiplier
	local profit = returnValue - investmentAmount
	
	player:SetAttribute("Money", (player:GetAttribute("Money") or 0) + returnValue)
	player:SetAttribute("Experience", (player:GetAttribute("Experience") or 0) + 20)
	
	return profit
end

-- HIRING EMPLOYEES: Recruit and manage employees for income
function AdvancedMiniGames.HireEmployees(player, numEmployees)
	numEmployees = numEmployees or 5
	local level = player:GetAttribute("Level") or 1
	local costPerEmployee = 200 * level
	local totalCost = costPerEmployee * numEmployees
	
	local currentMoney = player:GetAttribute("Money") or 0
	if currentMoney < totalCost then
		return 0, "Not enough money"
	end
	
	-- Hire employees
	player:SetAttribute("Money", currentMoney - totalCost)
	
	-- Employees generate income
	local incomePerEmployee = 50 * level
	local totalIncome = incomePerEmployee * numEmployees
	
	player:SetAttribute("Money", (player:GetAttribute("Money") or 0) + totalIncome)
	player:SetAttribute("Experience", (player:GetAttribute("Experience") or 0) + 30)
	
	return totalIncome - totalCost
end

-- TRADING GAME: Buy and sell commodities
function AdvancedMiniGames.CommodityTrading(player)
	local currentMoney = player:GetAttribute("Money") or 0
	local tradeAmount = math.min(2000, currentMoney * 0.1)
	
	if tradeAmount < 100 then
		return 0, "Not enough money"
	end
	
	-- Remove trade capital
	player:SetAttribute("Money", currentMoney - tradeAmount)
	
	-- Simulate commodity price fluctuation
	local buyPrice = math.random(90, 100)
	local sellPrice = math.random(100, 120)
	local profit = (tradeAmount / buyPrice) * sellPrice - tradeAmount
	
	player:SetAttribute("Money", (player:GetAttribute("Money") or 0) + tradeAmount + profit)
	player:SetAttribute("Experience", (player:GetAttribute("Experience") or 0) + 25)
	
	return profit
end

-- FRANCHISE OPPORTUNITY: One-time large investment
function AdvancedMiniGames.FranchiseOpportunity(player, franchiseType)
	franchiseType = franchiseType or math.random(1, 3)
	local franchiseCosts = {5000, 15000, 50000}
	local franchiseReturns = {2, 3.5, 5}
	
	local cost = franchiseCosts[franchiseType] or 5000
	local multiplier = franchiseReturns[franchiseType] or 2
	
	local currentMoney = player:GetAttribute("Money") or 0
	if currentMoney < cost then
		return 0, "Not enough money"
	end
	
	-- Invest in franchise
	player:SetAttribute("Money", currentMoney - cost)
	
	-- Return on franchise (slightly random)
	local variance = math.random(80, 120) / 100
	local returnAmount = cost * multiplier * variance
	
	player:SetAttribute("Money", (player:GetAttribute("Money") or 0) + returnAmount)
	player:SetAttribute("Experience", (player:GetAttribute("Experience") or 0) + 50)
	
	return returnAmount - cost
end

-- LOTTO: Big risk, big reward
function AdvancedMiniGames.Lottery(player, ticketCost)
	ticketCost = ticketCost or 500
	local currentMoney = player:GetAttribute("Money") or 0
	
	if currentMoney < ticketCost then
		return 0, "Not enough money"
	end
	
	-- Buy ticket
	player:SetAttribute("Money", currentMoney - ticketCost)
	
	local luckRoll = math.random(1, 10000)
	local jackpot = 0
	
	if luckRoll == 1 then -- 0.01% chance jackpot
		jackpot = ticketCost * 10000
	elseif luckRoll <= 50 then -- 0.5% chance big win
		jackpot = ticketCost * 1000
	elseif luckRoll <= 500 then -- 5% chance win
		jackpot = ticketCost * 10
	else -- Lose
		jackpot = 0
	end
	
	player:SetAttribute("Money", (player:GetAttribute("Money") or 0) + jackpot)
	player:SetAttribute("Experience", (player:GetAttribute("Experience") or 0) + 5)
	
	return jackpot - ticketCost
end

return AdvancedMiniGames
