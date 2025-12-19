-- KIMIKO BETA - Fixed Complete Version
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")
local LocalizationService = game:GetService("LocalizationService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Added VIP status tracking
local hasVIP = false

-- Products
local products = {
    {name = "VIP Access", nameES = "Acceso VIP", id = 3457958846, icon = "👑", hasAuto = false},
    {name = "Coin Multi +0.25", nameES = "Multi. Monedas +0.25", id = 3463557320, icon = "💰", hasAuto = true},
    {name = "Luck Multi +1", nameES = "Multi. Suerte +1", id = 3463468283, icon = "🍀", hasAuto = true},
    {name = "Coins +1000", nameES = "Monedas +1000", id = 3459672778, icon = "💰", hasAuto = true},
    {name = "Coins +500", nameES = "Monedas +500", id = 3459363160, icon = "💰", hasAuto = true},
    {name = "Coins +100", nameES = "Monedas +100", id = 3459363159, icon = "💰", hasAuto = true},
}

local isSpanish = LocalizationService.RobloxLocaleId == "es-es"

-- Create GUI
local sg = Instance.new("ScreenGui")
sg.Name = "KimikoBeta"
sg.ResetOnSpawn = false
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.Parent = playerGui

-- Loading with blur
local loadFrame = Instance.new("Frame")
loadFrame.Size = UDim2.new(1,0,1,0)
loadFrame.BackgroundTransparency = 1
loadFrame.Parent = sg

local blur = Instance.new("BlurEffect")
blur.Size = 24
blur.Parent = game.Lighting

local loadText = Instance.new("TextLabel")
loadText.Size = UDim2.new(0,300,0,80)
loadText.Position = UDim2.new(0.5,0,0.4,0)
loadText.AnchorPoint = Vector2.new(0.5,0.5)
loadText.BackgroundTransparency = 1
loadText.Text = "KIMIKO BETA"
loadText.TextColor3 = Color3.fromRGB(180,120,255)
loadText.TextSize = 42
loadText.Font = Enum.Font.GothamBold
loadText.TextTransparency = 1
loadText.Parent = loadFrame

local loadBar = Instance.new("Frame")
loadBar.Size = UDim2.new(0,0,0,4)
loadBar.Position = UDim2.new(0.5,0,0.5,0)
loadBar.AnchorPoint = Vector2.new(0.5,0.5)
loadBar.BackgroundColor3 = Color3.fromRGB(180,120,255)
loadBar.BorderSizePixel = 0
loadBar.Parent = loadFrame

Instance.new("UICorner", loadBar).CornerRadius = UDim.new(0,2)

TweenService:Create(loadText, TweenInfo.new(0.5), {TextTransparency=0}):Play()
task.wait(0.3)
TweenService:Create(loadBar, TweenInfo.new(1.5), {Size=UDim2.new(0,280,0,4)}):Play()
task.wait(1.7)
TweenService:Create(loadText, TweenInfo.new(0.4), {TextTransparency=1}):Play()
TweenService:Create(loadBar, TweenInfo.new(0.4), {BackgroundTransparency=1}):Play()
TweenService:Create(blur, TweenInfo.new(0.4), {Size=0}):Play()
task.wait(0.5)
loadFrame:Destroy()
blur:Destroy()

-- Main UI
local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0,400,0,500)
main.Position = UDim2.new(0.5,0,0.5,0)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = Color3.fromRGB(25,20,45)
main.BackgroundTransparency = 0.15
main.BorderSizePixel = 0
main.Parent = sg

Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)
local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(140,100,230)
stroke.Thickness = 2

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1,0,0,55)
header.BackgroundColor3 = Color3.fromRGB(30,25,55)
header.BackgroundTransparency = 0.3
header.BorderSizePixel = 0
header.Parent = main

Instance.new("UICorner", header).CornerRadius = UDim.new(0,14)
local headerBot = Instance.new("Frame")
headerBot.Size = UDim2.new(1,0,0,14)
headerBot.Position = UDim2.new(0,0,1,-14)
headerBot.BackgroundColor3 = Color3.fromRGB(30,25,55)
headerBot.BackgroundTransparency = 0.3
headerBot.BorderSizePixel = 0
headerBot.Parent = header

local logo = Instance.new("ImageLabel")
logo.Size = UDim2.new(0,35,0,35)
logo.Position = UDim2.new(0,12,0.5,0)
logo.AnchorPoint = Vector2.new(0,0.5)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://117159018829978"
logo.Parent = header

