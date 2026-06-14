-- Script: JoseAngel_Blox kick
-- VERSIÓN FINAL ESTABLE
-- ✅ Minimizar/Maximizar funciona
-- ✅ Scroll suave
-- ✅ Tamaño perfecto

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")

local LocalPlayer = Players.LocalPlayer
local Character, Humanoid, HumanoidRootPart

local function UpdateCharacter()
    Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    Humanoid = Character:WaitForChild("Humanoid")
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
end
UpdateCharacter()

-- ==============================================
-- INTERFAZ
-- ==============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Blox kick"
ScreenGui.Parent = LocalPlayer.PlayerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

-- MARCO PRINCIPAL
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainWindow"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
MainFrame.Size = UDim2.new(0, 380, 0, 420)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -210)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

-- BOTÓN MINIMIZAR
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Parent = MainFrame
MinimizeButton.BackgroundColor3 = Color3.new(0, 0.6, 0)
MinimizeButton.Size = UDim2.new(0, 50, 0, 30)
MinimizeButton.Position = UDim2.new(1, -60, 0, 5)
MinimizeButton.Text = "➖"
MinimizeButton.TextColor3 = Color3.new(1,1,1)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 18
MinimizeButton.ZIndex = 10

local CornerMin = Instance.new("UICorner")
CornerMin.CornerRadius = UDim.new(0,10)
CornerMin.Parent = MinimizeButton

-- SCROLLING FRAME
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Name = "Content"
ScrollingFrame.Parent = MainFrame
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.Size = UDim2.new(1, 0, 1, -50)
ScrollingFrame.Position = UDim2.new(0, 0, 0, 45)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 780)
ScrollingFrame.ScrollBarThickness = 5
ScrollingFrame.Active = true
ScrollingFrame.ScrollingEnabled = true
ScrollingFrame.TopImage = "rbxassetid://293194640"
ScrollingFrame.MidImage = "rbxassetid://293194640"
ScrollingFrame.BottomImage = "rbxassetid://293194640"

-- ==============================================
-- ELEMENTOS
-- ==============================================
local TitleText = Instance.new("TextLabel")
TitleText.Name = "Title"
TitleText.Parent = ScrollingFrame
TitleText.BackgroundTransparency = 1
TitleText.Size = UDim2.new(1, -20, 0, 40)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.Font = Enum.Font.GothamBold
TitleText.Text = "JoseAngel_Blox kick"
TitleText.TextColor3 = Color3.new(1, 1, 1)
TitleText.TextSize = 22

local InfoSection = Instance.new("TextLabel")
InfoSection.Parent = ScrollingFrame
InfoSection.BackgroundTransparency = 1
InfoSection.Size = UDim2.new(1, -20, 0, 50)
InfoSection.Position = UDim2.new(0, 10, 0, 45)
InfoSection.Font = Enum.Font.Gotham
InfoSection.Text = "Creador: JoseAngel_Blox\nFecha: 14/06/2026"
InfoSection.TextColor3 = Color3.new(1, 1, 1)
InfoSection.TextSize = 14
InfoSection.TextWrapped = true

-- FUNCION CREAR BOTONES
local function CreateBtn(name, posY, color)
    local btn = Instance.new("TextButton")
    btn.Parent = ScrollingFrame
    btn.BackgroundColor3 = color or Color3.new(0.1,0.1,0.1)
    btn.Size = UDim2.new(1, -20, 0, 35)
    btn.Position = UDim2.new(0, 10, 0, posY)
    btn.Font = Enum.Font.GothamBold
    btn.Text = name
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextSize = 14
    btn.AutoLocalize = false
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0,8)
    c.Parent = btn
    return btn
end

-- SECCION MAIN
local MainLabel = CreateBtn("Main ↓", 100)
MainLabel.BackgroundColor3 = Color3.new(0,0,0)
MainLabel.Active = false

local AutoKickButton = CreateBtn("🔴 AUTO KICK - OFF", 130)
local AutoCollectButton = CreateBtn("🔴 AUTO COLECT - OFF", 170)
local AutoWeightButton = CreateBtn("🔴 AUTO WEIGHT - OFF", 210)
local AutoClickButton = CreateBtn("🔴 AUTO CLICK X2 - OFF", 250)
local FreezeTradeButton = CreateBtn("🔴 FREEZE TRADE - OFF", 290)
local AutoEventButton = CreateBtn("🏆 AUTO EVENTO - OFF", 330, Color3.new(1,0.5,0))

