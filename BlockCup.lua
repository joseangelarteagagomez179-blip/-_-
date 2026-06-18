--[[
Script Name: JoseAngel_Blox Block Cup
Version: DISEÑO NUEVO / PEQUEÑO / BONITO / MOVIBLE
]]

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer
local FarmActive = false
local Loop = nil
local Dragging, DragStart, StartPos = nil, nil, nil
local Character, Humanoid, RootPart

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
local UICorner = Instance.new("UICorner") -- <-- ESQUINAS REDONDEADAS
local FarmLabel = Instance.new("TextLabel")
local ToggleFarmBtn = Instance.new("TextButton")
local BtnCorner = Instance.new("UICorner") -- <-- ESQUINAS DEL BOTON

ScreenGui.Name = "UI"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- MARCO PRINCIPAL (MÁS PEQUEÑO Y BONITO)
Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1) -- Color oscuro elegante
Main.BorderColor3 = Color3.new(1, 0, 0)
Main.BorderSizePixel = 1
Main.Position = UDim2.new(0.05, 0, 0.2, 0)
Main.Size = UDim2.new(0, 180, 0, 140) -- <-- TAMAÑO MÁS PEQUEÑO
Main.Active = true

-- ESQUINAS REDONDEADAS
UICorner.CornerRadius = UDim.new(0, 10) -- <-- LO MAS REDONDEADO POSIBLE
UICorner.Parent = Main

-- TITULO
Title.Name = "Title"
Title.Parent = Main
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.05, 0, 0.08, 0)
Title.Size = UDim2.new(0.9, 0, 0, 25)
Title.Font = Enum.Font.GothamBold
Title.Text = "JoseAngel_Blox"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 17

-- TEXTO AUTO FARM
FarmLabel.Parent = Main
FarmLabel.BackgroundTransparency = 1
FarmLabel.Position = UDim2.new(0.05, 0, 0.32, 0)
FarmLabel.Size = UDim2.new(0.9, 0, 0, 18)
FarmLabel.Text = "Auto farm pelotas"
FarmLabel.TextColor3 = Color3.new(0.9, 0.9, 0.9)
FarmLabel.TextSize = 12

-- BOTON PRINCIPAL
ToggleFarmBtn.Name = "ToggleFarm"
ToggleFarmBtn.Parent = Main
ToggleFarmBtn.BackgroundColor3 = Color3.new(0.2, 0, 0)
ToggleFarmBtn.BorderColor3 = Color3.new(1, 0.3, 0.3)
ToggleFarmBtn.Position = UDim2.new(0.08, 0, 0.52, 0)
ToggleFarmBtn.Size = UDim2.new(0.84, 0, 0, 40)
ToggleFarmBtn.Text = "ACTIVAR AUTO FARMELO"
ToggleFarmBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleFarmBtn.Font = Enum.Font.GothamBold
ToggleFarmBtn.TextSize = 12

-- ESQUINAS REDONDEADAS AL BOTON TAMBIEN
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = ToggleFarmBtn

-- ==================================
--      FUNCION MOVER (DESLIZAR)
-- ==================================
-- FUNCIONA PERFECTO EN CELULAR: MANTIENES Y ARRASTRAS
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
        local NewPos = UDim2.new(
            StartPos.X.Scale, 
            StartPos.X.Offset + Delta.X, 
            StartPos.Y.Scale, 
            StartPos.Y.Offset + Delta.Y
        )
        Main.Position = NewPos
    end
end)

UserInputService.InputEnded:Connect(function(I)
    if I.UserInputType == Enum.UserInputType.MouseButton1 or I.UserInputType == Enum.UserInputType.Touch then
        Dragging = false
    end
end)

-- =============================================
-- 🧲 IMÁN: RANGO CORTO / VELOCIDAD BUENA
-- =============================================
spawn(function()
    while task.wait(0.3) do -- ✅ OPTIMIZADO SIN LAG
        if FarmActive and RootPart then
            local MyPos = RootPart.Position
            
            for _, v in pairs(Workspace:GetDescendants()) do
                if v:IsA("BasePart") and not v:IsDescendantOf(Character) then
                    
                    -- 🛡️ SUELO QUIETO
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
                        
                        -- ✅ RANGO CORTO Y VELOCIDAD JUSTA
                        if Dist < 50 then
                            v.CFrame = v.CFrame:Lerp(RootPart.CFrame, 0.4) -- Rápido pero bien
                            v.CanCollide = false
                            v.Anchored = false
                            
                            if Dist < 6 then
                                v.CFrame = RootPart.CFrame + Vector3.new(0, 1, 0)
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
    ToggleFarmBtn.Text = "DESACTIVAR"
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
    ToggleFarmBtn.Text = "ACTIVAR"
    ToggleFarmBtn.BackgroundColor3 = Color3.new(0.2, 0, 0)
end

ToggleFarmBtn.MouseButton1Click:Connect(function()
    if not FarmActive then StartFarm() else StopFarm() end
end)
