-- Health System Script

local Players = game:GetService("Players")

-- Function to handle player damage
local function onPlayerDamage(player, damage)
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Health = humanoid.Health - damage
            if humanoid.Health <= 0 then
                -- Handle player death
                humanoid.Health = 0
                -- Respawn the player
                player:LoadCharacter()
            end
        end
    end
end

-- Function to handle player healing
local function onPlayerHeal(player, healAmount)
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Health = math.min(humanoid.Health + healAmount, humanoid.MaxHealth)
        end
    end
end

-- Example usage: Damage a player when they touch a hazard
local function onTouched(otherPart)
    local player = Players:GetPlayerFromCharacter(otherPart.Parent)
    if player then
        onPlayerDamage(player, 10)
    end
end

-- Connect the touched event to the hazard part
local hazard = workspace:WaitForChild("Hazard")
if hazard then
    hazard.Touched:Connect(onTouched)
end

-- Example usage: Heal a player when they pick up a health pack
local function onHealthPackTouched(otherPart)
    local player = Players:GetPlayerFromCharacter(otherPart.Parent)
    if player then
        onPlayerHeal(player, 20)
        -- Remove the health pack from the workspace
        otherPart.Parent:Destroy()
    end
end

-- Connect the touched event to the health pack part
local healthPack = workspace:WaitForChild("HealthPack")
if healthPack then
    healthPack.Touched:Connect(onHealthPackTouched)
end