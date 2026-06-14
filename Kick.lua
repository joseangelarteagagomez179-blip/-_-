-- Script: JoseAngel_Blox kick
-- Diseño: Cuadrado, esquinas redondeadas, fondo animado Rojo/Negro
-- Incluye funciones para el evento Block Cup 🏆

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- ==============================================
-- CREACIÓN DE LA INTERFAZ
-- ==============================================
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleText = Instance.new("TextLabel")
local InfoSection = Instance.new("TextLabel")

-- === SECCIÓN MAIN ===
local MainLabel = Instance.new("TextLabel")
local AutoKickButton = Instance.new("TextButton")
local AutoCollectButton = Instance.new("TextButton")
local AutoWeightButton = Instance.new("TextButton")
local AutoClickButton = Instance.new("TextButton")
local FreezeTradeButton = Instance.new("TextButton")
local AutoEventButton = Instance.new("TextButton") -- NUEVO: Botón Evento

-- === SECCIÓN PLAYER ===
local PlayerLabel = Instance.new("TextLabel")
local WalkspeedButton = Instance.new("TextButton")
local FlyButton = Instance.new("TextButton")

-- === SECCIÓN OPTIMIZACIÓN ===
local OptimizeLabel = Instance.new("TextLabel")
local FPSLabel = Instance.new("TextLabel")
local AntiLagButton = Instance.new("TextButton")

-- Propiedades de la ventana
ScreenGui.Name = "JoseAngel_Blox kick"
ScreenGui.Parent = LocalPlayer.PlayerGui

MainFrame.Name = "MainWindow"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
MainFrame.Size = UDim2.new(0, 300, 0, 580) -- Aumentado
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -290)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true

-- Esquinas redondeadas
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

-- TÍTULO PRINCIPAL
TitleText.Name = "Title"
TitleText.Parent = MainFrame
TitleText.BackgroundTransparency = 1
TitleText.Size = UDim2.new(1, 0, 0, 40)
TitleText.Position = UDim2.new(0, 0, 0, 10)
TitleText.Font = Enum.Font.GothamBold
TitleText.Text = "JoseAngel_Blox kick"
TitleText.TextColor3 = Color3.new(1, 1, 1)
TitleText.TextSize = 22

-- ==============================================
-- 1) SECCIÓN DE INFORMACIÓN ↓
-- ==============================================
InfoSection.Name = "InfoText"
InfoSection.Parent = MainFrame
InfoSection.BackgroundTransparency = 1
InfoSection.Size = UDim2.new(1, 0, 0, 60)
InfoSection.Position = UDim2.new(0, 0, 0, 45)
InfoSection.Font = Enum.Font.Gotham
InfoSection.Text = "Creador: JoseAngel_Blox\nFecha: 14/06/2026"
InfoSection.TextColor3 = Color3.new(1, 1, 1)
InfoSection.TextSize = 16
InfoSection.TextWrapped = true

-- ==============================================
-- 2) SECCIÓN MAIN ↓
-- ==============================================
MainLabel.Name = "MainTitle"
MainLabel.Parent = MainFrame
MainLabel.BackgroundTransparency = 1
MainLabel.Size = UDim2.new(1, 0, 0, 30)
MainLabel.Position = UDim2.new(0, 0, 0, 105)
MainLabel.Font = Enum.Font.GothamBold
MainLabel.Text = "Main ↓"
MainLabel.TextColor3 = Color3.new(1, 1, 1)
MainLabel.TextSize = 18

-- BOTÓN 1: AUTO KICK
AutoKickButton.Name = "AutoKickButton"
AutoKickButton.Parent = MainFrame
AutoKickButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
AutoKickButton.Size = UDim2.new(0.8, 0, 0, 32)
AutoKickButton.Position = UDim2.new(0.1, 0, 0, 135)
AutoKickButton.Font = Enum.Font.GothamBold
AutoKickButton.Text = "🔴 AUTO KICK - OFF"
AutoKickButton.TextColor3 = Color3.new(1, 1, 1)
AutoKickButton.TextSize = 14

