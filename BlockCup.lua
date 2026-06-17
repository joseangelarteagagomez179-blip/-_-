--[[
Script Name: JoseAngel_Blox Block Cup
Version: 16.0 - CON BURBUJA FLOTANTE
]]

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local FarmActive = false
local SpeedActive = false
local Loop = nil
local SpeedLoop = nil
local Character, Humanoid, RootPart
local SpeedValue = 500

-- == ACTUALIZAR PERSONAJE ==
local function UpdateCharacter()
    Character = Player.Character or Player.CharacterAdded:Wait()
    Humanoid = Character:WaitForChild("Humanoid")
    RootPart = Character:WaitForChild("HumanoidRootPart")
end
Player.CharacterAdded:Connect(UpdateCharacter)
UpdateCharacter()

-- =============================================
-- 💠 BURBUJA FLOTANTE
-- =============================================
local Bubble = Instance.new("TextButton")
Bubble.Name = "Bubble"
Bubble.Parent = game:GetService("CoreGui")
Bubble.BackgroundColor3 = Color3.new(1, 0, 0)
Bubble.Size = UDim2.new(0, 60, 0, 60)
Bubble.Position = UDim2.new(0.02, 0, 0.4, 0)
Bubble.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Bubble.Text = "JB"
Bubble.TextColor3 = Color3.new(1,1,1)
Bubble.Font = Enum.Font.GothamBold
Bubble.TextSize = 20
Bubble.Active = true

-- Efecto de sombra/borde
local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2
UIStroke.Color = Color3.new(1,1,1)
UIStroke.Parent = Bubble

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1,0)
UICorner.Parent = Bubble

-- =============================================
-- 📦 MENU PRINCIPAL
-- =============================================
local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Title = Instance.new("TextLabel")

ScreenGui.Name = "MainUI"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
Main.BorderColor3 = Color3.new(1, 0, 0)
Main.BorderSizePixel = 2
Main.Position = UDim2.new(0.05, 0, 0.2, 0)
Main.Size = UDim2.new(0, 220, 0, 280)
Main.Active = true
Main.Visible = false -- Empieza oculto

-- Esquinas redondeadas
local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0,8)
UICornerMain.Parent = Main

