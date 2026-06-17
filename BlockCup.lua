--[[
Script Name: JoseAngel_Blox Block Cup
Version: 12.0 - LAS BOLAS SE QUEDAN / NO DESAPARECEN
]]

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local FarmActive = false
local Loop = nil
local Dragging, DragStart, StartPos = nil, nil, nil
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

-- == GUI ==
local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ToggleBtn = Instance.new("TextButton")
local SpeedLabel = Instance.new("TextLabel")
local BtnMinus = Instance.new("TextButton")
local BtnPlus = Instance.new("TextButton")
local SpeedDisplay = Instance.new("TextLabel")

ScreenGui.Name = "UI"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
Main.BorderColor3 = Color3.new(1, 0, 0)
Main.BorderSizePixel = 2
Main.Position = UDim2.new(0.05, 0, 0.2, 0)
Main.Size = UDim2.new(0, 220, 0, 200)
Main.Active = true

-- TITULO
Title.Name = "Title"
Title.Parent = Main
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.05, 0, 0.03, 0)
Title.Size = UDim2.new(0.9, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "JoseAngel_Blox"
Title.TextColor3 = Color3.new(1,1,1)
Title.TextSize = 20

-- VELOCIDAD
SpeedLabel.Parent = Main
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Position = UDim2.new(0.05, 0, 0.20, 0)
SpeedLabel.Size = UDim2.new(0.9, 0, 0, 20)
SpeedLabel.Text = "⚡ Velocidad"
SpeedLabel.TextColor3 = Color3.new(1, 1, 1)
SpeedLabel.TextSize = 14

BtnMinus.Name = "Minus"
BtnMinus.Parent = Main
BtnMinus.Position = UDim2.new(0.05, 0, 0.32, 0)
BtnMinus.Size = UDim2.new(0.25, 0, 0, 30)
BtnMinus.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
BtnMinus.BorderColor3 = Color3.new(1,1,1)
BtnMinus.Text = "-"
BtnMinus.TextColor3 = Color3.new(1,1,1)
BtnMinus.Font = Enum.Font.GothamBold
BtnMinus.TextSize = 20

SpeedDisplay.Name = "SpeedDisplay"
SpeedDisplay.Parent = Main
SpeedDisplay.BackgroundTransparency = 1
SpeedDisplay.Position = UDim2.new(0.35, 0, 0.32, 0)
SpeedDisplay.Size = UDim2.new(0.3, 0, 0, 30)
SpeedDisplay.Text = tostring(SpeedValue)
SpeedDisplay.TextColor3 = Color3.new(1,1,1)
SpeedDisplay.Font = Enum.Font.GothamBold
SpeedDisplay.TextSize = 16

BtnPlus.Name = "Plus"
BtnPlus.Parent = Main
BtnPlus.Position = UDim2.new(0.70, 0, 0.32, 0)
BtnPlus.Size = UDim2.new(0.25, 0, 0, 30)
BtnPlus.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
BtnPlus.BorderColor3 = Color3.new(1,1,1)
BtnPlus.Text = "+"
BtnPlus.TextColor3 = Color3.new(1,1,1)
BtnPlus.Font = Enum.Font.GothamBold
BtnPlus.TextSize = 20

ToggleBtn.Name = "Toggle"
ToggleBtn.Parent = Main
ToggleBtn.BackgroundColor3 = Color3.new(0.2, 0, 0)
ToggleBtn.BorderColor3 = Color3.new(1, 1, 1)
ToggleBtn.Position = UDim2.new(0.05, 0, 0.55, 0)
ToggleBtn.Size = UDim2.new(0.9, 0, 0, 40)
ToggleBtn.Text = "ACTIVAR"
ToggleBtn.TextColor3 = Color3.new(1,1,1)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 16

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

-- == BOTONES +/- ==
BtnMinus.MouseButton1Click:Connect(function()
    SpeedValue = math.max(50, SpeedValue - 50)
    SpeedDisplay.Text = tostring(SpeedValue)
end)
BtnPlus.MouseButton1Click:Connect(function()
    SpeedValue = SpeedValue + 50
    SpeedDisplay.Text = tostring(SpeedValue)
end)

-- =============================================
-- ✅ TRUCO MAESTRO: LAS BOLAS SE QUEDAN
-- =============================================
spawn(function()
    while task.wait(0.15) do
        if FarmActive and RootPart then
            local MyPos = RootPart.Position
            for _, v in pairs(Workspace:GetDescendants()) do
                if v:IsA("BasePart") and v.Shape == Enum.PartType.Ball and v.Anchored == false and not v:IsDescendantOf(Character) then
                    local Name = string.lower(v.Name)
                    if string.find(Name,"ball")or string.find(Name,"orb")or string.find(Name,"rare")or string.find(Name,"epic")or string.find(Name,"legendary")or string.find(Name,"mutation")or string.find(Name,"double")or string.find(Name,"chance")then
                        
                        local Dist = (MyPos - v.Position).Magnitude
                        
                        if Dist < 80 then
                            -- 🧲 ATRACCIÓN SUAVE PERO SEGURA
                            v.CFrame = v.CFrame:Lerp(RootPart.CFrame, 0.4)
                            
                            -- ✅ EL SECRETO: HACER QUE "TOQUE" AL PERSONAJE
                            if Dist < 6 then
                                -- La ponemos justo en el cuerpo
                                v.CFrame = RootPart.CFrame
                                -- Desactivamos todo para que entre suave
                                v.CanCollide = false
                                v.Anchored = false
                                
                                -- 🔥 SIMULAMOS EL TOQUE PARA QUE EL JUEGO LA CUENTE
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

-- == AUTO FARM ==
local function StartFarm()
    if Loop then return end
    FarmActive = true
    ToggleBtn.Text = "DESACTIVAR"
    ToggleBtn.BackgroundColor3 = Color3.new(0, 0.4, 0)
    
    Loop = spawn(function()
        while FarmActive do
            if not Humanoid then UpdateCharacter() end
            VirtualUser:Click()
            task.wait(2.0)
            if Humanoid then
                Humanoid.WalkSpeed = SpeedValue
                Humanoid:MoveTo(Vector3.new(-45, 0, 0))
            end
            task.wait(3.0)
        end
    end)
end

local function StopFarm()
    FarmActive = false
    Loop = nil
    if Humanoid then Humanoid.WalkSpeed = 16 end
    ToggleBtn.Text = "ACTIVAR"
    ToggleBtn.BackgroundColor3 = Color3.new(0.2, 0, 0)
end

ToggleBtn.MouseButton1Click:Connect(function()
    if not FarmActive then StartFarm() else StopFarm() end
end)
