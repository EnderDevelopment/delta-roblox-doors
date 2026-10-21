-- NPC Behavior Script

local NPC = script.Parent
local Humanoid = NPC:WaitForChild("Humanoid")
local Waypoints = workspace:WaitForChild("Waypoints")

-- Function to make the NPC patrol between waypoints
local function patrol()
    for _, waypoint in ipairs(Waypoints:GetChildren()) do
        Humanoid:MoveTo(waypoint.Position)
        Humanoid.MoveToFinished:Wait()
    end
    patrol() -- Repeat the patrol loop
end

-- Function to handle NPC interactions
local function onInteracted(player)
    -- Example interaction: Display a dialogue message
    local message = "Hello, " .. player.Name .. "! How can I help you?"
    game:GetService("Chat"):Chat(NPC.Head, message)
end

-- Connect the interacted event to the NPC
NPC.Interacted:Connect(onInteracted)

-- Start the patrol behavior
patrol()