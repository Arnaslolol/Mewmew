-- Invisibility Debug Mode 🕵️‍♂️
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local camera = workspace.CurrentCamera

-- Step 1: Sanity checks
if not character then
    warn("[Invisibility] Character is nil.")
    return
end

print("[Invisibility] Character found:", character)

local rootPart = character:FindFirstChild("HumanoidRootPart")
if not rootPart then
    warn("[Invisibility] No HumanoidRootPart found.")
    return
end

-- Step 2: Toggle
if _G.InvisActive then
    if _G.FakeDummy and _G.FakeDummy:IsDescendantOf(workspace) then
        print("[Invisibility] Toggling OFF")
        character:MoveTo(_G.FakeDummy.Position)
        camera.CameraSubject = character:FindFirstChild("Humanoid") or character
        _G.FakeDummy:Destroy()
    end
    _G.InvisActive = false
    return
end

-- Step 3: Clone character
_G.InvisActive = true
local fakeChar = character:Clone()

if not fakeChar then
    warn("[Invisibility] Character cloning failed!")
    return
end

print("[Invisibility] Character cloned:", fakeChar)

-- Step 4: Assign name
fakeChar.Name = "FakeDummy"
fakeChar.Parent = workspace

-- Step 5: Cleanup and visuals
for _, part in ipairs(fakeChar:GetDescendants()) do
    if part:IsA("Script") or part:IsA("LocalScript") then
        part:Destroy()
    end
    if part:IsA("BasePart") or part:IsA("Decal") then
        part.Transparency = 0.5
    end
end

-- Step 6: Teleport real player
character:SetPrimaryPartCFrame(CFrame.new(99999, 99999, 99999))

-- Step 7: Camera switcheroo
camera.CameraSubject = fakeChar:FindFirstChild("Humanoid") or fakeChar:FindFirstChildWhichIsA("BasePart")
_G.FakeDummy = fakeChar

print("[Invisibility] You have vanished into the abyss 👻")
