-- Base URL of your GitHub repo raw file path
local baseURL = "https://raw.githubusercontent.com/Arnaslolol/Mewmew/main/"

-- List all the script filenames you want to load
local scriptList = {
    "script1.lua",
    "script2.lua",
    "script3.lua"
}

-- Loop through and load+run each script
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
