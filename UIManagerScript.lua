-- UI Manager Script

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

-- Function to create a health bar for a player
local function createHealthBar(player)
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    -- Create a ScreenGui for the health bar
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "HealthBarGui"
    screenGui.Parent = player:WaitForChild("PlayerGui")

    -- Create a Frame for the health bar background
    local healthBarBackground = Instance.new("Frame")
    healthBarBackground.Name = "HealthBarBackground"
    healthBarBackground.Size = UDim2.new(0.2, 0, 0.02, 0)
    healthBarBackground.Position = UDim2.new(0.4, 0, 0.1, 0)
    healthBarBackground.BackgroundColor3 = Color3.new(0, 0, 0)
    healthBarBackground.BorderSizePixel = 0
    healthBarBackground.Parent = screenGui

    -- Create a Frame for the health bar
    local healthBar = Instance.new("Frame")
    healthBar.Name = "HealthBar"
    healthBar.Size = UDim2.new(1, 0, 1, 0)
    healthBar.BackgroundColor3 = Color3.new(1, 0, 0)
    healthBar.BorderSizePixel = 0
    healthBar.Parent = healthBarBackground

    -- Function to update the health bar
    local function updateHealthBar()
        local healthPercentage = humanoid.Health / humanoid.MaxHealth
        healthBar.Size = UDim2.new(healthPercentage, 0, 1, 0)
    end

    -- Connect the health changed event to update the health bar
    humanoid.HealthChanged:Connect(updateHealthBar)

    -- Initial update of the health bar
    updateHealthBar()
end

-- Function to create an inventory display for a player
local function createInventoryDisplay(player)
    -- Create a ScreenGui for the inventory display
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "InventoryGui"
    screenGui.Parent = player:WaitForChild("PlayerGui")

    -- Create a Frame for the inventory background
    local inventoryBackground = Instance.new("Frame")
    inventoryBackground.Name = "InventoryBackground"
    inventoryBackground.Size = UDim2.new(0.3, 0, 0.5, 0)
    inventoryBackground.Position = UDim2.new(0.35, 0, 0.25, 0)
    inventoryBackground.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    inventoryBackground.BorderSizePixel = 0
    inventoryBackground.Parent = screenGui

    -- Create a TextLabel for the inventory title
    local inventoryTitle = Instance.new("TextLabel")
    inventoryTitle.Name = "InventoryTitle"
    inventoryTitle.Size = UDim2.new(1, 0, 0.1, 0)
    inventoryTitle.Position = UDim2.new(0, 0, 0, 0)
    inventoryTitle.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    inventoryTitle.TextColor3 = Color3.new(1, 1, 1)
    inventoryTitle.Text = "Inventory"
    inventoryTitle.TextScaled = true
    inventoryTitle.Parent = inventoryBackground

    -- Create a ScrollingFrame for the inventory items
    local inventoryItems = Instance.new("ScrollingFrame")
    inventoryItems.Name = "InventoryItems"
    inventoryItems.Size = UDim2.new(1, 0, 0.9, 0)
    inventoryItems.Position = UDim2.new(0, 0, 0.1, 0)
    inventoryItems.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    inventoryItems.BorderSizePixel = 0
    inventoryItems.ScrollBarThickness = 5
    inventoryItems.Parent = inventoryBackground

    -- Function to update the inventory display
    local function updateInventoryDisplay()
        -- Clear existing items
        for _, child in ipairs(inventoryItems:GetChildren()) do
            if child:IsA("TextLabel") then
                child:Destroy()
            end
        end

        -- Add items from the player's inventory
        local inventory = player:FindFirstChild("Inventory")
        if inventory then
            local yOffset = 0
            for _, item in ipairs(inventory:GetChildren()) do
                local itemLabel = Instance.new("TextLabel")
                itemLabel.Name = item.Name
                itemLabel.Size = UDim2.new(1, 0, 0, 30)
                itemLabel.Position = UDim2.new(0, 0, 0, yOffset)
                itemLabel.BackgroundColor3 = Color3.new(0.4, 0.4, 0.4)
                itemLabel.TextColor3 = Color3.new(1, 1, 1)
                itemLabel.Text = item.Name .. ": " .. item.Value
                itemLabel.TextScaled = true
                itemLabel.Parent = inventoryItems
                yOffset = yOffset + 30
            end
        end
    end

    -- Connect the child added event to update the inventory display
    if player:FindFirstChild("Inventory") then
        player.Inventory.ChildAdded:Connect(updateInventoryDisplay)
    end

    -- Initial update of the inventory display
    updateInventoryDisplay()