local BtnCorner1 = Instance.new("UICorner")
BtnCorner1.CornerRadius = UDim.new(0, 8)
BtnCorner1.Parent = AutoKickButton

-- BOTÓN 2: AUTO RECOLECTAR DINERO
AutoCollectButton.Name = "AutoCollectButton"
AutoCollectButton.Parent = MainFrame
AutoCollectButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
AutoCollectButton.Size = UDim2.new(0.8, 0, 0, 32)
AutoCollectButton.Position = UDim2.new(0.1, 0, 0, 168)
AutoCollectButton.Font = Enum.Font.GothamBold
AutoCollectButton.Text = "🔴 AUTO COLECT - OFF"
AutoCollectButton.TextColor3 = Color3.new(1, 1, 1)
AutoCollectButton.TextSize = 14

local BtnCorner2 = Instance.new("UICorner")
BtnCorner2.CornerRadius = UDim.new(0, 8)
BtnCorner2.Parent = AutoCollectButton

-- BOTÓN 3: AUTO WEIGHT
AutoWeightButton.Name = "AutoWeightButton"
AutoWeightButton.Parent = MainFrame
AutoWeightButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
AutoWeightButton.Size = UDim2.new(0.8, 0, 0, 32)
AutoWeightButton.Position = UDim2.new(0.1, 0, 0, 201)
AutoWeightButton.Font = Enum.Font.GothamBold
AutoWeightButton.Text = "🔴 AUTO WEIGHT - OFF"
AutoWeightButton.TextColor3 = Color3.new(1, 1, 1)
AutoWeightButton.TextSize = 14

local BtnCorner3 = Instance.new("UICorner")
BtnCorner3.CornerRadius = UDim.new(0, 8)
BtnCorner3.Parent = AutoWeightButton

-- BOTÓN 4: AUTO CLICK X2
AutoClickButton.Name = "AutoClickButton"
AutoClickButton.Parent = MainFrame
AutoClickButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
AutoClickButton.Size = UDim2.new(0.8, 0, 0, 32)
AutoClickButton.Position = UDim2.new(0.1, 0, 0, 234)
AutoClickButton.Font = Enum.Font.GothamBold
AutoClickButton.Text = "🔴 AUTO CLICK X2 - OFF"
AutoClickButton.TextColor3 = Color3.new(1, 1, 1)
AutoClickButton.TextSize = 14

local BtnCorner4 = Instance.new("UICorner")
BtnCorner4.CornerRadius = UDim.new(0, 8)
BtnCorner4.Parent = AutoClickButton

-- BOTÓN 5: FREEZE TRADE
FreezeTradeButton.Name = "FreezeTradeButton"
FreezeTradeButton.Parent = MainFrame
FreezeTradeButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
FreezeTradeButton.Size = UDim2.new(0.8, 0, 0, 32)
FreezeTradeButton.Position = UDim2.new(0.1, 0, 0, 267)
FreezeTradeButton.Font = Enum.Font.GothamBold
FreezeTradeButton.Text = "🔴 FREEZE TRADE - OFF"
FreezeTradeButton.TextColor3 = Color3.new(1, 1, 1)
FreezeTradeButton.TextSize = 14

local BtnCorner5 = Instance.new("UICorner")
BtnCorner5.CornerRadius = UDim.new(0, 8)
BtnCorner5.Parent = FreezeTradeButton

-- BOTÓN 6: AUTO EVENTO 🏆
AutoEventButton.Name = "AutoEventButton"
AutoEventButton.Parent = MainFrame
AutoEventButton.BackgroundColor3 = Color3.new(1, 0.5, 0) -- Color Naranja
AutoEventButton.Size = UDim2.new(0.8, 0, 0, 32)
AutoEventButton.Position = UDim2.new(0.1, 0, 0, 300)
AutoEventButton.Font = Enum.Font.GothamBold
AutoEventButton.Text = "🏆 AUTO EVENTO - OFF"
AutoEventButton.TextColor3 = Color3.new(1, 1, 1)
AutoEventButton.TextSize = 14

