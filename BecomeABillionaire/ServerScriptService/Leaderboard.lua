-- Leaderboard System
-- Tracks player statistics and rankings

local Leaderboard = {}
local Players = game:GetService("Players")

function Leaderboard.GetTopPlayers(limit)
	limit = limit or 10
	local playerStats = {}
	
	for _, player in pairs(Players:GetPlayers()) do
		table.insert(playerStats, {
			name = player.Name,
			money = player:GetAttribute("Money") or 0,
			level = player:GetAttribute("Level") or 1,
			prestige = player:GetAttribute("Prestige") or 0,
			achievements = player:GetAttribute("EarnedAchievements") or {}
		})
	end
	
	-- Sort by money
	table.sort(playerStats, function(a, b) return a.money > b.money end)
	
	-- Return top players
	local topPlayers = {}
	for i = 1, math.min(limit, #playerStats) do
		table.insert(topPlayers, playerStats[i])
	end
	
	return topPlayers
end

function Leaderboard.GetPlayerRank(player)
	local topPlayers = Leaderboard.GetTopPlayers(1000)
	
	for rank, playerData in ipairs(topPlayers) do
		if playerData.name == player.Name then
			return rank
		end
	end
	
	return #topPlayers + 1
end

function Leaderboard.GetPlayerStats(player)
	return {
		name = player.Name,
		money = player:GetAttribute("Money") or 0,
		level = player:GetAttribute("Level") or 1,
		prestige = player:GetAttribute("Prestige") or 0,
		achievements = player:GetAttribute("EarnedAchievements") or {},
		rank = Leaderboard.GetPlayerRank(player)
	}
end

function Leaderboard.PrintLeaderboard()
	local topPlayers = Leaderboard.GetTopPlayers(10)
	
	print("=== LEADERBOARD ===")
	for rank, playerData in ipairs(topPlayers) do
		local moneyStr = "$" .. string.format("%,.0f", playerData.money)
		print(rank .. ". " .. playerData.name .. " - " .. moneyStr .. " (Level " .. playerData.level .. ")")
	end
end

function Leaderboard.UpdateLeaderboardDisplay()
	-- Update leaderboard every 30 seconds
	while true do
		wait(30)
		Leaderboard.PrintLeaderboard()
	end
end

return Leaderboard
