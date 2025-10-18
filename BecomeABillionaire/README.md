# 💰 Become A Billionaire - Roblox Tycoon Game

A fully-featured Roblox tycoon game where players progress from $0 to $1 billion through multiple gameplay systems. Designed for **1-2+ hours of engaging gameplay** with passive income, mini-games, achievements, and prestige mechanics.

![License](https://img.shields.io/badge/license-MIT-green.svg)
![Roblox](https://img.shields.io/badge/platform-Roblox-blue.svg)

---

## 🎮 Core Gameplay Features

### **Passive Income System**
- Automatic money generation every 5 seconds
- Income scales with player level
- Prestige multipliers for advanced players
- Dynamic difficulty progression

### **Mini-Games** (4 Unique Gameplay Modes)
1. **Clicker Game** - Fast-paced tapping mechanics
2. **Lucky Spin** - Risk/reward multiplier system
3. **Investor Challenge** - Buy/sell investment simulator
4. **Business Simulation** - Real-time business management

### **Shop & Upgrades**
- 8 progression tiers of upgrades
- Each purchase increases level and income
- Price scaling: $500 → $2,000,000
- Visual feedback for purchases

### **Achievement System**
- 7 major achievements unlocked
- Bonus money rewards for milestones
- Prestige, millionaire, and billionaire achievements
- Rewards scale from $50 → $100,000

### **Special Events** (10 Dynamic Events)
- Market booms and crashes
- Tax seasons and recessions
- Worker strikes and promotions
- Random events trigger every 1-3 minutes
- 30% chance of occurrence

### **Prestige System**
- Reset progress after level 20
- Massive starting bonus (50,000 × prestige + 10,000 × level)
- Unlock higher passive income multipliers
- Multiple prestige levels supported

---

## 📊 Progression Rates

|| Milestone | Time Est. | In-Game Money |
||-----------|-----------|---------------|
|| $100 | 2 min | Tutorial |
|| $1,000 | 8 min | First upgrade |
|| $10,000 | 20 min | Office established |
|| $100,000 | 35 min | Level 10 reached |
|| $1,000,000 | 50 min | Millionaire status |
|| **First Prestige** | **60 min** | Reset + bonus |
|| $1,000,000,000 | 90+ min | Billionaire! |

**Total gameplay: 1.5-2+ hours** to reach billionaire status

---

## 🚀 Quick Installation

### Step 1: Download Files
```bash
git clone https://github.com/yourusername/BecomeABillionaire.git
cd BecomeABillionaire
```

### Step 2: In Roblox Studio
1. Create a new place
2. In ServerScriptService:
   - Add `MainGameScript.lua` (Script)
   - Add `MiniGames.lua` (ModuleScript)
   - Add `SpecialEvents.lua` (ModuleScript)
   - Add `Achievements.lua` (ModuleScript)

3. In StarterGui:
   - Add `HUDScript.lua` (LocalScript)
   - Add `Shop.lua` (LocalScript)

### Step 3: Test
- Click Play in Roblox Studio
- Watch money generate!
- Click Shop to purchase upgrades

---

## 🔧 Configuration

### Easy Mode (Player-Friendly)
```lua
-- MainGameScript.lua, line 9
local STARTING_MONEY = 500      -- More starting cash
local SAVE_INTERVAL = 20         -- Save more frequently
```

### Normal Mode (Balanced)
```lua
local STARTING_MONEY = 100
local SAVE_INTERVAL = 30
```

### Hard Mode (Challenge)
```lua
local STARTING_MONEY = 10
local SAVE_INTERVAL = 60
```

---

## 🎯 Customization Guide

### Change Passive Income Formula
Edit `MainGameScript.lua` line 56:
```lua
-- Default: Faster growth
local incomePerSecond = level * 5 + (player:GetAttribute("Prestige") or 0) * 100

-- For slower progression:
local incomePerSecond = level * 1 + (player:GetAttribute("Prestige") or 0) * 20
```

### Add New Shop Items
Edit `Shop.lua` line 8:
```lua
local ShopItems = {
    {name = "Item Name", cost = 1000, boost = 1.5},
    {name = "New Item", cost = 5000, boost = 2},
    -- Add more...
}
```

### Create New Mini-Game
Edit `MiniGames.lua`:
```lua
function MiniGames.SlotMachine(player, spinCount)
    spinCount = spinCount or 3
    local jackpotChance = math.random(1, 100)
    local earnings = 0
    
    if jackpotChance > 95 then
        earnings = (player:GetAttribute("Level") or 1) * 1000
    else
        earnings = (player:GetAttribute("Level") or 1) * 100
    end
    
    player:SetAttribute("Money", (player:GetAttribute("Money") or 0) + earnings)
    return earnings
end
```

### Add New Event
Edit `SpecialEvents.lua` line 6:
```lua
local Events = {
    {name = "Your Event", effect = 1.5, description = "Custom event!"},
    -- ... existing events
}
```

---

## 📁 Project Structure

```
BecomeABillionaire/
│
├── 📄 README.md                    (This file)
├── 📄 SETUP.md                     (Quick setup guide)
│
├── 📁 ServerScriptService/
│   ├── MainGameScript.lua          (Core game initialization)
│   ├── MiniGames.lua               (Mini-game modules)
│   ├── SpecialEvents.lua           (Event system & prestige)
│   └── Achievements.lua            (Achievement tracking)
│
├── 📁 StarterGui/
│   ├── HUDScript.lua               (Main UI & display)
│   └── Shop.lua                    (Shop interface)
│
└── 📁 Examples/
    └── AdvancedCustomization.lua   (Extension examples)
```

---

## 🏗️ How to Extend (Advanced)

### Add Leaderboard
```lua
-- Create new script in ServerScriptService
local Players = game:GetService("Players")

local function updateLeaderboard()
    local playerData = {}
    for _, player in pairs(Players:GetPlayers()) do
        table.insert(playerData, {
            name = player.Name,
            money = player:GetAttribute("Money") or 0
        })
    end
    
    table.sort(playerData, function(a, b) return a.money > b.money end)
    
    for i, data in ipairs(playerData) do
        print(i .. ". " .. data.name .. ": $" .. data.money)
    end
end

while true do
    wait(30)
    updateLeaderboard()
end
```

### Add Daily Rewards
```lua
function MiniGames.DailyBonus(player)
    local lastClaim = player:GetAttribute("LastDailyBonus") or 0
    local now = os.time()
    
    if now - lastClaim >= 86400 then -- 24 hours
        local bonus = (player:GetAttribute("Level") or 1) * 5000
        player:SetAttribute("Money", (player:GetAttribute("Money") or 0) + bonus)
        player:SetAttribute("LastDailyBonus", now)
        return bonus
    end
    return 0
end
```

### Add Multiplier Events
```lua
-- In SpecialEvents.lua
function SpecialEvents.DoubleMoneyHour(player)
    -- 1 hour of 2x income
    local startTime = os.time()
    
    while os.time() - startTime < 3600 do
        -- Income is multiplied by 2 during this period
        wait(1)
    end
    
    print("Double money hour ended!")
end
```

---

## 🎨 UI Customization

### Change HUD Colors
Edit `HUDScript.lua`:
```lua
-- Money label (Green)
moneyLabel.BackgroundColor3 = Color3.fromRGB(46, 125, 50)  -- Change RGB

-- Level label (Blue)
levelLabel.BackgroundColor3 = Color3.fromRGB(25, 118, 210) -- Change RGB

-- Prestige label (Purple)
prestigeLabel.BackgroundColor3 = Color3.fromRGB(156, 39, 176) -- Change RGB
```

### Adjust Text Sizes
```lua
moneyLabel.TextSize = 32      -- Change to any size
levelLabel.TextSize = 28
prestigeLabel.TextSize = 24
```

---

## 🐛 Troubleshooting

|| Problem | Solution |
||---------|----------|
|| Money not saving | Enable DataStores in game settings (API access) |
|| HUD not visible | Move HUDScript into StarterGui with RunContext: Client |
|| Shop doesn't appear | Verify Shop.lua location and call it from HUDScript |
|| Events not triggering | Check Roblox output console for script errors |
|| Progress too slow | Reduce level multiplier in MainGameScript.lua |
|| Progress too fast | Increase cost values in Shop.lua |

---

## 📈 Balance Tips

**For 1-hour gameplay:**
- Reduce mini-game wait times by 50%
- Double passive income multiplier
- Reduce prestige requirement to level 10

**For 2-hour+ gameplay:**
- Increase all costs by 3x
- Reduce passive income by 50%
- Add 5+ prestige tiers
- Create harder mini-game variants

**For PvP/Competition:**
- Add player trading system
- Create leaderboard with rankings
- Implement steal/raid mechanics
- Add gift system

---

## 🎓 Learning Resources

- [Roblox Wiki](https://developer.roblox.com/)
- [Lua Documentation](https://www.lua.org/manual/5.1/)
- [Roblox DataStore Guide](https://developer.roblox.com/en-us/articles/DataStore)
- [GUI Scripting](https://developer.roblox.com/en-us/articles/GUI-Basics)

---

## 📝 License

MIT License - Feel free to use, modify, and distribute!

---

## 🤝 Contributing

Found a bug? Want to add features? Submit a pull request!

**Ideas for contributions:**
- [ ] Add trading system
- [ ] Create guilds/teams
- [ ] Build property system
- [ ] Add special events
- [ ] Create cosmetics shop
- [ ] Implement daily challenges

---

## ⭐ Features Summary

✅ Passive income system
✅ 4 mini-games
✅ 8 shop tiers
✅ 7 achievements
✅ 10 special events
✅ Prestige system
✅ DataStore integration
✅ Professional UI
✅ 1-2+ hour gameplay
✅ Fully customizable

---

## 📞 Support

For issues, questions, or feedback:
- Open an issue on GitHub
- Check SETUP.md for common problems
- Review code comments in each script

---

**Created with ❤️ for Roblox developers**

**Ready to become a billionaire? Start playing now! 🚀**