local BtnCorner6 = Instance.new("UICorner")
BtnCorner6.CornerRadius = UDim.new(0, 8)
BtnCorner6.Parent = AutoEventButton

-- ==============================================
-- 3) SECCIÓN PLAYER ↓
-- ==============================================
PlayerLabel.Name = "PlayerTitle"
PlayerLabel.Parent = MainFrame
PlayerLabel.BackgroundTransparency = 1
PlayerLabel.Size = UDim2.new(1, 0, 0, 30)
PlayerLabel.Position = UDim2.new(0, 0, 0, 340)
PlayerLabel.Font = Enum.Font.GothamBold
PlayerLabel.Text = "Player ↓"
PlayerLabel.TextColor3 = Color3.new(1, 1, 1)
PlayerLabel.TextSize = 18

-- BOTÓN: WALKSPEED
WalkspeedButton.Name = "WalkspeedButton"
WalkspeedButton.Parent = MainFrame
WalkspeedButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
WalkspeedButton.Size = UDim2.new(0.8, 0, 0, 35)
WalkspeedButton.Position = UDim2.new(0.1, 0, 0, 370)
WalkspeedButton.Font = Enum.Font.GothamBold
WalkspeedButton.Text = "🏃 WALKSPEED - 16"
WalkspeedButton.TextColor3 = Color3.new(1, 1, 1)
WalkspeedButton.TextSize = 15

local BtnCornerWS = Instance.new("UICorner")
BtnCornerWS.CornerRadius = UDim.new(0, 8)
BtnCornerWS.Parent = WalkspeedButton

-- BOTÓN: FLY ✈️
FlyButton.Name = "FlyButton"
FlyButton.Parent = MainFrame
FlyButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
FlyButton.Size = UDim2.new(0.8, 0, 0, 35)
FlyButton.Position = UDim2.new(0.1, 0, 0, 408)
FlyButton.Font = Enum.Font.GothamBold
FlyButton.Text = "✈️ FLY - OFF"
FlyButton.TextColor3 = Color3.new(1, 1, 1)
FlyButton.TextSize = 15

local BtnCornerFly = Instance.new("UICorner")
BtnCornerFly.CornerRadius = UDim.new(0, 8)
BtnCornerFly.Parent = FlyButton

-- ==============================================
-- 4) SECCIÓN OPTIMIZACIÓN ↓
-- ==============================================
OptimizeLabel.Name = "OptimizeTitle"
OptimizeLabel.Parent = MainFrame
OptimizeLabel.BackgroundTransparency = 1
OptimizeLabel.Size = UDim2.new(1, 0, 0, 30)
OptimizeLabel.Position = UDim2.new(0, 0, 0, 450)
OptimizeLabel.Font = Enum.Font.GothamBold
OptimizeLabel.Text = "Optimización ↓"
OptimizeLabel.TextColor3 = Color3.new(1, 1, 1)
OptimizeLabel.TextSize = 18

-- TEXTO: FPS
FPSLabel.Name = "FPSCounter"
FPSLabel.Parent = MainFrame
FPSLabel.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
FPSLabel.Size = UDim2.new(0.8, 0, 0, 35)
FPSLabel.Position = UDim2.new(0.1, 0, 0, 480)
FPSLabel.Font = Enum.Font.GothamBold
FPSLabel.Text = "📊 FPS: Cargando..."
FPSLabel.TextColor3 = Color3.new(1, 1, 1)
FPSLabel.TextSize = 15

local BtnCornerFPS = Instance.new("UICorner")
BtnCornerFPS.CornerRadius = UDim.new(0, 8)
BtnCornerFPS.Parent = FPSLabel

