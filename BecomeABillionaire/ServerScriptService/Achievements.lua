-- Achievements System
-- Tracks and rewards player milestones

local Achievements = {}

local AchievementList = {
	{id = "first_hundred", name = "Penny Pincher", description = "Earn $100", reward = 50, checkFn = function(p) return (p:GetAttribute("Money") or 0) >= 100 end},
	{id = "first_thousand", name = "Entrepreneur", description = "Earn $1,000", reward = 200, checkFn = function(p) return (p:GetAttribute("Money") or 0) >= 1000 end},
	{id = "first_million", name = "Millionaire", description = "Earn $1,000,000", reward = 5000, checkFn = function(p) return (p:GetAttribute("Money") or 0) >= 1000000 end},
	{id = "first_billion", name = "Billionaire", description = "Earn $1,000,000,000", reward = 50000, checkFn = function(p) return (p:GetAttribute("Money") or 0) >= 1000000000 end},
	{id = "level_10", name = "Seasoned Pro", description = "Reach Level 10", reward = 1000, checkFn = function(p) return (p:GetAttribute("Level") or 0) >= 10 end},
	{id = "level_50", name = "Master Tycoon", description = "Reach Level 50", reward = 10000, checkFn = function(p) return (p:GetAttribute("Level") or 0) >= 50 end},
	{id = "prestige_1", name = "Rising Star", description = "Reach Prestige 1", reward = 100000, checkFn = function(p) return (p:GetAttribute("Prestige") or 0) >= 1 end},
}

function Achievements.CheckAchievements(player)
	for _, ach in ipairs(AchievementList) do
		if ach.checkFn(player) then
			local earnedAchs = player:GetAttribute("EarnedAchievements") or {}
			if not table.find(earnedAchs, ach.id) then
				table.insert(earnedAchs, ach.id)
				player:SetAttribute("EarnedAchievements", earnedAchs)
				player:SetAttribute("Money", (player:GetAttribute("Money") or 0) + ach.reward)
				print(player.Name .. " unlocked achievement: " .. ach.name .. "! Reward: $" .. ach.reward)
			end
		end
	end
end

function Achievements.GetAchievements()
	return AchievementList
end

return Achievements
