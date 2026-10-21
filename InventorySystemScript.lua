-- Inventory System Script

local Players = game:GetService("Players")

-- Function to initialize player inventory
local function initializeInventory(player)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local coins = Instance.new("IntValue")
    coins.Name = "Coins"
    coins.Value = 0
    coins.Parent = leaderstats

    local inventory = Instance.new("Folder")
    inventory.Name = "Inventory"
    inventory.Parent = player

    -- Example items
    local sword = Instance.new("StringValue")
    sword.Name = "Sword"
    sword.Value = "Basic Sword"
    sword.Parent = inventory

    local shield = Instance.new("StringValue")
    shield.Name = "Shield"
    shield.Value = "Basic Shield"
    shield.Parent = inventory
end

-- Function to add coins to player inventory
local function addCoins(player, amount)
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        local coins = leaderstats:FindFirstChild("Coins")
        if coins then
            coins.Value = coins.Value + amount
        end
    end
end

-- Function to add an item to player inventory
local function addItem(player, itemName, itemValue)
    local inventory = player:FindFirstChild("Inventory")
    if inventory then
        local item = Instance.new("StringValue")
        item.Name = itemName
        item.Value = itemValue
        item.Parent = inventory
    end
end

-- Example usage: Initialize inventory when a player joins
Players.PlayerAdded:Connect(initializeInventory)

-- Example usage: Add coins when a player picks up a coin
local function onCoinTouched(otherPart)
    local player = Players:GetPlayerFromCharacter(otherPart.Parent)
    if player then
        addCoins(player, 10)
        -- Remove the coin from the workspace
        otherPart.Parent:Destroy()
    end
end

-- Connect the touched event to the coin part
local coin = workspace:WaitForChild("Coin")
if coin then
    coin.Touched:Connect(onCoinTouched)
end

-- Example usage: Add an item when a player picks up an item
local function onItemTouched(otherPart)
    local player = Players:GetPlayerFromCharacter(otherPart.Parent)
    if player then
        addItem(player, "Potion", "Health Potion")
        -- Remove the item from the workspace
        otherPart.Parent:Destroy()
    end
end

-- Connect the touched event to the item part
local item = workspace:WaitForChild("Item")
if item then
    item.Touched:Connect(onItemTouched)
end