local titleLbl = Instance.new("TextLabel")
titleLbl.Size = UDim2.new(1,-60,1,0)
titleLbl.Position = UDim2.new(0,52,0,0)
titleLbl.BackgroundTransparency = 1
titleLbl.Text = "KIMIKO BETA"
titleLbl.TextColor3 = Color3.fromRGB(240,240,255)
titleLbl.TextSize = 22
titleLbl.Font = Enum.Font.GothamBold
titleLbl.TextXAlignment = Enum.TextXAlignment.Left
titleLbl.Parent = header

-- Content
local content = Instance.new("Frame")
content.Size = UDim2.new(1,-20,1,-70)
content.Position = UDim2.new(0,10,0,60)
content.BackgroundTransparency = 1
content.Parent = main

-- Notification function
local function notify(msg)
    local n = Instance.new("Frame")
    n.Size = UDim2.new(0,320,0,85)
    n.Position = UDim2.new(1,340,1,-100)
    n.AnchorPoint = Vector2.new(0,1)
    n.BackgroundColor3 = Color3.fromRGB(41,55,92)
    n.BorderSizePixel = 0
    n.ZIndex = 10000
    n.Parent = sg
    
    Instance.new("UICorner", n).CornerRadius = UDim.new(0,6)
    local nStroke = Instance.new("UIStroke", n)
    nStroke.Color = Color3.fromRGB(100,140,230)
    nStroke.Thickness = 2
    nStroke.Transparency = 0.5
    
    local badge = Instance.new("ImageLabel")
    badge.Size = UDim2.new(0,48,0,48)
    badge.Position = UDim2.new(0,14,0.5,0)
    badge.AnchorPoint = Vector2.new(0,0.5)
    badge.BackgroundTransparency = 1
    badge.Image = "rbxassetid://117159018829978"
    badge.Parent = n
    
    local txt = Instance.new("TextLabel")
    txt.Size = UDim2.new(1,-75,1,0)
    txt.Position = UDim2.new(0,68,0,0)
    txt.BackgroundTransparency = 1
    txt.Text = msg
    txt.TextColor3 = Color3.fromRGB(255,255,255)
    txt.TextSize = 16
    txt.Font = Enum.Font.GothamBold
    txt.TextXAlignment = Enum.TextXAlignment.Left
    txt.TextWrapped = true
    txt.Parent = n
    
    TweenService:Create(n, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position=UDim2.new(1,-340,1,-100)}):Play()
    task.wait(3)
    local tw = TweenService:Create(n, TweenInfo.new(0.4), {Position=UDim2.new(1,340,1,-100)})
    tw:Play()
    tw.Completed:Connect(function() n:Destroy() end)
end

-- Execute function
local function exec(id)
    pcall(function()
        MarketplaceService:SignalPromptProductPurchaseFinished(player.UserId, id, true)
    end)
end