-- TITULO
Title.Name = "Title"
Title.Parent = Main
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.05, 0, 0.02, 0)
Title.Size = UDim2.new(0.9, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "JoseAngel_Blox"
Title.TextColor3 = Color3.new(1,1,1)
Title.TextSize = 20

-- =============================================
-- 1️⃣ OPCION VELOCIDAD
-- =============================================
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Parent = Main
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Position = UDim2.new(0.05, 0, 0.15, 0)
SpeedLabel.Size = UDim2.new(0.9, 0, 0, 20)
SpeedLabel.Text = "⚡ Velocidad Infinita"
SpeedLabel.TextColor3 = Color3.new(1, 1, 1)
SpeedLabel.TextSize = 14

local BtnMinus = Instance.new("TextButton")
BtnMinus.Name = "Minus"
BtnMinus.Parent = Main
BtnMinus.Position = UDim2.new(0.05, 0, 0.25, 0)
BtnMinus.Size = UDim2.new(0.25, 0, 0, 30)
BtnMinus.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
BtnMinus.BorderColor3 = Color3.new(1,1,1)
BtnMinus.Text = "-"
BtnMinus.TextColor3 = Color3.new(1,1,1)
BtnMinus.Font = Enum.Font.GothamBold
BtnMinus.TextSize = 20

local SpeedDisplay = Instance.new("TextLabel")
SpeedDisplay.Name = "SpeedDisplay"
SpeedDisplay.Parent = Main
SpeedDisplay.BackgroundTransparency = 1
SpeedDisplay.Position = UDim2.new(0.35, 0, 0.25, 0)
SpeedDisplay.Size = UDim2.new(0.3, 0, 0, 30)
SpeedDisplay.Text = tostring(SpeedValue)
SpeedDisplay.TextColor3 = Color3.new(1,1,1)
SpeedDisplay.Font = Enum.Font.GothamBold
SpeedDisplay.TextSize = 16

local BtnPlus = Instance.new("TextButton")
BtnPlus.Name = "Plus"
BtnPlus.Parent = Main
BtnPlus.Position = UDim2.new(0.70, 0, 0.25, 0)
BtnPlus.Size = UDim2.new(0.25, 0, 0, 30)
BtnPlus.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
BtnPlus.BorderColor3 = Color3.new(1,1,1)
BtnPlus.Text = "+"
BtnPlus.TextColor3 = Color3.new(1,1,1)
BtnPlus.Font = Enum.Font.GothamBold
BtnPlus.TextSize = 20

local BtnSpeed = Instance.new("TextButton")
BtnSpeed.Name = "BtnSpeed"
BtnSpeed.Parent = Main
BtnSpeed.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
BtnSpeed.BorderColor3 = Color3.new(1, 1, 1)
BtnSpeed.Position = UDim2.new(0.05, 0, 0.40, 0)
BtnSpeed.Size = UDim2.new(0.9, 0, 0, 35)
BtnSpeed.Text = "Activar Velocidad"
BtnSpeed.TextColor3 = Color3.new(1,1,1)
BtnSpeed.Font = Enum.Font.GothamBold
BtnSpeed.TextSize = 14

-- =============================================
-- 2️⃣ OPCION AUTO FARM
-- =============================================
local FarmLabel = Instance.new("TextLabel")
FarmLabel.Parent = Main
FarmLabel.BackgroundTransparency = 1
FarmLabel.Position = UDim2.new(0.05, 0, 0.55, 0)
FarmLabel.Size = UDim2.new(0.9, 0, 0, 20)
FarmLabel.Text = "🔵 Auto Farm Pelotas"
FarmLabel.TextColor3 = Color3.new(1, 1, 1)
FarmLabel.TextSize = 14

local BtnFarm = Instance.new("TextButton")
BtnFarm.Name = "BtnFarm"
BtnFarm.Parent = Main
BtnFarm.BackgroundColor3 = Color3.new(0.2, 0, 0)
BtnFarm.BorderColor3 = Color3.new(1, 1, 1)
BtnFarm.Position = UDim2.new(0.05, 0, 0.65, 0)
BtnFarm.Size = UDim2.new(0.9, 0, 0, 40)
BtnFarm.Text = "Activar Auto Farmeo"
BtnFarm.TextColor3 = Color3.new(1,1,1)
BtnFarm.Font = Enum.Font.GothamBold
BtnFarm.TextSize = 16

-- =============================================
-- ✨ FUNCIONES DRAG (MOVER)
-- =============================================
-- Drag Burbuja
local DBubble, DragStartB, StartPosB = false, nil, nil
Bubble.InputBegan:Connect(function(I)
    if I.UserInputType == Enum.UserInputType.MouseButton1 then
        DBubble = true
        DragStartB = I.Position
        StartPosB = Bubble.Position
    end
end)
UserInputService.InputChanged:Connect(function(I)
    if DBubble then
        local Delta = I.Position - DragStartB
        Bubble.Position = UDim2.new(StartPosB.X.Scale, StartPosB.X.Offset + Delta.X, StartPosB.Y.Scale, StartPosB.Y.Offset + Delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(I)
    if I.UserInputType == Enum.UserInputType.MouseButton1 then
        DBubble = false
    end
end)

-- Drag Menu
local DMenu, DragStartM, StartPosM = false, nil, nil
Main.InputBegan:Connect(function(I)
    if I.UserInputType == Enum.UserInputType.MouseButton1 then
        DMenu = true
        DragStartM = I.Position
        StartPosM = Main.Position
    end
end)
UserInputService.InputChanged:Connect(function(I)
    if DMenu then
        local Delta = I.Position - DragStartM
        Main.Position = UDim2.new(StartPosM.X.Scale, StartPosM.X.Offset + Delta.X, StartPosM.Y.Scale, StartPosM.Y.Offset + Delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(I)
    if I.UserInputType == Enum.UserInputType.MouseButton1 then
        DMenu = false
    end
end)

-- =============================================
-- 🔘 BOTON BURBUJA (MOSTRAR/OCULTAR)
-- =============================================
Bubble.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
end)

-- =============================================
-- ⚡ FUNCIONES VELOCIDAD
-- =============================================
BtnMinus.MouseButton1Click:Connect(function()
    SpeedValue = math.max(50, SpeedValue - 50)
    SpeedDisplay.Text = tostring(SpeedValue)
    if SpeedActive and Humanoid then Humanoid.WalkSpeed = SpeedValue end
end)
BtnPlus.MouseButton1Click:Connect(function()
    SpeedValue = SpeedValue + 50
    SpeedDisplay.Text = tostring(SpeedValue)
    if SpeedActive and Humanoid then Humanoid.WalkSpeed = SpeedValue end
end)

BtnSpeed.MouseButton1Click:Connect(function()
    SpeedActive = not SpeedActive
    if SpeedActive then
        BtnSpeed.Text = "Desactivar Velocidad"
        BtnSpeed.BackgroundColor3 = Color3.new(0, 0.4, 0)
        if Humanoid then Humanoid.WalkSpeed = SpeedValue end
    else
        BtnSpeed.Text = "Activar Velocidad"
        BtnSpeed.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        if Humanoid then Humanoid.WalkSpeed = 16 end
    end
end)

-- =============================================
-- 🧲 FUNCIONES AUTO FARM
-- =============================================
spawn(function()
    while task.wait(0.1) do
        if FarmActive and RootPart then
            local MyPos = RootPart.Position
            for _, v in pairs(Workspace:GetDescendants()) do
                if v:IsA("BasePart") and not v:IsDescendantOf(Character) and v.Size.X < 50 then
                    local Name = string.lower(v.Name)
                    if string.find(Name,"ball")or string.find(Name,"orb")or string.find(Name,"rare")or string.find(Name,"epic")or string.find(Name,"legendary")or string.find(Name,"mutation")or string.find(Name,"double")or string.find(Name,"chance")then
                        local Dist = (MyPos - v.Position).Magnitude
                        if Dist < 100 then
                            v.CFrame = v.CFrame:Lerp(RootPart.CFrame, 0.8)
                            if Dist < 6 then
                                v.CFrame = RootPart.CFrame
                                v.CanCollide = false
                                firetouchinterest(Character, v, 0)
                                firetouchinterest(Character, v, 1)
                            end
                        end
                    end
                end
            end
        end
    end
end)

local function StartFarm()
    if Loop then return end
    Loop = spawn(function()
        while FarmActive do
            if not Humanoid then UpdateCharacter() end
            VirtualUser:Click()
            task.wait(2.0)
            if Humanoid then
                Humanoid:MoveTo(Vector3.new(-45, 0, 0))
            end
            task.wait(3.0)
        end
    end)
end

local function StopFarm()
    FarmActive = false
    Loop = nil
end

BtnFarm.MouseButton1Click:Connect(function()
    FarmActive = not FarmActive
    if FarmActive then
        BtnFarm.Text = "Desactivar Auto Farmeo"
        BtnFarm.BackgroundColor3 = Color3.new(0, 0.4, 0)
        StartFarm()
    else
        BtnFarm.Text = "Activar Auto Farmeo"
        BtnFarm.BackgroundColor3 = Color3.new(0.2, 0, 0)
        StopFarm()
    end
end)
