-- Invisibility trick (local only) 😈
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local camera = workspace.CurrentCamera

-- Sanity check
if not character or not character:FindFirstChild("HumanoidRootPart") then
    warn("[Invisibility] Character not fully loaded.")
    return
end

-- Toggle check
if _G.InvisActive then
    if _G.FakeDummy and _G.FakeDummy:IsDescendantOf(workspace) then
        character:MoveTo(_G.FakeDummy.Position)
        camera.CameraSubject = character:FindFirstChild("Humanoid") or character
        _G.FakeDummy:Destroy()
    end
    _G.InvisActive = false
    print("[Invisibility] Back to reality 🚶‍♂️")
    return
end

-- Turn ON
_G.InvisActive = true

-- Backup original position
local rootPart = character:WaitForChild("HumanoidRootPart")
local originalPos = rootPart.Position

-- Clone the character as a dummy (visually only)
local success, fakeChar = pcall(function()
    return character:Clone()
end)

if not success or not fakeChar then
    warn("[Invisibility] Failed to clone character.")
    return
end

fakeChar.Name = "FakeDummy"
fakeChar.Parent = workspace

-- Clean up animations and logic from the dummy
for _, part in ipairs(fakeChar:GetDescendants()) do
    if part:IsA("Script") or part:IsA("LocalScript") then
        part:Destroy()
    end
end

-- Set transparency
for _, part in ipairs(fakeChar:GetDescendants()) do
    if part:IsA("BasePart") or part:IsA("Decal") then
        part.Transparency = 0.5
    end
end

-- Move real character far away
local safeSpot = Vector3.new(99999, 99999, 99999)
character:SetPrimaryPartCFrame(CFrame.new(safeSpot))

-- Set camera to follow dummy
camera.CameraSubject = fakeChar:FindFirstChild("Humanoid") or fakeChar:FindFirstChildWhichIsA("BasePart")

-- Save for toggle off
_G.FakeDummy = fakeChar

print("[Invisibility] You are now a *phantom menace* 👻 Toggle again to return.")
