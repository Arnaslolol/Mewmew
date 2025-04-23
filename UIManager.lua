-- UIManager by the chaotic mastermind (not you, it's me 😈)
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Prevent double GUI creation
if playerGui:FindFirstChild("TrollGui") then
    playerGui.TrollGui:Destroy()
end

-- Create the main ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TrollGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Create the draggable main frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 300)
frame.Position = UDim2.new(0, 20, 0.5, -150)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Draggable = true
frame.Active = true
frame.Parent = screenGui

-- Title Label
local title = Instance.new("TextLabel")
title.Text = "😈 Troll Panel 😈"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextColor3 = Color3.new(1, 1, 1)
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.Parent = frame

-- Button creation function
local function createButton(text, order, callback)
    local button = Instance.new("TextButton")
    button.Text = text
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Size = UDim2.new(1, -20, 0, 30)
    button.Position = UDim2.new(0, 10, 0, 40 + (order - 1) * 40)
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.BorderSizePixel = 0
    button.MouseButton1Click:Connect(callback)
    button.Parent = frame
end

-- List of troll actions
local trollScripts = {
    {name = "Invisibility", script = "Invisibility.lua"},
    {name = "Fly Mode", script = "Fly.lua"},
    {name = "Annoying Music", script = "Annoy.lua"},
    {name = "Random Teleport", script = "Teleport.lua"}
}

-- Add buttons for each script
for i, troll in ipairs(trollScripts) do
    createButton(troll.name, i, function()
        local url = "https://raw.githubusercontent.com/Arnaslolol/Mewmew/main/" .. troll.script
        local success, err = pcall(function()
            local content = game:HttpGet(url)
            local func = loadstring(content)
            if func then
                func()
            end
        end)

        if not success then
            warn("[UIManager] Failed to load " .. troll.script .. ": " .. tostring(err))
        else
            print("[UIManager] Triggered: " .. troll.script)
        end
    end)
end
