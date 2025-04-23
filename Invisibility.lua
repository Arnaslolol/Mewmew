-- Invisibility Trick v2 (Safe Clone Mode 🧪)
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- Wait until the character fully loads and has a Humanoid + RootPart
local function waitForCharacter()
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid", 10)
    local root = char:WaitForChild("HumanoidRootPart", 10)

    if humanoid and root then
        return char
    else
        warn("[Invisibility] Character failed to fully load.")
        return nil
    end
end

-- Main invisibility toggle
local character = waitForCharacter()
if not character then return end

-- Already invisible?
if _G.InvisActive then
    if _G.FakeDummy and _G.FakeDummy:IsDescendantOf(workspace) then
        character:MoveTo(_G.FakeDummy.Position)
        camera.CameraSubject = character:FindFirstChild("Humanoid") or character
        _G.FakeDummy:Destroy()
    end
    _G.InvisActive = false
    print("[Invisibility] Back in sight 👁️")
    return
end

-- Activate invisibility
_G.InvisActive = true

-- Clone the character
local fakeChar = character:Clone()
if not fakeChar then
    warn("[Invisibility] Failed to clone character.")
    return
end

fakeChar.Name = "FakeDummy"
fakeChar.Parent = workspace

-- Cleanup
for _, part in ipairs(fakeChar:GetDescendants()) do
    if part:IsA("Script") or part:IsA("LocalScript") then
        part:Destroy()
    elseif part:IsA("BasePart") or part:IsA("Decal") then
        part.Transparency = 0.5
    end
end

-- Move player far away
character:SetPrimaryPartCFrame(CFrame.new(99999, 99999, 99999))

-- Camera follows the dummy
camera.CameraSubject = fakeChar:FindFirstChild("Humanoid") or fakeChar:FindFirstChildWhichIsA("BasePart")

_G.FakeDummy = fakeChar
print("[Invisibility] Now you see me... not! 👻")

