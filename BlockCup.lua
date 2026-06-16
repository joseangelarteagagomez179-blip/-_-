--[[
Script Name: JoseAngel_Blox Block Cup
Description: Auto Farm Evento Block Cup
Author: JoseAngel_Blox
Version: 2.3 - OPTIMIZADO
]]

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- == VARIABLES ==
local FarmActive = false
local Loop = nil
local Dragging = nil
local DragStart = nil
local StartPos = nil

-- == GUI ==
local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Sub = Instance.new("TextLabel")
local ToggleBtn = Instance.new("TextButton")

ScreenGui.Name = "JoseAngel_Blox"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
Main.BorderColor3 = Color3.new(1, 0, 0)
Main.BorderSizePixel = 2
Main.Position = UDim2.new(0.05, 0, 0.2, 0)
Main.Size = UDim2.new(0, 300, 0, 160)
Main.Active = true

-- Fondo Animado Rojo y Negro
local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.new(0.8, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.new(0.1, 0.1, 0.1)),
    ColorSequenceKeypoint.new(1, Color3.new(0.8, 0, 0))
}
Gradient.Rotation = 45
Gradient.Parent = Main

spawn(function()
    while task.wait(0.05) do
        Gradient.Rotation += 3
    end
end)

-- Texto
Title.Name = "Title"
Title.Parent = Main
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 10, 0, 10)
Title.Size = UDim2.new(0, 280, 0, 40)
Title.Font = Enum.Font.GothamBlack
Title.Text = "JoseAngel_Blox"
Title.TextColor3 = Color3.new(1,1,1)
Title.TextSize = 26
Title.TextStrokeTransparency = 0
Title.TextStrokeColor3 = Color3.new(1,0,0)

Sub.Name = "Sub"
Sub.Parent = Main
Sub.BackgroundTransparency = 1
Sub.Position = UDim2.new(0, 10, 0, 50)
Sub.Size = UDim2.new(0, 280, 0, 30)
Sub.Font = Enum.Font.GothamBold
Sub.Text = "⚽ BLOCK CUP FARM ⚽"
Sub.TextColor3 = Color3.new(1, 0.4, 0.4)
Sub.TextSize = 18

-- BOTON TOGGLE
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Parent = Main
ToggleBtn.BackgroundColor3 = Color3.new(0.2, 0, 0)
ToggleBtn.BorderColor3 = Color3.new(1, 1, 1)
ToggleBtn.BorderSizePixel = 1
ToggleBtn.Position = UDim2.new(0, 50, 0, 95)
ToggleBtn.Size = UDim2.new(0, 200, 0, 40)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.Text = "ACTIVAR"
ToggleBtn.TextColor3 = Color3.new(1,1,1)
ToggleBtn.TextSize = 20

-- == FUNCION MOVER ==
Main.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = true
        DragStart = Input.Position
        StartPos = Main.Position
    end
end)

UserInputService.InputChanged:Connect(function(Input)
    if Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement then
        local Delta = Input.Position - DragStart
        Main.Position = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
        Dragging = false
    end
end)

-- =============================================
-- 🧲 IMÁN ULTRA RÁPIDO Y OPTIMIZADO
-- =============================================
spawn(function()
    while task.wait(0.05) do -- ⚡ Menos check = 0 LAG
        if FarmActive then
            local MyPos = RootPart.Position
            for _, Item in pairs(Workspace:GetChildren()) do -- ⚡ Solo hijos, no todo el mapa
                if Item:IsA("BasePart") then
                    local Name = string.lower(Item.Name)
                    -- Buscar bolas
                    if string.find(Name, "ball") or string.find(Name, "orb") or string.find(Name, "coin") or Item.Color == Color3.new(1, 0.4, 0) then
                        
                        local Dist = (MyPos - Item.Position).Magnitude
                        if Dist < 40 then
                            -- 💨 VELOCIDAD MAXIMA
                            Item.CFrame = Item.CFrame:Lerp(RootPart.CFrame, 0.9)
                            
                            -- Agarrar automatico al tocar
                            if Dist < 3 then
                                Item.CFrame = RootPart.CFrame
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- == FUNCIONES FARM ==
local function StartFarm()
    if Loop then return end
    FarmActive = true
    ToggleBtn.Text = "DESACTIVAR"
    ToggleBtn.BackgroundColor3 = Color3.new(0, 0.4, 0)
    
    Loop = spawn(function()
        while FarmActive do
            -- PATEAR
            VirtualUser:Click()
            task.wait(1.5)
            
            -- VOLVER A BASE RAPIDO
            Humanoid.WalkSpeed = 100
            Humanoid:MoveTo(Vector3.new(-45, 0, 0))
            task.wait(4)
        end
    end)
end

local function StopFarm()
    FarmActive = false
    Loop = nil
    Humanoid.WalkSpeed = 16
    ToggleBtn.Text = "ACTIVAR"
    ToggleBtn.BackgroundColor3 = Color3.new(0.2, 0, 0)
end

ToggleBtn.MouseButton1Click:Connect(function()
    if not FarmActive then
        StartFarm()
    else
        StopFarm()
    end
end)