-- BOTÓN: ANTI LAG 🧹
AntiLagButton.Name = "AntiLagButton"
AntiLagButton.Parent = MainFrame
AntiLagButton.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
AntiLagButton.Size = UDim2.new(0.8, 0, 0, 35)
AntiLagButton.Position = UDim2.new(0.1, 0, 0, 518)
AntiLagButton.Font = Enum.Font.GothamBold
AntiLagButton.Text = "🧹 ANTI LAG - OFF"
AntiLagButton.TextColor3 = Color3.new(1, 1, 1)
AntiLagButton.TextSize = 15

local BtnCornerAL = Instance.new("UICorner")
BtnCornerAL.CornerRadius = UDim.new(0, 8)
BtnCornerAL.Parent = AntiLagButton

-- ==============================================
-- ANIMACIÓN DE FONDO (ROJO Y NEGRO)
-- ==============================================
coroutine.wrap(function()
    while true do
        local t1 = TweenService:Create(MainFrame, TweenInfo.new(1), {BackgroundColor3 = Color3.new(1, 0, 0)})
        t1:Play()
        t1.Completed:Wait()
        local t2 = TweenService:Create(MainFrame, TweenInfo.new(1), {BackgroundColor3 = Color3.new(0, 0, 0)})
        t2:Play()
        t2.Completed:Wait()
    end
end)()

-- ==============================================
-- LÓGICA AUTO KICK
-- ==============================================
local AutoKickActive = false
local KickSpeed = 0.5

local function GetRemote()
    return ReplicatedStorage:FindFirstChild("KickEvent") 
        or ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("Kick")
end

coroutine.wrap(function()
    while true do
        if AutoKickActive then
            local Remote = GetRemote()
            if Remote then
                Remote:FireServer()
            end
        end
        task.wait(KickSpeed)
    end
end)()

AutoKickButton.MouseButton1Click:Connect(function()
    AutoKickActive = not AutoKickActive
    if AutoKickActive then
        AutoKickButton.Text = "🟢 AUTO KICK - ON"
        AutoKickButton.BackgroundColor3 = Color3.new(0, 0.6, 0)
    else
        AutoKickButton.Text = "🔴 AUTO KICK - OFF"
        AutoKickButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    end
end)

-- ==============================================
-- LÓGICA AUTO RECOLECTAR DINERO 💰
-- ==============================================
local AutoCollectActive = false

coroutine.wrap(function()
    while true do
        if AutoCollectActive then
            for _, item in pairs(Workspace:GetChildren()) do
                if item:FindFirstChildWhichIsA("ProximityPrompt") then
                    fireproximityprompt(item.ProximityPrompt)
                end
                if string.find(string.lower(item.Name), "money") or string.find(string.lower(item.Name), "cash") or string.find(string.lower(item.Name), "coin") or string.find(string.lower(item.Name), "orb") then
                    if item:FindFirstChild("TouchInterest") then
                        firetouchinterest(Character.HumanoidRootPart, item, 0)
                    end
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
        AutoCollectButton.BackgroundColor3 = Color3.new(1, 0.8, 0)
    else
        AutoCollectButton.Text = "🔴 AUTO COLECT - OFF"
        AutoCollectButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    end
end)

-- ==============================================
-- LÓGICA AUTO WEIGHT 💪
-- ==============================================
local AutoWeightActive = false

coroutine.wrap(function()
    while true do
        if AutoWeightActive then
            VirtualUser:CaptureController()
            VirtualUser:ClickButton1(Vector2.new(0,0))
            task.wait(0.1)
            VirtualUser:ReleaseController()
            
            for _, obj in pairs(Workspace:GetChildren()) do
                if string.find(string.lower(obj.Name), "weight") or string.find(string.lower(obj.Name), "train") then
                    if obj:FindFirstChildWhichIsA("ProximityPrompt") then
                        fireproximityprompt(obj.ProximityPrompt)
                    end
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
        AutoWeightButton.BackgroundColor3 = Color3.new(0, 0.4, 1)
    else
        AutoWeightButton.Text = "🔴 AUTO WEIGHT - OFF"
        AutoWeightButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    end
end)

