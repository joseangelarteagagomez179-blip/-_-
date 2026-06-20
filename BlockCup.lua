--[[
Script Name: JoseAngel_Blox Block Cup
Version: FINAL OPTIMIZADA | 0 LAG | ATRAE TODO
]]

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer
local FarmActive = false
local Loop = nil
local MagnetLoop = nil
local Dragging, DragStart, StartPos = nil, nil, nil
local Character, Humanoid, RootPart

-- == ACTUALIZAR PERSONAJE ==
local function UpdateCharacter()
    Character = Player.Character or Player.CharacterAdded:Wait()
    Humanoid = Character:WaitForChild("Humanoid")
    RootPart = Character:WaitForChild("HumanoidRootPart")
    
    Humanoid.WalkSpeed = 1000
    Humanoid.MaxHealth = math.huge
    Humanoid.Health = math.huge
end
Player.CharacterAdded:Connect(UpdateCharacter)
UpdateCharacter()

-- == MANTENER VIDA INFINITA ==
spawn(function()
    while task.wait(4) do
        if Humanoid then
            Humanoid.Health = math.huge
            Humanoid.MaxHealth = math.huge
        end
    end
end)

-- == GUI ==
local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")
local FarmLabel = Instance.new("TextLabel")
local ToggleFarmBtn = Instance.new("TextButton")
local BtnCorner = Instance.new("UICorner")

ScreenGui.Name = "UI"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.05, 0, 0.2, 0)
Main.Size = UDim2.new(0, 180, 0, 140)
Main.Active = true

UICorner.CornerRadius = UDim.new(0, 14)
UICorner.Parent = Main

UIStroke.Name = "Border"
UIStroke.Parent = Main
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(80, 200, 255)
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

Title.Name = "Title"
Title.Parent = Main
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.05, 0, 0.08, 0)
Title.Size = UDim2.new(0.9, 0, 0, 25)
Title.Font = Enum.Font.GothamBold
Title.Text = "JoseAngel_Blox"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 16

FarmLabel.Parent = Main
FarmLabel.BackgroundTransparency = 1
FarmLabel.Position = UDim2.new(0.05, 0, 0.32, 0)
FarmLabel.Size = UDim2.new(0.9, 0, 0, 18)
FarmLabel.Text = "Auto farm pelotas"
FarmLabel.TextColor3 = Color3.new(0.9, 0.9, 0.9)
FarmLabel.TextSize = 12

ToggleFarmBtn.Name = "ToggleFarm"
ToggleFarmBtn.Parent = Main
ToggleFarmBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
ToggleFarmBtn.BorderColor3 = Color3.fromRGB(80, 200, 255)
ToggleFarmBtn.Position = UDim2.new(0.08, 0, 0.52, 0)
ToggleFarmBtn.Size = UDim2.new(0.84, 0, 0, 40)
ToggleFarmBtn.Text = "ACTIVAR"
ToggleFarmBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleFarmBtn.Font = Enum.Font.GothamBold
ToggleFarmBtn.TextSize = 13

BtnCorner.CornerRadius = UDim.new(0, 10)
BtnCorner.Parent = ToggleFarmBtn

-- ==================================
-- 📱 MOVER / ARRASTRAR
-- ==================================
Main.InputBegan:Connect(function(I)
    if I.UserInputType == Enum.UserInputType.MouseButton1 or I.UserInputType == Enum.UserInputType.Touch then
        Dragging = true
        DragStart = I.Position
        StartPos = Main.Position
    end
end)

UserInputService.InputChanged:Connect(function(I)
    if Dragging then
        local Delta = I.Position - DragStart
        Main.Position = UDim2.new(
            StartPos.X.Scale, 
            StartPos.X.Offset + Delta.X, 
            StartPos.Y.Scale, 
            StartPos.Y.Offset + Delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(I)
    if I.UserInputType == Enum.UserInputType.MouseButton1 or I.UserInputType == Enum.UserInputType.Touch then
        Dragging = false
    end
end)

-- =============================================
-- 🧲 IMÁN: MODO BUSQUEDA COMPLETA PERO LIGERA
-- =============================================
local BallsFolder = nil

local function Magnet()
    if not FarmActive or not RootPart then return end
    local MyPos = RootPart.Position

    -- Buscar carpeta solo una vez
    if not BallsFolder then
        BallsFolder = Workspace:FindFirstChild("Balls") or Workspace
    end

    -- ✅ SOLUCION: Usamos GetDescendants() pero con bucle controlado
    for _, v in pairs(BallsFolder:GetDescendants()) do
        if v:IsA("BasePart") and not v:IsDescendantOf(Character) then
            
            -- Ignorar paredes y suelo
            if v.Size.X > 15 or v.Size.Y > 15 or v.Size.Z > 15 then
                continue
            end
            
            local Name = string.lower(v.Name)
            
            if string.find(Name,"ball")
            or string.find(Name,"legendary")
            or string.find(Name,"mutat")
            or string.find(Name,"doub")
            or string.find(Name,"rare")
            or string.find(Name,"epic")
            then
                
                local Dist = (MyPos - v.Position).Magnitude
                
                -- ✅ Rango aumentado para que atraiga bien
                if Dist < 60 then
                    v.Anchored = false
                    v.CanCollide = false -- Importante para que se muevan
                    v.CFrame = v.CFrame:Lerp(RootPart.CFrame, 0.7)
                    
                    if Dist < 4 then
                        firetouchinterest(Character, v, 0)
                        firetouchinterest(Character, v, 1)
                        
                        if Dist < 2 then
                            v.CFrame = RootPart.CFrame + Vector3.new(0, 1, 0.5)
                        end
                    end
                end
            end
        end
    end
end

-- == FUNCION BOTON ACTIVAR/DESACTIVAR ==
local function StartFarm()
    if MagnetLoop then return end
    FarmActive = true
    ToggleFarmBtn.Text = "DESACTIVAR"
    ToggleFarmBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 50)
    
    -- ⚡ Velocidad equilibrada: Ni muy rapido ni muy lento
    MagnetLoop = spawn(function()
        while FarmActive do
            Magnet()
            task.wait(0.15) -- Si te da lag de nuevo, cambia a 0.25
        end
    end)
    
    Loop = spawn(function()
        while FarmActive do
            if not Humanoid then UpdateCharacter() end
            VirtualUser:Click()
            task.wait(2.5)
            if Humanoid then
                Humanoid:MoveTo(Vector3.new(-45, 0, 0))
            end
            task.wait(3.5)
        end
    end)
end

local function StopFarm()
    FarmActive = false
    Loop = nil
    MagnetLoop = nil
    ToggleFarmBtn.Text = "ACTIVAR"
    ToggleFarmBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
end

ToggleFarmBtn.MouseButton1Click:Connect(function()
    if not FarmActive then StartFarm() else StopFarm() end
end)
