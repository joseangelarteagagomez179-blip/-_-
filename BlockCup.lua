--[[
Script Name: JoseAngel_Blox Block Cup
Version: OPTIMIZADO - SIN LAG / VELOCIDAD FUNCIONANDO
]]

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer
local FarmActive = false
local SpeedActive = false
local Loop = nil
local Dragging, DragStart, StartPos = nil, nil, nil
local Character, Humanoid, RootPart
local SpeedValue = 500

-- == ACTUALIZAR PERSONAJE ==
local function UpdateCharacter()
    Character = Player.Character or Player.CharacterAdded:Wait()
    Humanoid = Character:FindFirstChildOfClass("Humanoid")
    RootPart = Character.PrimaryPart
end
Player.CharacterAdded:Connect(UpdateCharacter)
UpdateCharacter()

-- == GUI ==
local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Title = Instance.new("TextLabel")

-- 1. SECCION VELOCIDAD
local SpeedLabel = Instance.new("TextLabel")
local BtnMinus = Instance.new("TextButton")
local SpeedDisplay = Instance.new("TextLabel")
local BtnPlus = Instance.new("TextButton")
local ToggleSpeedBtn = Instance.new("TextButton")

-- 2. SECCION FARM
local FarmLabel = Instance.new("TextLabel")
local ToggleFarmBtn = Instance.new("TextButton")

ScreenGui.Name = "UI"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
Main.BorderColor3 = Color3.new(1, 0, 0)
Main.BorderSizePixel = 2
Main.Position = UDim2.new(0.05, 0, 0.2, 0)
Main.Size = UDim2.new(0, 240, 0, 280)
Main.Active = true

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

-- ==================================
--      OPCIÓN 1: VELOCIDAD
-- ==================================
SpeedLabel.Parent = Main
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Position = UDim2.new(0.05, 0, 0.15, 0)
SpeedLabel.Size = UDim2.new(0.9, 0, 0, 20)
SpeedLabel.Text = "⚡ Velocidad"
SpeedLabel.TextColor3 = Color3.new(1, 1, 1)
SpeedLabel.TextSize = 14

BtnMinus.Name = "Minus"
BtnMinus.Parent = Main
BtnMinus.Position = UDim2.new(0.05, 0, 0.25, 0)
BtnMinus.Size = UDim2.new(0.20, 0, 0, 30)
BtnMinus.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
BtnMinus.BorderColor3 = Color3.new(1,1,1)
BtnMinus.Text = "-"
BtnMinus.TextColor3 = Color3.new(1,1,1)
BtnMinus.Font = Enum.Font.GothamBold
BtnMinus.TextSize = 20

SpeedDisplay.Name = "SpeedDisplay"
SpeedDisplay.Parent = Main
SpeedDisplay.BackgroundTransparency = 1
SpeedDisplay.Position = UDim2.new(0.30, 0, 0.25, 0)
SpeedDisplay.Size = UDim2.new(0.40, 0, 0, 30)
SpeedDisplay.Text = tostring(SpeedValue)
SpeedDisplay.TextColor3 = Color3.new(1,1,1)
SpeedDisplay.Font = Enum.Font.GothamBold
SpeedDisplay.TextSize = 16

BtnPlus.Name = "Plus"
BtnPlus.Parent = Main
BtnPlus.Position = UDim2.new(0.75, 0, 0.25, 0)
BtnPlus.Size = UDim2.new(0.20, 0, 0, 30)
BtnPlus.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
BtnPlus.BorderColor3 = Color3.new(1,1,1)
BtnPlus.Text = "+"
BtnPlus.TextColor3 = Color3.new(1,1,1)
BtnPlus.Font = Enum.Font.GothamBold
BtnPlus.TextSize = 20

