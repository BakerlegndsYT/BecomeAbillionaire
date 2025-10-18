-- Shop GUI Module
-- Provides an interactive shop for buying upgrades

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local ShopItems = {
	{name = "Better Tools", cost = 500, boost = 1.5},
	{name = "Office Upgrade", cost = 2000, boost = 2},
	{name = "Hiring Manager", cost = 5000, boost = 3},
	{name = "Marketing Team", cost = 15000, boost = 4},
	{name = "Company Fleet", cost = 50000, boost = 5},
	{name = "Real Estate", cost = 150000, boost = 7},
	{name = "Stock Portfolio", cost = 500000, boost = 10},
	{name = "Fortune 500", cost = 2000000, boost = 15},
}

local function createShopGUI()
	local shopGui = Instance.new("ScreenGui")
	shopGui.Name = "ShopGui"
	shopGui.ResetOnSpawn = false
	shopGui.Parent = playerGui
	
	-- Background
	local background = Instance.new("Frame")
	background.Name = "Background"
	background.Size = UDim2.new(0, 500, 0, 600)
	background.Position = UDim2.new(0.5, -250, 0.5, -300)
	background.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	background.BorderSizePixel = 0
	background.Parent = shopGui
	
	-- Title
	local titleLabel = Instance.new("TextLabel")
	titleLabel.Name = "Title"
	titleLabel.Size = UDim2.new(1, 0, 0, 50)
	titleLabel.BackgroundColor3 = Color3.fromRGB(255, 152, 0)
	titleLabel.TextColor3 = Color3.new(1, 1, 1)
	titleLabel.TextSize = 28
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.Text = "🛍️ SHOP"
	titleLabel.BorderSizePixel = 0
	titleLabel.Parent = background
	
	-- Scroll frame for items
	local scrollFrame = Instance.new("ScrollingFrame")
	scrollFrame.Name = "ItemsScroll"
	scrollFrame.Size = UDim2.new(1, -20, 1, -70)
	scrollFrame.Position = UDim2.new(0, 10, 0, 60)
	scrollFrame.BackgroundTransparency = 1
	scrollFrame.BorderSizePixel = 0
	scrollFrame.CanvasSize = UDim2.new(0, 0, 0, #ShopItems * 70)
	scrollFrame.Parent = background
	
	-- Create shop items
	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, 5)
	layout.Parent = scrollFrame
	
	for i, item in ipairs(ShopItems) do
		local itemFrame = Instance.new("Frame")
		itemFrame.Name = "Item" .. i
		itemFrame.Size = UDim2.new(1, -10, 0, 60)
		itemFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		itemFrame.BorderSizePixel = 0
		itemFrame.Parent = scrollFrame
		
		-- Item name and cost
		local infoLabel = Instance.new("TextLabel")
		infoLabel.Size = UDim2.new(0, 250, 1, 0)
		infoLabel.BackgroundTransparency = 1
		infoLabel.TextColor3 = Color3.new(1, 1, 1)
		infoLabel.TextSize = 16
		infoLabel.Font = Enum.Font.Gotham
		infoLabel.TextXAlignment = Enum.TextXAlignment.Left
		infoLabel.Text = item.name .. " (+$" .. item.boost .. ")"
		infoLabel.Parent = itemFrame
		
		-- Cost label
		local costLabel = Instance.new("TextLabel")
		costLabel.Size = UDim2.new(0, 100, 1, 0)
		costLabel.Position = UDim2.new(0, 150, 0, 0)
		costLabel.BackgroundTransparency = 1
		costLabel.TextColor3 = Color3.fromRGB(76, 175, 80)
		costLabel.TextSize = 14
		costLabel.Font = Enum.Font.GothamBold
		costLabel.Text = "$" .. item.cost
		costLabel.Parent = itemFrame
		
		-- Buy button
		local buyButton = Instance.new("TextButton")
		buyButton.Size = UDim2.new(0, 80, 0, 40)
		buyButton.Position = UDim2.new(1, -90, 0.5, -20)
		buyButton.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
		buyButton.TextColor3 = Color3.new(1, 1, 1)
		buyButton.TextSize = 14
		buyButton.Font = Enum.Font.GothamBold
		buyButton.Text = "Buy"
		buyButton.BorderSizePixel = 0
		buyButton.Parent = itemFrame
		
		-- Buy functionality
		buyButton.MouseButton1Click:Connect(function()
			local currentMoney = player:GetAttribute("Money") or 0
			if currentMoney >= item.cost then
				player:SetAttribute("Money", currentMoney - item.cost)
				player:SetAttribute("Level", (player:GetAttribute("Level") or 1) + 1)
				buyButton.Text = "✓ Bought"
				buyButton.BackgroundColor3 = Color3.fromRGB(156, 39, 176)
				wait(1)
				buyButton.Text = "Buy"
				buyButton.BackgroundColor3 = Color3.fromRGB(76, 175, 80)
			end
		end)
	end
	
	-- Close button
	local closeButton = Instance.new("TextButton")
	closeButton.Name = "CloseButton"
	closeButton.Size = UDim2.new(0, 100, 0, 40)
	closeButton.Position = UDim2.new(0.5, -50, 1, -50)
	closeButton.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
	closeButton.TextColor3 = Color3.new(1, 1, 1)
	closeButton.TextSize = 16
	closeButton.Font = Enum.Font.GothamBold
	closeButton.Text = "Close"
	closeButton.BorderSizePixel = 0
	closeButton.Parent = background
	
	closeButton.MouseButton1Click:Connect(function()
		shopGui:Destroy()
	end)
	
	return shopGui
end

return createShopGUI
