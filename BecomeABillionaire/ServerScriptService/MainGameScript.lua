-- Become A Billionaire - Main Game Server Script
-- This script manages the core game loop and player initialization

local Players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local playerDataStore = DataStoreService:GetDataStore("PlayerData")

-- Game Configuration
local STARTING_MONEY = 100
local SAVE_INTERVAL = 30

-- Initialize player data
local function initializePlayer(player)
	local success, playerData = pcall(function()
		return playerDataStore:GetAsync(player.UserId)
	end)
	
	if success and playerData then
		player:SetAttribute("Money", playerData.money)
		player:SetAttribute("Level", playerData.level)
		player:SetAttribute("Experience", playerData.experience)
		player:SetAttribute("Prestige", playerData.prestige)
	else
		player:SetAttribute("Money", STARTING_MONEY)
		player:SetAttribute("Level", 1)
		player:SetAttribute("Experience", 0)
		player:SetAttribute("Prestige", 0)
	end
	
	print("Player " .. player.Name .. " initialized with $" .. player:GetAttribute("Money"))
end

-- Save player data
local function savePlayer(player)
	local playerData = {
		money = player:GetAttribute("Money"),
		level = player:GetAttribute("Level"),
		experience = player:GetAttribute("Experience"),
		prestige = player:GetAttribute("Prestige")
	}
	
	local success, err = pcall(function()
		playerDataStore:SetAsync(player.UserId, playerData)
	end)
	
	if not success then
		warn("Failed to save player data: " .. err)
	end
end

-- Passive income system
local function givePassiveIncome(player)
	while player.Parent do
		wait(5)
		local level = player:GetAttribute("Level") or 1
		local incomePerSecond = level * 2 + (player:GetAttribute("Prestige") or 0) * 50
		player:SetAttribute("Money", (player:GetAttribute("Money") or 0) + incomePerSecond)
	end
end

-- Player connections
Players.PlayerAdded:Connect(function(player)
	initializePlayer(player)
	task.spawn(function() givePassiveIncome(player) end)
end)

Players.PlayerRemoving:Connect(function(player)
	savePlayer(player)
end)

-- Auto-save loop
while true do
	wait(SAVE_INTERVAL)
	for _, player in pairs(Players:GetPlayers()) do
		savePlayer(player)
	end
end