ToggleSpeedBtn.Name = "ToggleSpeed"
ToggleSpeedBtn.Parent = Main
ToggleSpeedBtn.BackgroundColor3 = Color3.new(0.2, 0, 0)
ToggleSpeedBtn.BorderColor3 = Color3.new(1, 1, 1)
ToggleSpeedBtn.Position = UDim2.new(0.05, 0, 0.38, 0)
ToggleSpeedBtn.Size = UDim2.new(0.9, 0, 0, 35)
ToggleSpeedBtn.Text = "ACTIVAR VELOCIDAD"
ToggleSpeedBtn.TextColor3 = Color3.new(1,1,1)
ToggleSpeedBtn.Font = Enum.Font.GothamBold
ToggleSpeedBtn.TextSize = 14

-- ==================================
--      OPCIÓN 2: AUTO FARM
-- ==================================
FarmLabel.Parent = Main
FarmLabel.BackgroundTransparency = 1
FarmLabel.Position = UDim2.new(0.05, 0, 0.55, 0)
FarmLabel.Size = UDim2.new(0.9, 0, 0, 20)
FarmLabel.Text = "Auto farm pelotas"
FarmLabel.TextColor3 = Color3.new(1, 1, 1)
FarmLabel.TextSize = 14

ToggleFarmBtn.Name = "ToggleFarm"
ToggleFarmBtn.Parent = Main
ToggleFarmBtn.BackgroundColor3 = Color3.new(0.2, 0, 0)
ToggleFarmBtn.BorderColor3 = Color3.new(1, 1, 1)
ToggleFarmBtn.Position = UDim2.new(0.05, 0, 0.65, 0)
ToggleFarmBtn.Size = UDim2.new(0.9, 0, 0, 40)
ToggleFarmBtn.Text = "ACTIVAR AUTO FARMELO DE PELOTAS"
ToggleFarmBtn.TextColor3 = Color3.new(1,1,1)
ToggleFarmBtn.Font = Enum.Font.GothamBold
ToggleFarmBtn.TextSize = 13

-- == DESLIZAR ==
Main.InputBegan:Connect(function(I)
    if I.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = true
        DragStart = I.Position
        StartPos = Main.Position
    end
end)
UserInputService.InputChanged:Connect(function(I)
    if Dragging then
        local Delta = I.Position - DragStart
        Main.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(I)
    if I.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = false
    end
end)

-- ==================================
-- ✅ VELOCIDAD ULTRA LIGERA
-- ==================================
-- Usamos RenderStepped pero muy optimizado
local LastSpeedUpdate = 0
RunService.Heartbeat:Connect(function()
    if SpeedActive and Humanoid and tick() - LastSpeedUpdate > 0.1 then
        Humanoid.WalkSpeed = SpeedValue
        LastSpeedUpdate = tick()
    end
end)

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

ToggleSpeedBtn.MouseButton1Click:Connect(function()
    SpeedActive = not SpeedActive
    if SpeedActive then
        ToggleSpeedBtn.Text = "DESACTIVAR VELOCIDAD"
        ToggleSpeedBtn.BackgroundColor3 = Color3.new(0, 0.4, 0)
        if Humanoid then Humanoid.WalkSpeed = SpeedValue end
    else
        ToggleSpeedBtn.Text = "ACTIVAR VELOCIDAD"
        ToggleSpeedBtn.BackgroundColor3 = Color3.new(0.2, 0, 0)
        if Humanoid then Humanoid.WalkSpeed = 16 end
    end
end)

-- =============================================
-- 🧲 IMÁN OPTIMIZADO
-- =============================================
spawn(function()
    while task.wait(0.15) do -- Un poco mas lento = MAS RENDIMIENTO
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

-- == FUNCION AUTO FARM ==
local function StartFarm()
    if Loop then return end
    FarmActive = true
    ToggleFarmBtn.Text = "DESACTIVAR AUTO FARMELO"
    ToggleFarmBtn.BackgroundColor3 = Color3.new(0, 0.4, 0)
    
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
    ToggleFarmBtn.Text = "ACTIVAR AUTO FARMELO DE PELOTAS"
    ToggleFarmBtn.BackgroundColor3 = Color3.new(0.2, 0, 0)
end

ToggleFarmBtn.MouseButton1Click:Connect(function()
    if not FarmActive then StartFarm() else StopFarm() end
end)