-- ==============================================
-- LÓGICA AUTO CLICK X2 ⚡️
-- ==============================================
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
        AutoClickButton.BackgroundColor3 = Color3.new(0.6, 0, 1)
        KickSpeed = 0.25
    else
        AutoClickButton.Text = "🔴 AUTO CLICK X2 - OFF"
        AutoClickButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
        KickSpeed = 0.5
    end
end)

-- ==============================================
-- LÓGICA FREEZE TRADE ❄️🔒
-- ==============================================
local FreezeTradeActive = false
local ConnectionFreeze = nil

FreezeTradeButton.MouseButton1Click:Connect(function()
    FreezeTradeActive = not FreezeTradeActive
    if FreezeTradeActive then
        FreezeTradeButton.Text = "❄️ FREEZE TRADE - ON"
        FreezeTradeButton.BackgroundColor3 = Color3.new(0, 0.8, 1)
        
        ConnectionFreeze = RunService.Heartbeat:Connect(function()
            for _, gui in pairs(LocalPlayer.PlayerGui:GetChildren()) do
                if gui:FindFirstChild("Frame") then
                    for _, frame in pairs(gui:GetChildren()) do
                        if frame:IsA("GuiObject") and frame.Active then
                            frame.Position = frame.Position
                        end
                    end
                end
            end
            for _, part in pairs(Workspace:GetChildren()) do
                if part:IsA("Part") and part.Anchored == false then
                    part.Velocity = Vector3.new(0,0,0)
                end
            end
        end)
    else
        FreezeTradeButton.Text = "🔴 FREEZE TRADE - OFF"
        FreezeTradeButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
        if ConnectionFreeze then
            ConnectionFreeze:Disconnect()
        end
    end
end)

-- ==============================================
-- LÓGICA AUTO EVENTO 🏆 (Bolas Naranjas)
-- ==============================================
local AutoEventActive = false

coroutine.wrap(function()
    while true do
        if AutoEventActive then
            for _, item in pairs(Workspace:GetChildren()) do
                -- Buscar bolas naranjas del evento
                if item.Color == Color3.new(1, 0.5, 0) or string.find(string.lower(item.Name), "orange") or string.find(string.lower(item.Name), "ball") or string.find(string.lower(item.Name), "cup") then
                    if item:FindFirstChild("TouchInterest") then
                        firetouchinterest(Character.HumanoidRootPart, item, 0)
                    end
                    if item:FindFirstChildWhichIsA("ProximityPrompt") then
                        fireproximityprompt(item.ProximityPrompt)
                    end
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
        AutoEventButton.BackgroundColor3 = Color3.new(1, 0.7, 0)
    else
        AutoEventButton.Text = "🏆 AUTO EVENTO - OFF"
        AutoEventButton.BackgroundColor3 = Color3.new(1, 0.5, 0)
    end
end)

-- ==============================================
-- LÓGICA WALKSPEED 🏃💨
-- ==============================================
local SpeedLevel = 1
local Speeds = {16, 50, 100, 300}

WalkspeedButton.MouseButton1Click:Connect(function()
    SpeedLevel = SpeedLevel + 1
    if SpeedLevel > #Speeds then SpeedLevel = 1 end
    
    local NewSpeed = Speeds[SpeedLevel]
    Humanoid.WalkSpeed = NewSpeed
    
    if NewSpeed == 16 then
        WalkspeedButton.Text = "🏃 WALKSPEED - NORMAL"
        WalkspeedButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    elseif NewSpeed == 50 then
        WalkspeedButton.Text = "🏃 WALKSPEED - RÁPIDO"
        WalkspeedButton.BackgroundColor3 = Color3.new(0, 0.6, 1)
    elseif NewSpeed == 100 then
        WalkspeedButton.Text = "🏃 WALKSPEED - MUY RÁPIDO"
        WalkspeedButton.BackgroundColor3 = Color3.new(0, 0.4, 0.8)
    else
        WalkspeedButton.Text = "🏃 WALKSPEED - MAXIMO"
        WalkspeedButton.BackgroundColor3 = Color3.new(0, 0.2, 0.6)
    end
end)