-- Create products
for i, p in ipairs(products) do
    local name = isSpanish and p.nameES or p.name
    local yPos = (i-1) * 65
    
    local pf = Instance.new("Frame")
    pf.Size = UDim2.new(1,0,0,58)
    pf.Position = UDim2.new(0,0,0,yPos)
    pf.BackgroundColor3 = Color3.fromRGB(30,32,45)
    pf.BorderSizePixel = 0
    pf.Parent = content
    
    Instance.new("UICorner", pf).CornerRadius = UDim.new(0,10)
    local pfStroke = Instance.new("UIStroke", pf)
    pfStroke.Color = Color3.fromRGB(100,80,180)
    pfStroke.Thickness = 2
    pfStroke.Transparency = 0.7
    
    local ico = Instance.new("Frame")
    ico.Size = UDim2.new(0,38,0,38)
    ico.Position = UDim2.new(0,10,0.5,0)
    ico.AnchorPoint = Vector2.new(0,0.5)
    ico.BackgroundColor3 = Color3.fromRGB(120,80,200)
    ico.BackgroundTransparency = 0.8
    ico.BorderSizePixel = 0
    ico.Parent = pf
    
    Instance.new("UICorner", ico).CornerRadius = UDim.new(1,0)
    
    local icoLbl = Instance.new("TextLabel")
    icoLbl.Size = UDim2.new(1,0,1,0)
    icoLbl.BackgroundTransparency = 1
    icoLbl.Text = p.icon
    icoLbl.TextSize = 22
    icoLbl.Parent = ico
    
    local nameLbl = Instance.new("TextLabel")
    nameLbl.Size = p.hasAuto and UDim2.new(1,-140,1,0) or UDim2.new(1,-60,1,0)
    nameLbl.Position = UDim2.new(0,54,0,0)
    nameLbl.BackgroundTransparency = 1
    nameLbl.Text = name
    nameLbl.TextColor3 = Color3.fromRGB(230,230,250)
    nameLbl.TextSize = 16
    nameLbl.Font = Enum.Font.GothamMedium
    nameLbl.TextXAlignment = Enum.TextXAlignment.Left
    nameLbl.Parent = pf
    
    local mainBtn = Instance.new("TextButton")
    mainBtn.Size = p.hasAuto and UDim2.new(1,-75,1,0) or UDim2.new(1,0,1,0)
    mainBtn.BackgroundTransparency = 1
    mainBtn.Text = ""
    mainBtn.ZIndex = 2
    mainBtn.Parent = pf
    
    -- Added VIP check for first product
    mainBtn.MouseButton1Click:Connect(function()
        if i == 1 then -- VIP Access
            if hasVIP then
                notify(isSpanish and "Ya tienes VIP" or "Already VIP")
                return
            else
                hasVIP = true
            end
        end
        exec(p.id)
        notify(name)
        TweenService:Create(pfStroke, TweenInfo.new(0.15), {Transparency=0, Color=Color3.fromRGB(180,120,255)}):Play()
        task.wait(0.15)
        TweenService:Create(pfStroke, TweenInfo.new(0.3), {Transparency=0.7, Color=Color3.fromRGB(100,80,180)}):Play()
    end)
    
    mainBtn.MouseEnter:Connect(function()
        TweenService:Create(pfStroke, TweenInfo.new(0.2), {Transparency=0.3}):Play()
        TweenService:Create(pf, TweenInfo.new(0.2), {BackgroundColor3=Color3.fromRGB(40,42,55)}):Play()
    end)
    
    mainBtn.MouseLeave:Connect(function()
        TweenService:Create(pfStroke, TweenInfo.new(0.2), {Transparency=0.7}):Play()
        TweenService:Create(pf, TweenInfo.new(0.2), {BackgroundColor3=Color3.fromRGB(30,32,45)}):Play()
    end)
    
    if p.hasAuto then
        local autoBtn = Instance.new("TextButton")
        autoBtn.Size = UDim2.new(0,65,0,38)
        autoBtn.Position = UDim2.new(1,-72,0.5,0)
        autoBtn.AnchorPoint = Vector2.new(0,0.5)
        autoBtn.BackgroundColor3 = Color3.fromRGB(120,80,200)
        autoBtn.Text = "AUTO"
        autoBtn.TextColor3 = Color3.fromRGB(255,255,255)
        autoBtn.TextSize = 14
        autoBtn.Font = Enum.Font.GothamBold
        autoBtn.ZIndex = 3
        autoBtn.Parent = pf
        
        Instance.new("UICorner", autoBtn).CornerRadius = UDim.new(0,8)
        
        local autoRunning = false
        local conn
        
        autoBtn.MouseButton1Click:Connect(function()
            autoRunning = not autoRunning
            if autoRunning then
                autoBtn.BackgroundColor3 = Color3.fromRGB(220,50,50)
                autoBtn.Text = "■"
                notify((isSpanish and "Modo Auto Activado" or "Auto Mode Enabled") .. "\n" .. name)
                conn = RunService.Heartbeat:Connect(function()
                    exec(p.id)
                end)
            else
                autoBtn.BackgroundColor3 = Color3.fromRGB(120,80,200)
                autoBtn.Text = "AUTO"
                notify((isSpanish and "Modo Auto Desactivado" or "Auto Mode Disabled") .. "\n" .. name)
                if conn then conn:Disconnect() end
            end
        end)
    end
end

-- Floating minimize button
local floatBtn = Instance.new("ImageButton")
floatBtn.Size = UDim2.new(0,50,0,50)
floatBtn.Position = UDim2.new(1,-70,0,20)
floatBtn.BackgroundTransparency = 1
floatBtn.Image = "rbxassetid://117159018829978"
floatBtn.ZIndex = 10000
floatBtn.Parent = sg

local isMinimized = false
local dragStart, startPos

-- Fixed minimize to completely hide main frame
floatBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        main.Visible = false
    else
        main.Visible = true
        TweenService:Create(main, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size=UDim2.new(0,400,0,500)}):Play()
    end
end)

floatBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragStart = input.Position
        startPos = floatBtn.Position
    end
end)

floatBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if dragStart then
            local delta = input.Position - dragStart
            floatBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end
end)

floatBtn.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragStart = nil
    end
end)

-- Make main draggable
local dragging, dragInput, dragStart2, startPos2

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart2 = input.Position
        startPos2 = main.Position
    end
end)

header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

header.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart2
        main.Position = UDim2.new(startPos2.X.Scale, startPos2.X.Offset + delta.X, startPos2.Y.Scale, startPos2.Y.Offset + delta.Y)
    end
end)

print("KIMIKO BETA loaded successfully")
