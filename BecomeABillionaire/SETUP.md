# 🎮 Become A Billionaire - Setup Guide

## Quick Start

1. **Open Roblox Studio**
2. **Create a new game** (or open an existing one)
3. **Copy all files from the `ServerScriptService`, `StarterGui`, and `ServerStorage` folders into your game**
4. **Adjust values in `MainGameScript.lua` to customize difficulty**
5. **Publish and test!**

---

## 📁 File Structure

```
BecomeABillionaire/
├── ServerScriptService/
│   ├── MainGameScript.lua          (Core game loop)
│   ├── MiniGames.lua                (Mini-game modules)
│   ├── SpecialEvents.lua            (Random events)
│   └── Achievements.lua             (Achievement tracking)
├── StarterGui/
│   ├── HUDScript.lua                (Main display UI)
│   └── Shop.lua                     (Shop interface)
└── SETUP.md                         (This file)
```

---

## 🔧 Configuration

### Adjust Starting Money
In `MainGameScript.lua`, line 9:
```lua
local STARTING_MONEY = 100
```
Change to any amount you want.

### Adjust Passive Income
In `MainGameScript.lua`, line 56:
```lua
local incomePerSecond = level * 2 + (player:GetAttribute("Prestige") or 0) * 50
```
- `level * 2`: Income per level
- `* 50`: Prestige multiplier

### Adjust Save Interval
In `MainGameScript.lua`, line 10:
```lua
local SAVE_INTERVAL = 30
```
Changes how often player data is auto-saved (in seconds).

---

## 🎯 Game Features

### 1. **Passive Income System**
- Players earn money automatically every 5 seconds
- Income increases with level
- Prestige levels multiply income significantly

### 2. **Mini-Games** (Quick money earning)
- **Clicker Game**: Tap rapidly for 10 seconds
- **Lucky Spin**: Risk-reward multiplier system
- **Investor Challenge**: Buy/sell investments
- **Business Simulation**: Run a virtual business

### 3. **Shop System**
- Purchase upgrades to increase level
- Each upgrade increases income
- Progression from basic tools to fortune 500 status

### 4. **Achievement System**
- Earn rewards for reaching milestones
- Achievements grant bonus money
- Track progress toward billionaire status

### 5. **Special Events**
- Random events affect income (booms, crashes, taxes)
- 30% chance every 1-3 minutes
- Creates dynamic gameplay

### 6. **Prestige System**
- Reset progress after reaching level 20
- Gain massive starting bonus
- Unlock higher passive income multipliers

---

## 📊 Progression Timeline

| Milestone | Time | Notes |
|-----------|------|-------|
| $100 | 2 min | Tutorial phase |
| $1,000 | 10 min | First level up |
| $10,000 | 20 min | Buy first upgrades |
| $100,000 | 30 min | Reach level 10 |
| $1,000,000 | 45 min | Millionaire achievement |
| First Prestige | 60 min | Prestige level 1 |
| $1,000,000,000 | 90+ min | Billionaire status |

---

## ⚙️ Customization Guide

### Add New Mini-Games
Edit `MiniGames.lua` and add a new function:
```lua
function MiniGames.NewGame(player)
    -- Your game logic here
    local earnings = 500
    player:SetAttribute("Money", (player:GetAttribute("Money") or 0) + earnings)
    return earnings
end
```

### Add New Shop Items
Edit `Shop.lua` and modify the `ShopItems` table:
```lua
local ShopItems = {
    {name = "Your Item", cost = 1000, boost = 5},
    -- ... more items
}
```

### Add New Events
Edit `SpecialEvents.lua` and add to the `Events` table:
```lua
{name = "Your Event", effect = 1.5, description = "Your description"},
```

### Modify Shop Button
In `HUDScript.lua`, connect the shop button to your shop:
```lua
shopButton.MouseButton1Click:Connect(function()
    local shopGUI = require(game.ServerStorage:WaitForChild("Shop"))()
end)
```

---

## 🐛 Troubleshooting

| Issue | Solution |
|-------|----------|
| Money not saving | Check DataStore settings in Roblox game settings |
| HUD not showing | Ensure HUDScript is in StarterGui and set to auto-run |
| Shop doesn't open | Call the Shop module correctly in HUDScript |
| Events not triggering | Check console for errors in SpecialEvents.lua |

---

## 💡 Tips for Longer Gameplay

1. **Add more mini-games** for variety
2. **Increase upgrade costs** for longer progression
3. **Add leaderboard system** for competition
4. **Create prestige levels** beyond level 1
5. **Add cosmetics** for players to customize

---

## 📈 Balance Guidelines

- **Too easy?** Increase `STARTING_MONEY` difficulty and shop costs
- **Too hard?** Decrease starting money and increase passive income
- **Too grindy?** Reduce wait times and increase multipliers
- **Too short?** Add more prestige levels and events

---

## 🚀 Advanced Features to Add

- **Leaderboard**: Track top earners
- **Trading system**: Players trade money
- **Property system**: Buy virtual real estate
- **Guilds**: Team up for bonuses
- **Limited-time events**: Weekly challenges
- **Daily rewards**: Login bonuses

---

**Enjoy your Billionaire tycoon game! 🎉**