-- ==============================================
-- LÓGICA FLY ✈️ (Compatible con Joystick)
-- ==============================================
local FlyActive = false
local SpeedFly = 50
local Direction = Vector3.new(0,0,0)

local function UpdateCharacter()
    Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    Humanoid = Character:WaitForChild("Humanoid")
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
end

ContextActionService:BindAction("MoveFly", function(name, state, input)
    if not FlyActive then return end
    Direction = Vector3.new(input.Position.X, input.Position.Y, 0) * -1
end, false, Enum.PlayerActions.CharacterMoveAction)

coroutine.wrap(function()
    while true do
        if FlyActive and HumanoidRootPart then
            Humanoid.PlatformStand = true
            HumanoidRootPart.Velocity = Vector3.new(0,0,0)
            
            local CameraCF = workspace.CurrentCamera.CFrame
            local MoveDir = CFrame.new(0,0,0) * CameraCF
            
            local FinalVelocity = Vector3.new(0,0,0)
            
            if Direction.Magnitude > 0.1 then
                FinalVelocity = MoveDir:VectorToWorldSpace(Direction * SpeedFly)
            end
            
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                FinalVelocity += Vector3.new(0,SpeedFly,0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                FinalVelocity += Vector3.new(0,-SpeedFly,0)
            end
            
            HumanoidRootPart.Velocity = FinalVelocity
        end
        task.wait(0.01)
    end
end)()

FlyButton.MouseButton1Click:Connect(function()
    FlyActive = not FlyActive
    UpdateCharacter()
    
    if FlyActive then
        FlyButton.Text = "✈️ FLY - ON"
        FlyButton.BackgroundColor3 = Color3.new(1, 0.6, 0)
        Humanoid.PlatformStand = true
        HumanoidRootPart.Anchored = false
    else
        FlyButton.Text = "✈️ FLY - OFF"
        FlyButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
        Humanoid.PlatformStand = false
        Direction = Vector3.new(0,0,0)
    end
end)

-- ==============================================
-- LÓGICA FPS 📊
-- ==============================================
local FrameCount = 0
local LastTime = tick()

RunService.Heartbeat:Connect(function(deltaTime)
    FrameCount += 1
    if tick() - LastTime >= 1 then
        local FPS = FrameCount
        FrameCount = 0
        LastTime = tick()
        
        FPSLabel.Text = "📊 FPS: " .. math.floor(FPS)
        
        if FPS >= 50 then
            FPSLabel.BackgroundColor3 = Color3.new(0, 0.6, 0)
        elseif FPS >= 30 then
            FPSLabel.BackgroundColor3 = Color3.new(1, 0.8, 0)
        else
            FPSLabel.BackgroundColor3 = Color3.new(1, 0, 0)
        end
    end
end)

-- ==============================================
-- LÓGICA ANTI LAG 🧹
-- ==============================================
local AntiLagActive = false
local ConnectionLag = nil

AntiLagButton.MouseButton1Click:Connect(function()
    AntiLagActive = not AntiLagActive
    if AntiLagActive then
        AntiLagButton.Text = "🧹 ANTI LAG - ON"
        AntiLagButton.BackgroundColor3 = Color3.new(0, 0.6, 1)
        
        -- Limpieza inicial
        for _, v in pairs(Workspace:GetChildren()) do
            if v:IsA("Part") or v:IsA("MeshPart") then
                if not v:IsAncestorOf(Character) and v.Name ~= "Baseplate" then
                    if v.Anchored == false then
                        v:Destroy()
                    end
                end
            end
        end
        
        -- Limpieza continua
        ConnectionLag = RunService.Heartbeat:Connect(function()
            settings().Rendering.QualityLevel = 1
            settings().Rendering.FramerateLimit = 60
        end)
        
    else
        AntiLagButton.Text = "🧹 ANTI LAG - OFF"
        AntiLagButton.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
        if ConnectionLag then
            ConnectionLag:Disconnect()
        end
    end
end)

print("✅ Script 100% COMPLETO con EVENTO! JoseAngel_Blox kick")