-- SECCION PLAYER
local PlayerLabel = CreateBtn("Player ↓", 375)
PlayerLabel.BackgroundColor3 = Color3.new(0,0,0)
PlayerLabel.Active = false

local WalkspeedButton = CreateBtn("🏃 WALKSPEED - 16", 410)
local FlyButton = CreateBtn("✈️ FLY - OFF", 450)

-- SECCION OPTIMIZACION
local OptimizeLabel = CreateBtn("Optimización ↓", 495)
OptimizeLabel.BackgroundColor3 = Color3.new(0,0,0)
OptimizeLabel.Active = false

local FPSLabel = CreateBtn("📊 FPS: Cargando...", 530)
FPSLabel.Active = false
local AntiLagButton = CreateBtn("🧹 ANTI LAG - OFF", 570)

-- ==============================================
-- LOGICA MINIMIZAR
-- ==============================================
local IsMinimized = false
local OriginalSize = MainFrame.Size
local OriginalPos = MainFrame.Position

MinimizeButton.MouseButton1Click:Connect(function()
    IsMinimized = not IsMinimized
    if IsMinimized then
        ScrollingFrame.Visible = false
        MainFrame.Size = UDim2.new(0, 70, 0, 40)
        MainFrame.Position = UDim2.new(0, 10, 0, 10)
        MinimizeButton.Text = "➕"
        MinimizeButton.Position = UDim2.new(0.5, -25, 0.5, -15)
    else
        ScrollingFrame.Visible = true
        MainFrame.Size = OriginalSize
        MainFrame.Position = OriginalPos
        MinimizeButton.Text = "➖"
        MinimizeButton.Position = UDim2.new(1, -60, 0, 5)
    end
end)

-- ==============================================
-- ANIMACION FONDO
-- ==============================================
coroutine.wrap(function()
    while wait(1) do
        TweenService:Create(MainFrame, TweenInfo.new(1), {BackgroundColor3 = Color3.new(1, 0, 0)}):Play()
        wait(1)
        TweenService:Create(MainFrame, TweenInfo.new(1), {BackgroundColor3 = Color3.new(0, 0, 0)}):Play()
    end
end)()

-- ==============================================
-- FUNCIONES
-- ==============================================

-- AUTO KICK
local AutoKickActive = false
local KickSpeed = 0.5
local function GetRemote() return ReplicatedStorage:FindFirstChild("KickEvent") or ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("Kick") end
coroutine.wrap(function()
    while true do
        if AutoKickActive then
            local r = GetRemote()
            if r then r:FireServer() end
        end
        task.wait(KickSpeed)
    end
end)()
AutoKickButton.MouseButton1Click:Connect(function()
    AutoKickActive = not AutoKickActive
    if AutoKickActive then
        AutoKickButton.Text = "🟢 AUTO KICK - ON"
        AutoKickButton.BackgroundColor3 = Color3.new(0,0.6,0)
    else
        AutoKickButton.Text = "🔴 AUTO KICK - OFF"
        AutoKickButton.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
    end
end)

-- AUTO COLECT
local AutoCollectActive = false
coroutine.wrap(function()
    while true do
        if AutoCollectActive and HumanoidRootPart then
            for _, i in pairs(Workspace:GetChildren()) do
                if i:FindFirstChildWhichIsA("ProximityPrompt") then fireproximityprompt(i.ProximityPrompt) end
                if string.find(string.lower(i.Name), "money") or string.find(string.lower(i.Name), "cash") or string.find(string.lower(i.Name), "coin") or string.find(string.lower(i.Name), "orb") then
                    if i:FindFirstChild("TouchInterest") then firetouchinterest(HumanoidRootPart, i, 0) end
                end
            end
        end
        task.wait(0.2)
    end
end)()
AutoCollectButton.MouseButton1Click:Connect(function()
    AutoCollectActive = not AutoCollectActive
    if AutoCollectActive then
        AutoCollectButton.Text = "🟢 AUTO COLECT - ON"
        AutoCollectButton.BackgroundColor3 = Color3.new(1,0.8,0)
    else
        AutoCollectButton.Text = "🔴 AUTO COLECT - OFF"
        AutoCollectButton.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
    end
end)

