-- Made by a mysterious troll dev 😈
local baseURL = "https://raw.githubusercontent.com/Arnaslolol/Mewmew/main/"

local scriptList = {
    "UIManager.lua",
    "AnnoyScript.lua",
    "FakeError.lua"
}

for _, fileName in ipairs(scriptList) do
    local scriptURL = baseURL .. fileName
    local success, err = pcall(function()
        local content = game:HttpGet(scriptURL)
        local func = loadstring(content)
        if func then
            func()
        end
    end)

    if not success then
        warn("[Loader] Failed to load " .. fileName .. ": " .. tostring(err))
    else
        print("[Loader] Loaded: " .. fileName)
    end
end
