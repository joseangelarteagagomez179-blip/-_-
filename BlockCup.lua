--// Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local PathfindingService = game:GetService("PathfindingService")

--// Variables
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

--// Settings
local RANGE = 200
local Enabled = false
local Loop = nil
local EnMovimiento = false

--// UI Design
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local SubTitle = Instance.new("TextLabel")
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
MainFrame.Size = UDim2.new(0, 220, 0, 150)
MainFrame.Active = true
MainFrame.Draggable = true

UICorner.Parent = MainFrame
UICorner.CornerRadius = UDim.new(0, 10)

UIStroke.Parent = MainFrame
UIStroke.Color = Color3.new(1, 0.2, 0.2)
UIStroke.Thickness = 2

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

SubTitle.Name = "SubTitle"
SubTitle.Parent = MainFrame
SubTitle.BackgroundTransparency = 1
SubTitle.Position = UDim2.new(0, 0, 0.25, 0)
SubTitle.Size = UDim2.new(1, 0, 0, 20)
SubTitle.Font = Enum.Font.Gotham
SubTitle.Text = "Auto Correr & Recolectar"
SubTitle.TextColor3 = Color3.new(1, 0.3, 0.3)
SubTitle.TextSize = 14

--// Button
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = MainFrame
ToggleButton.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
ToggleButton.Position = UDim2.new(0.1, 0, 0.55, 0)
ToggleButton.Size = UDim2.new(0.8, 0, 0, 35)
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

-- Animación del fondo
spawn(function()
    while wait(0.05) do
        Gradient.Offset = Vector2.new(math.sin(os.clock()*0.5)*0.3, math.cos(os.clock()*0.3)*0.3)
        Gradient.Rotation = Gradient.Rotation + 1
    end
end)

-- FUNCIÓN PARA MOVERSE HACIA UN PUNTO (CORRER)
local function MoverHacia(Posicion)
    if EnMovimiento then return end
    EnMovimiento = true
    
    -- Poner velocidad máxima
    Humanoid.WalkSpeed = 100
    
    -- Hacer que el personaje mire y camine hacia allá
    Humanoid:MoveTo(Posicion)
    
    -- Esperar a que llegue o 3 segundos máximo
    local Llegue = false
    Humanoid.MoveToFinished:Connect(function(Ok)
        if Ok then Llegue = true end
    end)
    
    wait(3)
    EnMovimiento = false
end

-- FUNCIÓN PRINCIPAL
local function BuscarYCorrer()
    for _, Obj in pairs(Workspace:GetDescendants()) do
        
        -- BUSCAR BOLAS O ITEMS
        local Nombre = Obj.Name:lower()
        local EsBola = Nombre:find("ball") or Nombre:find("cup") or Nombre:find("event") or Nombre:find("orange") or Nombre:find("token")
        
        if EsBola and Obj:IsA("BasePart") then
            local Distancia = (HumanoidRootPart.Position - Obj.Position).Magnitude
            
            if Distancia < RANGE and Distancia > 5 then
                
                -- 1. EL PERSONAJE CORRE HACIA ALLÁ
                MoverHacia(Obj.Position)
                
                -- 2. CUANDO LLEGUE, FORZAR RECOLECCIÓN
                wait(0.2)
                firetouchinterest(HumanoidRootPart, Obj, 0)
                firetouchinterest(HumanoidRootPart, Obj, 1)
                
                -- 3. SI SOBRA ALGO, DESTRUIR
                spawn(function()
                    wait(0.5)
                    if Obj.Parent then Obj:Destroy() end
                end)
                
                break -- Salir del loop para no ir a otra al mismo tiempo
            end
        end
    end
end

-- Botón
ToggleButton.MouseButton1Click:Connect(function()
    Enabled = not Enabled
    if Enabled then
        ToggleButton.Text = "DETENER"
        ToggleButton.BackgroundColor3 = Color3.new(0.8, 0, 0)
        Loop = RunService.Heartbeat:Connect(BuscarYCorrer)
        print("🏃‍♂️ ACTIVADO: Corriendo hacia las bolas...")
    else
        ToggleButton.Text = "ACTIVAR"
        ToggleButton.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
        if Loop then Loop:Disconnect() end
        Humanoid.WalkSpeed = 16 -- Velocidad normal
        print("⏹️ DETENIDO")
    end
end)

-- Actualizar character
Player.CharacterAdded:Connect(function(char)
    Character = char
    HumanoidRootPart = char:WaitForChild("HumanoidRootPart")
    Humanoid = char:WaitForChild("Humanoid")
end)

print("✅ Script Cargado: JoseAngel_Blox Auto Runner")
