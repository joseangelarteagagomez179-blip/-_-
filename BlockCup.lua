--[[
Script Name: JoseAngel_Blox Block Cup
Version: MODO INFINITO - NO BORRA NADA / SEGURO
]]

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = UserInputService
local Workspace = Workspace

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
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")
local FarmLabel = Instance.new("TextLabel")
local ToggleFarmBtn = Instance.new("TextButton")
local BtnCorner = Instance.new("UICorner")

ScreenGui.Name = "UI"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- MARCO PRINCIPAL
Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.05, 0, 0.2, 0)
Main.Size = UDim2.new(0, 180, 0, 140)
Main.Active = true

-- ESQUINAS REDONDEADAS
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Main

-- BORDE CON COLORES (EFECTO RGB)
UIStroke.Name = "Border"
UIStroke.Parent = Main
UIStroke.Thickness = 2
UIStroke.Color = Color3.new(1, 0, 0)
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- TITULO
Title.Name = "Title"
Title.Parent = Main
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0.05, 0, 0.08, 0)
Title.Size = UDim2.new(0.9, 0, 0, 25)
Title.Font = Enum.Font.GothamBold
Title.Text = "JoseAngel_Blox"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 16

-- TEXTO AUTO FARM
FarmLabel.Parent = Main
FarmLabel.BackgroundTransparency = 1
FarmLabel.Position = UDim2.new(0.05, 0, 0.32, 0)
FarmLabel.Size = UDim2.new(0.9, 0, 0, 18)
FarmLabel.Text = "Auto farm pelotas"
FarmLabel.TextColor3 = Color3.new(1, 1, 1)
FarmLabel.TextSize = 12

-- BOTON PRINCIPAL
ToggleFarmBtn.Name = "ToggleFarm"
ToggleFarmBtn.Parent = Main
ToggleFarmBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleFarmBtn.BorderColor3 = Color3.new(1, 1, 1)
ToggleFarmBtn.Position = UDim2.new(0.08, 0, 0.52, 0)
ToggleFarmBtn.Size = UDim2.new(0.84, 0, 0, 40)
ToggleFarmBtn.Text = "ACTIVAR"
ToggleFarmBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleFarmBtn.Font = Enum.Font.GothamBold
ToggleFarmBtn.TextSize = 13

-- ESQUINAS REDONDEADAS AL BOTON
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = ToggleFarmBtn

-- ==================================
-- ✨ EFECTO COLORES RGB
-- ==================================
spawn(function()
    local H = 0
    while task.wait(0.05) do
        H = H + 0.01
        if H > 1 then H = 0 end
        UIStroke.Color = Color3.fromHSV(H, 0.8, 1)
    end
end)

-- ==================================
-- 📱 FUNCION MOVER / ARRASTRAR
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
-- 🧲 IMÁN: MODO INFINITO - EL TRUCO
-- =============================================
spawn(function()
    while task.wait(0.1) do
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
                        
                        -- ✅ MAS ALCANCE
                        if Dist < 80 then
                            -- ✅ VELOCIDAD MAXIMA
                            v.CFrame = v.CFrame:Lerp(RootPart.CFrame, 0.95)
                            v.CanCollide = false
                            v.Anchored = false
                            
                            -- ✅ EL SECRETO PARA QUE NO LAS BORRE:
                            -- Cuando están muy pegadas, las "soltamos" un poquito hacia atrás
                            -- Así cuentan el dinero pero el juego no las elimina
                            if Dist < 3 then
                                firetouchinterest(Character, v, 0)
                                firetouchinterest(Character, v, 1)
                                
                                -- Las movemos hacia atrás y arriba para que se queden visibles
                                v.CFrame = RootPart.CFrame * CFrame.new(0, 2, -3) 
                                -- El -3 es clave: las pone detrás de ti, así no se borran
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- == FUNCION BOTON ACTIVAR/DESACTIVAR ==
local function StartFarm()
    if Loop then return end
    FarmActive = true
    ToggleFarmBtn.Text = "DESACTIVAR"
    ToggleFarmBtn.BackgroundColor3 = Color3.fromRGB(0, 80, 0)
    
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
    ToggleFarmBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
end

ToggleFarmBtn.MouseButton1Click:Connect(function()
    if not FarmActive then StartFarm() else StopFarm() end
end)
