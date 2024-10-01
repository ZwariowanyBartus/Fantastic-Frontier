-- LocalScript (place it in StarterPlayerScripts or StarterGui)

-- Services
local Players = game:GetService("Players")

-- Function to remove highlights from a character
local function removeHighlightsFromCharacter(character)
    -- Find the "Highlight" object in the character
    local highlight = character:FindFirstChild("Highlight")
    if highlight then
        -- Remove the highlight
        highlight:Destroy()
    end
end

-- Function to remove highlights from all players
local function removeAllHighlights()
    for _, player in pairs(Players:GetPlayers()) do
        local character = player.Character
        if character then
            -- Remove highlight from player's character
            removeHighlightsFromCharacter(character)
        end
    end
end

-- Example of calling the function manually or from an event
removeAllHighlights()

-- Optionally, connect this to an event to run when the player respawns or at another specific time.
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        -- Remove highlight when the character is added
        removeHighlightsFromCharacter(character)
    end)
end)





-- LocalScript (umieść go w StarterPlayerScripts lub StarterGui)

-- Usługi
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Lokalny gracz
local localPlayer = Players.LocalPlayer

-- Funkcja do sprawdzania, czy gracz żyje
local function isAlive(character)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid and humanoid.Health > 0 then
        return true
    end
    return false
end

-- Funkcja do dodawania obramowania do postaci
local function addOutline(character, color)
    local highlight = character:FindFirstChild("Highlight")
    
    -- Jeśli obramowanie już nie istnieje, stworzymy je
    if not highlight then
        highlight = Instance.new("Highlight")
        highlight.Parent = character
        highlight.OutlineColor = color  -- Ustawienie koloru obramówki
        highlight.OutlineTransparency = 0  -- Pełna widoczność obramówki
        highlight.FillTransparency = 1  -- Wypełnienie całkowicie przezroczyste
    end
end

-- Funkcja do usuwania obramowania z postaci
local function removeOutline(character)
    local highlight = character:FindFirstChild("Highlight")
    if highlight then
        highlight:Destroy()
    end
end

-- Funkcja główna do aktualizacji obramówek graczy
local function updatePlayerOutlines()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= localPlayer then  -- Ignorowanie lokalnego gracza
            local character = player.Character
            if character and isAlive(character) then
                -- Dodanie czerwonej obramówki, gdy gracz żyje
                addOutline(character, Color3.new(1, 0, 0))  -- Czerwony kolor
            else
                -- Usunięcie obramówki, gdy gracz jest martwy
                removeOutline(character)
            end
        end
    end
end

-- Uruchamianie funkcji aktualizacji w każdej klatce
RunService.RenderStepped:Connect(function()
    updatePlayerOutlines()
end)