-- AUTO WEIGHT
local AutoWeightActive = false
coroutine.wrap(function()
    while true do
        if AutoWeightActive then
            VirtualUser:CaptureController()
            VirtualUser:ClickButton1(Vector2.new(0,0))
            task.wait(0.1)
            VirtualUser:ReleaseController()
            for _, o in pairs(Workspace:GetChildren()) do
                if string.find(string.lower(o.Name), "weight") or string.find(string.lower(o.Name), "train") then
                    if o:FindFirstChildWhichIsA("ProximityPrompt") then fireproximityprompt(o.ProximityPrompt) end
                end
            end
        end
        task.wait(0.3)
    end
end)()
AutoWeightButton.MouseButton1Click:Connect(function()
    AutoWeightActive = not AutoWeightActive
    if AutoWeightActive then
        AutoWeightButton.Text = "🟢 AUTO WEIGHT - ON"
        AutoWeightButton.BackgroundColor3 = Color3.new(0,0.4,1)
    else
        AutoWeightButton.Text = "🔴 AUTO WEIGHT - OFF"
        AutoWeightButton.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
    end
end)

-- AUTO CLICK
local AutoClickActive = false
coroutine.wrap(function()
    while true do
        if AutoClickActive then
            VirtualUser:CaptureController()
            VirtualUser:ClickButton1(Vector2.new(0,0))
            task.wait(0.05)
            VirtualUser:ClickButton1(Vector2.new(0,0))
            VirtualUser:ReleaseController()
        end
        task.wait(0.1)
    end
end)()
AutoClickButton.MouseButton1Click:Connect(function()
    AutoClickActive = not AutoClickActive
    if AutoClickActive then
        AutoClickButton.Text = "🟣 AUTO CLICK X2 - ON"
        AutoClickButton.BackgroundColor3 = Color3.new(0.6,0,1)
        KickSpeed = 0.25
    else
        AutoClickButton.Text = "🔴 AUTO CLICK X2 - OFF"
        AutoClickButton.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
        KickSpeed = 0.5
    end
end)

-- FREEZE TRADE
local FreezeTradeActive = false
local ConnectionFreeze = nil
FreezeTradeButton.MouseButton1Click:Connect(function()
    FreezeTradeActive = not FreezeTradeActive
    if FreezeTradeActive then
        FreezeTradeButton.Text = "❄️ FREEZE TRADE - ON"
        FreezeTradeButton.BackgroundColor3 = Color3.new(0,0.8,1)
        ConnectionFreeze = RunService.Heartbeat:Connect(function()
            for _, g in pairs(LocalPlayer.PlayerGui:GetChildren()) do
                if g:FindFirstChild("Frame") then
                    for _, f in pairs(g:GetChildren()) do
                        if f:IsA("GuiObject") and f.Active then f.Position = f.Position end
                    end
                end
            end
            for _, p in pairs(Workspace:GetChildren()) do
                if p:IsA("Part") and p.Anchored == false then p.Velocity = Vector3.new(0,0,0) end
            end
        end)
    else
        FreezeTradeButton.Text = "🔴 FREEZE TRADE - OFF"
        FreezeTradeButton.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
        if ConnectionFreeze then ConnectionFreeze:Disconnect() end
    end
end)

-- AUTO EVENTO
local AutoEventActive = false
coroutine.wrap(function()
    while true do
        if AutoEventActive and HumanoidRootPart then
            for _, item in pairs(Workspace:GetChildren()) do
                if item.Color == Color3.new(1,0.5,0) or string.find(string.lower(item.Name), "orange") or string.find(string.lower(item.Name), "ball") or string.find(string.lower(item.Name), "cup") then
                    if item:FindFirstChild("TouchInterest") then firetouchinterest(HumanoidRootPart, item, 0) end
                    if item:FindFirstChildWhichIsA("ProximityPrompt") then fireproximityprompt(item.ProximityPrompt) end
                end
            end
        end
        task.wait(0.1)
    end
end)()
AutoEventButton.MouseButton1Click:Connect(function()
    AutoEventActive = not AutoEventActive
    if AutoEventActive then
        AutoEventButton.Text = "🏆 AUTO EVENTO - ON"
        AutoEventButton.BackgroundColor3 = Color3.new(1,0.7,0)
    else
        AutoEventButton.Text = "🏆 AUTO EVENTO - OFF"
        AutoEventButton.BackgroundColor3 = Color3.new(1,0.5,0)
    end
end)

