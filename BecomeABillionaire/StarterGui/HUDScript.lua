-- Become A Billionaire - Client HUD Script
-- Displays money, level, and game information to the player

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create main HUD
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MainHUD"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Money display
local moneyLabel = Instance.new("TextLabel")
moneyLabel.Name = "MoneyLabel"
moneyLabel.Size = UDim2.new(0, 300, 0, 60)
moneyLabel.Position = UDim2.new(0, 20, 0, 20)
moneyLabel.BackgroundColor3 = Color3.fromRGB(46, 125, 50)
moneyLabel.BackgroundTransparency = 0.3
moneyLabel.TextColor3 = Color3.new(1, 1, 1)
moneyLabel.TextSize = 32
moneyLabel.Font = Enum.Font.GothamBold
moneyLabel.TextStrokeTransparency = 0.5
moneyLabel.Parent = screenGui

-- Level display
local levelLabel = Instance.new("TextLabel")
levelLabel.Name = "LevelLabel"
levelLabel.Size = UDim2.new(0, 200, 0, 50)
levelLabel.Position = UDim2.new(0, 20, 0, 100)
levelLabel.BackgroundColor3 = Color3.fromRGB(25, 118, 210)
levelLabel.BackgroundTransparency = 0.3
levelLabel.TextColor3 = Color3.new(1, 1, 1)
levelLabel.TextSize = 28
levelLabel.Font = Enum.Font.GothamBold
levelLabel.TextStrokeTransparency = 0.5
levelLabel.Parent = screenGui

-- Prestige display
local prestigeLabel = Instance.new("TextLabel")
prestigeLabel.Name = "PrestigeLabel"
prestigeLabel.Size = UDim2.new(0, 200, 0, 50)
prestigeLabel.Position = UDim2.new(0, 20, 0, 160)
prestigeLabel.BackgroundColor3 = Color3.fromRGB(156, 39, 176)
prestigeLabel.BackgroundTransparency = 0.3
prestigeLabel.TextColor3 = Color3.new(1, 1, 1)
prestigeLabel.TextSize = 24
prestigeLabel.Font = Enum.Font.Gotham
prestigeLabel.TextStrokeTransparency = 0.5
prestigeLabel.Parent = screenGui

-- Shop button
local shopButton = Instance.new("TextButton")
shopButton.Name = "ShopButton"
shopButton.Size = UDim2.new(0, 120, 0, 50)
shopButton.Position = UDim2.new(1, -140, 0, 20)
shopButton.BackgroundColor3 = Color3.fromRGB(255, 152, 0)
shopButton.TextColor3 = Color3.new(1, 1, 1)
shopButton.TextSize = 20
shopButton.Font = Enum.Font.GothamBold
shopButton.Text = "Shop"
shopButton.Parent = screenGui

-- Mini-game button
local miniGameButton = Instance.new("TextButton")
miniGameButton.Name = "MiniGameButton"
miniGameButton.Size = UDim2.new(0, 120, 0, 50)
miniGameButton.Position = UDim2.new(1, -140, 0, 80)
miniGameButton.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
miniGameButton.TextColor3 = Color3.new(1, 1, 1)
miniGameButton.TextSize = 18
miniGameButton.Font = Enum.Font.GothamBold
miniGameButton.Text = "Mini-Game"
miniGameButton.Parent = screenGui

-- Update loop
local function updateHUD()
	while true do
		wait(0.5)
		local money = player:GetAttribute("Money") or 0
		local level = player:GetAttribute("Level") or 1
		local prestige = player:GetAttribute("Prestige") or 0
		
		moneyLabel.Text = "$" .. string.format("%,.0f", money)
		levelLabel.Text = "Level " .. level
		prestigeLabel.Text = "⭐ Prestige: " .. prestige
	end
end

task.spawn(updateHUD)

-- Button interactions
shopButton.MouseButton1Click:Connect(function()
	print("Shop opened!")
end)

miniGameButton.MouseButton1Click:Connect(function()
	print("Mini-game started!")
end)
