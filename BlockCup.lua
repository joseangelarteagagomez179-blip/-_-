--// Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

--// Variables
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

--// Settings
local RANGE = 50
local Enabled = false
local Loop = nil

--// UI Design
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ToggleButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")
local Gradient = Instance.new("UIGradient")

--// Properties
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.new(0.08, 0.08, 0.08)
MainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 130)
MainFrame.Active = true
MainFrame.Draggable = true -- HACE QUE SE PUEDA MOVER

UICorner.Parent = MainFrame
UICorner.CornerRadius = UDim.new(0, 10)

UIStroke.Parent = MainFrame
UIStroke.Color = Color3.new(1, 0.2, 0.2)
UIStroke.Thickness = 2
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

Gradient.Parent = MainFrame
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.new(0.1, 0.1, 0.1)),
    ColorSequenceKeypoint.new(1, Color3.new(0.3, 0, 0))
}
Gradient.Rotation = 45
Gradient.Offset = Vector2.new(0, 0)

--// Title
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "JoseAngel_Blox"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 18

local SubTitle = Instance.new("TextLabel")
SubTitle.Name = "SubTitle"
SubTitle.Parent = MainFrame
SubTitle.BackgroundTransparency = 1
SubTitle.Position = UDim2.new(0, 0, 0.25, 0)
SubTitle.Size = UDim2.new(1, 0, 0, 20)
SubTitle.Font = Enum.Font.Gotham
SubTitle.Text = "Block Cup Event"
SubTitle.TextColor3 = Color3.new(1, 0.3, 0.3)
SubTitle.TextSize = 14

--// Button
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = MainFrame
ToggleButton.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
ToggleButton.Position = UDim2.new(0.1, 0, 0.6, 0)
ToggleButton.Size = UDim2.new(0.8, 0, 0.3, 0)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "ACTIVAR"
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.TextSize = 16

local BtnCorner = Instance.new("UICorner")
BtnCorner.Parent = ToggleButton
BtnCorner.CornerRadius = UDim.new(0, 8)

local BtnStroke = Instance.new("UIStroke")
BtnStroke.Parent = ToggleButton
BtnStroke.Color = Color3.new(1, 0.4, 0.2)
BtnStroke.Thickness = 1

--// Logic

-- Animación del fondo moviéndose
spawn(function()
    while wait(0.05) do
        Gradient.Offset = Vector2.new(math.sin(os.clock()*0.5)*0.3, math.cos(os.clock()*0.3)*0.3)
        Gradient.Rotation = Gradient.Rotation + 1
    end
end)

-- Función de farm
local function FarmBalls()
    for _, Obj in pairs(workspace:GetChildren()) do
        if Obj:IsA("Part") or Obj:IsA("MeshPart") then
            if Obj.BrickColor == BrickColor.new("Orange") or string.find(Obj.Name:lower(), "ball") or string.find(Obj.Name:lower(), "cup") then
                local Distance = (HumanoidRootPart.Position - Obj.Position).Magnitude
                if Distance < RANGE then
                    Obj.CFrame = HumanoidRootPart.CFrame
                end
            end
        end
    end
end

-- Botón
ToggleButton.MouseButton1Click:Connect(function()
    Enabled = not Enabled
    if Enabled then
        ToggleButton.Text = "DESACTIVAR"
        ToggleButton.BackgroundColor3 = Color3.new(0.5, 0.1, 0.1)
        Loop = RunService.Heartbeat:Connect(FarmBalls)
    else
        ToggleButton.Text = "ACTIVAR"
        ToggleButton.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
        if Loop then Loop:Disconnect() end
    end
end)

print("✅ Script Cargado: JoseAngel_Blox Block Cup")