-- WALKSPEED
local SpeedLevel = 1
local Speeds = {16, 50, 100, 300}
WalkspeedButton.MouseButton1Click:Connect(function()
    UpdateCharacter()
    SpeedLevel = SpeedLevel + 1
    if SpeedLevel > #Speeds then SpeedLevel = 1 end
    local ns = Speeds[SpeedLevel]
    Humanoid.WalkSpeed = ns
    if ns == 16 then
        WalkspeedButton.Text = "🏃 WALKSPEED - NORMAL"
        WalkspeedButton.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
    elseif ns == 50 then
        WalkspeedButton.Text = "🏃 WALKSPEED - RÁPIDO"
        WalkspeedButton.BackgroundColor3 = Color3.new(0,0.6,1)
    elseif ns == 100 then
        WalkspeedButton.Text = "🏃 WALKSPEED - MUY RÁPIDO"
        WalkspeedButton.BackgroundColor3 = Color3.new(0,0.4,0.8)
    else
        WalkspeedButton.Text = "🏃 WALKSPEED - MAXIMO"
        WalkspeedButton.BackgroundColor3 = Color3.new(0,0.2,0.6)
    end
end)

-- FLY
local FlyActive = false
local SpeedFly = 50
local Direction = Vector3.new(0,0,0)
ContextActionService:BindAction("MoveFly", function(name, state, input)
    if not FlyActive then return end
    Direction = Vector3.new(input.Position.X, input.Position.Y, 0) * -1
end, false, Enum.PlayerActions.CharacterMoveAction)

coroutine.wrap(function()
    while true do
        if FlyActive and HumanoidRootPart and Humanoid then
            Humanoid.PlatformStand = true
            HumanoidRootPart.Velocity = Vector3.new(0,0,0)
            local camCF = workspace.CurrentCamera.CFrame
            local moveDir = CFrame.new() * camCF
            local finalVel = Vector3.new(0,0,0)
            if Direction.Magnitude > 0.1 then
                finalVel = moveDir:VectorToWorldSpace(Direction * SpeedFly)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then finalVel += Vector3.new(0,SpeedFly,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then finalVel += Vector3.new(0,-SpeedFly,0) end
            HumanoidRootPart.Velocity = finalVel
        end
        task.wait(0.01)
    end
end)()

FlyButton.MouseButton1Click:Connect(function()
    UpdateCharacter()
    FlyActive = not FlyActive
    if FlyActive then
        FlyButton.Text = "✈️ FLY - ON"
        FlyButton.BackgroundColor3 = Color3.new(1,0.6,0)
        Humanoid.PlatformStand = true
        HumanoidRootPart.Anchored = false
    else
        FlyButton.Text = "✈️ FLY - OFF"
        FlyButton.BackgroundColor3 = Color3.new(0.1,0.1,0.1)
        Humanoid.PlatformStand = false
        Direction = Vector3.new(0,0,0)
    end
end)

-- FPS
local FrameCount = 0
local LastTime = tick()
RunService.Heartbeat:Connect(function(dt)
    FrameCount += 1
    if tick() - LastTime >= 1 then
        local fps = FrameCount
        FrameCount = 0
        LastTime = tick()
        FPSLabel.Text = "📊 FPS: " .. math.floor(fps)
        if fps >= 50 then
            FPSLabel.BackgroundColor3 = Color3.new(0,0.6,0)
        elseif fps >= 30 then
            FPSLabel.BackgroundColor3 = Color3.new(1,0.8,0)
        else
            FPSLabel.BackgroundColor3 = Color3.new(1,0,0)
        end
    end
end)

-- ANTI LAG
local AntiLagActive = false
local ConnectionLag = nil
AntiLagButton.MouseButton1Click:Connect(function()
    AntiLagActive = not AntiLagActive
    if AntiLagActive then
        AntiLagButton.Text = "🧹 ANTI LAG - ON"
        AntiLagButton.BackgroundColor3 = Color3.new(0,0.6,1)
        for _, v in pairs(Workspace:GetChildren()) do
            if v:IsA("Part") or v:IsA("MeshPart") then
                if not v:IsAncestorOf(Character) and v.Name ~= "Baseplate" and v.Anchored == false then
                    v:Destroy()
                end
            end
        end
        ConnectionLag = RunService.Heartbeat:Connect(function()
            settings().Rendering.QualityLevel = 1
            settings().Rendering.FramerateLimit = 60
        end)
    else
        AntiLagButton.Text = "🧹 ANTI LAG - OFF"
        AntiLagButton.BackgroundColor3 = Color3.new(0.15,0.15,0.15)
        if ConnectionLag then ConnectionLag:Disconnect() end
    end
end)

LocalPlayer.CharacterAdded:Connect(function()
    while true do
        task.wait(1)
        UpdateCharacter()
    end
end)

print("✅ Script CARGADO CORRECTAMENTE! 😎🚀")
