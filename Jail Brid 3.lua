-- LocalScript (place it in StarterPlayerScripts or StarterGui)

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Local player
local localPlayer = Players.LocalPlayer

-- Function to check if the player is alive
local function isAlive(character)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid and humanoid.Health > 0 then
        return true
    end
    return false
end

-- Function to add an outline to a character
local function addOutline(character, color)
    local highlight = character:FindFirstChild("Highlight")
    
    -- If the highlight doesn't already exist, create it
    if not highlight then
        highlight = Instance.new("Highlight")
        highlight.Parent = character
        highlight.OutlineColor = color  -- Set outline color
        highlight.OutlineTransparency = 0  -- Full visibility for the outline
        highlight.FillTransparency = 1  -- Fully transparent fill
    end
end

-- Function to remove the outline from a character
local function removeOutline(character)
    local highlight = character:FindFirstChild("Highlight")
    if highlight then
        highlight:Destroy()
    end
end

-- Main function to update player outlines
local function updatePlayerOutlines()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= localPlayer then  -- Ignore the local player
            local character = player.Character
            if character and isAlive(character) then
                -- Add a red outline when the player is alive
                addOutline(character, Color3.new(1, 0, 0))  -- Red color
            else
                -- Remove the outline when the player is dead
                removeOutline(character)
            end
        end
    end
end

-- Run the update every 2 seconds
task.spawn(function()
    while true do
        updatePlayerOutlines()
        task.wait(2)  -- Wait for 2 seconds before updating again
    end
end)
