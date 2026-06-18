--[[
Script Name: JoseAngel_Blox Block Cup
Version: BOTON SIEMPRE VISIBLE / ULTRA OPTIMIZADO
]]

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer
local FarmActive = false
local Loop = nil
local Dragging, DragStart, StartPos = nil, nil, nil
local MenuVisible = true
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
local BtnMinimize = Instance.new("TextButton") -- BOTON QUE SIEMPRE SE VE
local FarmLabel = Instance.new("TextLabel")
local ToggleFarmBtn = Instance.new("TextButton")

ScreenGui.Name = "UI"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- MARCO PRINCIPAL
Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
Main.BorderColor3 = Color3.new(1, 0, 0)
Main.BorderSizePixel = 2
Main.Position = UDim2.new(0.05, 0, 0.2, 0)
Main.Size = UDim2.new(0, 240, 0, 180)
Main.Active = true

-- TITULO
Title.Name = "Title"
Title.Parent = Main
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.05, 0, 0.05, 0)
Title.Size = UDim2.new(0.7, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "JoseAngel_Blox"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 20

-- ==================================
--      BOTON [-] (SIEMPRE VISIBLE)
-- ==================================
BtnMinimize.Name = "Minimize"
BtnMinimize.Parent = ScreenGui -- 🔴 IMPORTANTE: VA DIRECTO EN LA PANTALLA
BtnMinimize.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
BtnMinimize.BorderColor3 = Color3.new(1, 1, 1)
BtnMinimize.Position = UDim2.new(0.05, 0, 0.2, 0) -- MISMA POSICION QUE EL MENU
BtnMinimize.Size = UDim2.new(0, 30, 0, 30)
BtnMinimize.Font = Enum.Font.GothamBold
BtnMinimize.Text = "-"
BtnMinimize.TextColor3 = Color3.new(1, 1, 1)
BtnMinimize.TextSize = 20
BtnMinimize.ZIndexBehavior = Enum.ZIndexBehavior.Global -- SIEMPRE ENCIMA

-- ==================================
--      OPCIÓN: AUTO FARM
-- ==================================
FarmLabel.Parent = Main
FarmLabel.BackgroundTransparency = 1
FarmLabel.Position = UDim2.new(0.05, 0, 0.35, 0)
FarmLabel.Size = UDim2.new(0.9, 0, 0, 20)
FarmLabel.Text = "Auto farm pelotas"
FarmLabel.TextColor3 = Color3.new(1, 1, 1)
FarmLabel.TextSize = 14

ToggleFarmBtn.Name = "ToggleFarm"
ToggleFarmBtn.Parent = Main
ToggleFarmBtn.BackgroundColor3 = Color3.new(0.2, 0, 0)
ToggleFarmBtn.BorderColor3 = Color3.new(1, 1, 1)
ToggleFarmBtn.Position = UDim2.new(0.05, 0, 0.55, 0)
ToggleFarmBtn.Size = UDim2.new(0.9, 0, 0, 45)
ToggleFarmBtn.Text = "ACTIVAR AUTO FARMELO DE PELOTAS"
ToggleFarmBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleFarmBtn.Font = Enum.Font.GothamBold
ToggleFarmBtn.TextSize = 13

-- ==================================
--      FUNCIONES: MOVER Y MINIMIZAR
-- ==================================

-- MOVER MENU
Main.InputBegan:Connect(function(I)
    if I.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = true
        DragStart = I.Position
        StartPos = Main.Position
    end
end)

-- MOVER BOTON TAMBIEN
BtnMinimize.InputBegan:Connect(function(I)
    if I.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = true
        DragStart = I.Position
        StartPos = Main.Position
    end
end)

UserInputService.InputChanged:Connect(function(I)
    if Dragging then
        local Delta = I.Position - DragStart
        local NewPos = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)
        Main.Position = NewPos
        BtnMinimize.Position = NewPos -- EL BOTON SE MUEVE CON EL MENU
    end
end)

UserInputService.InputEnded:Connect(function(I)
    if I.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = false
    end
end)

-- FUNCION ESCONDER / MOSTRAR
BtnMinimize.MouseButton1Click:Connect(function()
    MenuVisible = not MenuVisible
    Main.Visible = MenuVisible
    -- EL BOTON NUNCA SE ESCONDE, ASI SIEMPRE PUEDES DARLE CLICK
end)

-- =============================================
-- 🚀 IMÁN: ULTRA OPTIMIZADO - 0 LAG
-- =============================================
spawn(function()
    while task.wait(0.3) do -- ✅ MAS LENTO = MAS FPS
        if FarmActive and RootPart then
            local MyPos = RootPart.Position
            
            -- ✅ BUCLE OPTIMIZADO
            for _, v in pairs(Workspace:GetDescendants()) do
                -- ✅ PRIMERO REVISAMOS TAMAÑO PARA AHORRAR TIEMPO
                if v:IsA("BasePart") and not v:IsDescendantOf(Character) then
                    
                    -- 🛡️ PROTECCIÓN SUELO
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
                        
                        -- ✅ RANGO CORTO Y SUAVE
                        if Dist < 50 then
                            v.CFrame = v.CFrame:Lerp(RootPart.CFrame, 0.2)
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
