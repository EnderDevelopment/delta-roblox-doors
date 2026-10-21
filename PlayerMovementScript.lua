-- Player Movement Script

local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- Movement settings
local walkSpeed = 16
local jumpPower = 50
local sprintSpeed = 32

-- Set initial movement values
Humanoid.WalkSpeed = walkSpeed
Humanoid.JumpPower = jumpPower

-- Sprint function
local function sprint()
    Humanoid.WalkSpeed = sprintSpeed
end

-- Stop sprinting function
local function stopSprint()
    Humanoid.WalkSpeed = walkSpeed
end

-- User input handling
local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.LeftShift then
        sprint()
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.LeftShift then
        stopSprint()
    end
end)