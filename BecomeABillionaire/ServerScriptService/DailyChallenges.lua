-- Daily Challenges System
-- Provides daily tasks and rewards for extended gameplay

local DailyChallenges = {}

local Challenges = {
	{id = "earn_1k", name = "Money Maker", description = "Earn $1,000", reward = 500, goal = 1000, type = "money"},
	{id = "level_up_5", name = "Leveler", description = "Reach Level 5", reward = 1000, goal = 5, type = "level"},
	{id = "play_games_3", name = "Game Master", description = "Play 3 mini-games", reward = 2000, goal = 3, type = "games"},
	{id = "buy_3_upgrades", name = "Shopper", description = "Buy 3 upgrades", reward = 1500, goal = 3, type = "upgrades"},
	{id = "prestige_1", name = "Rising Star", description = "Reach Prestige Level", reward = 5000, goal = 1, type = "prestige"},
	{id = "reach_50k", name = "Big Spender", description = "Have $50,000", reward = 2500, goal = 50000, type = "wealth"},
}

function DailyChallenges.CheckChallenge(player, challengeId)
	local challenge = nil
	for _, c in ipairs(Challenges) do
		if c.id == challengeId then
			challenge = c
			break
		end
	end
	
	if not challenge then return false end
	
	-- Check if already completed today
	local lastCompleted = player:GetAttribute("ChallengeCompleted_" .. challengeId) or 0
	local now = os.time()
	
	if now - lastCompleted < 86400 then
		return false, "Already completed today"
	end
	
	-- Check challenge goal
	local playerValue = 0
	if challenge.type == "money" then
		playerValue = player:GetAttribute("Money") or 0
	elseif challenge.type == "level" then
		playerValue = player:GetAttribute("Level") or 1
	elseif challenge.type == "prestige" then
		playerValue = player:GetAttribute("Prestige") or 0
	elseif challenge.type == "wealth" then
		playerValue = player:GetAttribute("Money") or 0
	end
	
	if playerValue >= challenge.goal then
		player:SetAttribute("Money", (player:GetAttribute("Money") or 0) + challenge.reward)
		player:SetAttribute("ChallengeCompleted_" .. challengeId, now)
		print(player.Name .. " completed challenge: " .. challenge.name)
		return true, "Challenge completed! Reward: $" .. challenge.reward
	else
		return false, "Goal not reached"
	end
end

function DailyChallenges.GetAllChallenges()
	return Challenges
end

function DailyChallenges.GetDailyChallenges()
	-- Shuffle challenges for variety
	local dailyChallenges = {}
	local indices = {}
	for i = 1, #Challenges do
		table.insert(indices, i)
	end
	
	-- Shuffle
	for i = #indices, 2, -1 do
		local j = math.random(i)
		indices[i], indices[j] = indices[j], indices[i]
	end
	
	-- Return first 3
	for i = 1, math.min(3, #indices) do
		table.insert(dailyChallenges, Challenges[indices[i]])
	end
	
	return dailyChallenges
end

return DailyChallenges
