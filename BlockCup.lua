--[[
Script Name: JoseAngel_Blox Block Cup
Description: Auto Farm Evento Block Cup
Author: JoseAngel_Blox
Version: 7.0 - ULTRA OPTIMIZADO SIN LAG
]]

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer

-- == VARIABLES GLOBALES ==
local FarmActive = false
local Loop = nil
local Dragging = nil
local DragStart = nil
local StartPos = nil
local Character, Humanoid, RootPart

-- == FUNCIÓN PARA ACTUALIZAR EL PERSONAJE ==
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
Main.Position = UDim2.new(0.05, 0, 0, 0.2)
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

-- == 1. FUNCION DESLIZAR ==
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
-- 🚀 VERSIÓN OPTIMIZADA AL MÁXIMO
-- =============================================
spawn(function()
    while task.wait(0.1) do -- ⚡ OPTIMIZACIÓN: Esperamos un poquito más para no saturar
        if FarmActive and RootPart then
            local MyPos = RootPart.Position
            for _, v in pairs(Workspace:GetChildren()) do -- ⚡ Solo buscamos en la raíz, no en todo el mapa
                
                -- ✅ SOLO BOLAS, NADA DE SUELO
                if v:IsA("BasePart") and v.Shape == Enum.PartType.Ball then
                    
                    local Name = string.lower(v.Name)
                    
                    -- DETECTA TODAS
                    if string.find(Name, "ball") or 
                       string.find(Name, "orb") or 
                       string.find(Name, "rare") or
                       string.find(Name, "epic") or
                       string.find(Name, "legendary") or
                       string.find(Name, "mutation") or
                       string.find(Name, "double") or
                       string.find(Name, "chance") then
                        
                        local Dist = (MyPos - v.Position).Magnitude
                        
                        if Dist < 60 then
                            -- 🧲 FUERZA PERO LIGERA
                            v.CFrame = v.CFrame:Lerp(RootPart.CFrame, 0.5)
                            
                            -- ✅ CONTABILIZAR
                            if Dist < 4 then
                                v.CFrame = RootPart.CFrame
                                v.Anchored = false
                                v.CanCollide = false
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- == 3. AUTO FARM ==
local function StartFarm()
    if Loop then return end
    FarmActive = true
    ToggleBtn.Text = "DESACTIVAR"
    ToggleBtn.BackgroundColor3 = Color3.new(0, 0.4, 0)
    
    Loop = spawn(function()
        while FarmActive do
            if not Humanoid then UpdateCharacter() end
            
            -- PATEAR
            VirtualUser:Click()
            task.wait(1.5)
            
            -- VOLVER A BASE
            if Humanoid then
                Humanoid.WalkSpeed = 100
                Humanoid:MoveTo(Vector3.new(-45, 0, 0))
            end
            task.wait(4)
        end
    end)
end

local function StopFarm()
    FarmActive = false
    Loop = nil
    if Humanoid then
        Humanoid.WalkSpeed = 16
    end
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