end

-- Function to create a menu for a player
local function createMenu(player)
    -- Create a ScreenGui for the menu
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MenuGui"
    screenGui.Parent = player:WaitForChild("PlayerGui")

    -- Create a Frame for the menu background
    local menuBackground = Instance.new("Frame")
    menuBackground.Name = "MenuBackground"
    menuBackground.Size = UDim2.new(0.5, 0, 0.5, 0)
    menuBackground.Position = UDim2.new(0.25, 0, 0.25, 0)
    menuBackground.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    menuBackground.BorderSizePixel = 0
    menuBackground.Parent = screenGui

    -- Create a TextLabel for the menu title
    local menuTitle = Instance.new("TextLabel")
    menuTitle.Name = "MenuTitle"
    menuTitle.Size = UDim2.new(1, 0, 0.1, 0)
    menuTitle.Position = UDim2.new(0, 0, 0, 0)
    menuTitle.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    menuTitle.TextColor3 = Color3.new(1, 1, 1)
    menuTitle.Text = "Menu"
    menuTitle.TextScaled = true
    menuTitle.Parent = menuBackground

    -- Create a TextButton for the inventory button
    local inventoryButton = Instance.new("TextButton")
    inventoryButton.Name = "InventoryButton"
    inventoryButton.Size = UDim2.new(0.8, 0, 0.1, 0)
    inventoryButton.Position = UDim2.new(0.1, 0, 0.2, 0)
    inventoryButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    inventoryButton.TextColor3 = Color3.new(1, 1, 1)
    inventoryButton.Text = "Inventory"
    inventoryButton.TextScaled = true
    inventoryButton.Parent = menuBackground

    -- Function to handle inventory button click
    local function onInventoryButtonClick()
        createInventoryDisplay(player)
    end

    -- Connect the activated event to the inventory button
    inventoryButton.Activated:Connect(onInventoryButtonClick)

    -- Create a TextButton for the settings button
    local settingsButton = Instance.new("TextButton")
    settingsButton.Name = "SettingsButton"
    settingsButton.Size = UDim2.new(0.8, 0, 0.1, 0)
    settingsButton.Position = UDim2.new(0.1, 0, 0.4, 0)
    settingsButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    settingsButton.TextColor3 = Color3.new(1, 1, 1)
    settingsButton.Text = "Settings"
    settingsButton.TextScaled = true
    settingsButton.Parent = menuBackground

    -- Function to handle settings button click
    local function onSettingsButtonClick()
        -- Handle settings button click
    end

    -- Connect the activated event to the settings button
    settingsButton.Activated:Connect(onSettingsButtonClick)

    -- Create a TextButton for the exit button
    local exitButton = Instance.new("TextButton")
    exitButton.Name = "ExitButton"
    exitButton.Size = UDim2.new(0.8, 0, 0.1, 0)
    exitButton.Position = UDim2.new(0.1, 0, 0.6, 0)
    exitButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    exitButton.TextColor3 = Color3.new(1, 1, 1)
    exitButton.Text = "Exit"
    exitButton.TextScaled = true
    exitButton.Parent = menuBackground

    -- Function to handle exit button click
    local function onExitButtonClick()
        screenGui:Destroy()
    end

    -- Connect the activated event to the exit button
    exitButton.Activated:Connect(onExitButtonClick)
end

-- Function to handle player added
local function onPlayerAdded(player)
    -- Create a health bar for the player
    createHealthBar(player)

    -- Create a menu for the player
    createMenu(player)
end

-- Connect the player added event to the onPlayerAdded function
Players.PlayerAdded:Connect(onPlayerAdded)