--// SERVICIOS Y VARIABLES BASE
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

--// VARIABLES DE CONTROL
local AutoKickOpt1Enabled = false
local AutoKickOpt2Enabled = false
local AutoCollectEnabled = false

--// CREACIÓN DEL GUI PRINCIPAL
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_BloxBlockCup"
ScreenGui.Parent = game:GetService("CoreGui")

--// MARCO PRINCIPAL (CUADRADO CON ESQUINAS REDONDEADAS)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 500, 0, 500)
MainFrame.Position = UDim2.new(0.5, -250, 0.1, 0)
MainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.CornerRadius = UDim.new(0, 20)
MainFrame.Parent = ScreenGui

--// TÍTULO DEL MENU
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, 0, 0, 70)
TitleLabel.Position = UDim2.new(0, 0, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "JoseAngel_Blox Block Cup"
TitleLabel.TextColor3 = Color3.new(1, 0.3, 0.3)
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.RobotoBold
TitleLabel.Parent = MainFrame

--// MARCO OPCIÓN 1
local Option1Frame = Instance.new("Frame")
Option1Frame.Name = "Option1Frame"
Option1Frame.Size = UDim2.new(1, -30, 0, 180)
Option1Frame.Position = UDim2.new(0, 15, 0, 80)
Option1Frame.BackgroundColor3 = Color3.new(0.25, 0.1, 0.1)
Option1Frame.BackgroundTransparency = 0.2
Option1Frame.CornerRadius = UDim.new(0, 15)
Option1Frame.Parent = MainFrame

local Option1Title = Instance.new("TextLabel")
Option1Title.Name = "Option1Title"
Option1Title.Size = UDim2.new(1, 0, 0, 40)
Option1Title.Position = UDim2.new(0, 0, 0, 10)
Option1Title.BackgroundTransparency = 1
Option1Title.Text = "OPCIÓN 1: SOLO AUTO KICK"
Option1Title.TextColor3 = Color3.new(1, 1, 1)
Option1Title.TextScaled = true
Option1Title.Font = Enum.Font.RobotoBold
Option1Title.Parent = Option1Frame

local AutoKickLabel1 = Instance.new("TextLabel")
AutoKickLabel1.Name = "AutoKickLabel1"
AutoKickLabel1.Size = UDim2.new(1, 0, 0, 35)
AutoKickLabel1.Position = UDim2.new(0, 0, 0, 60)
AutoKickLabel1.BackgroundTransparency = 1
AutoKickLabel1.Text = "ACTIVAR AUTO KICK:"
AutoKickLabel1.TextColor3 = Color3.new(1, 1, 1)
AutoKickLabel1.TextScaled = true
AutoKickLabel1.Font = Enum.Font.Roboto
AutoKickLabel1.Parent = Option1Frame

local AutoKickToggle1 = Instance.new("TextButton")
AutoKickToggle1.Name = "AutoKickToggle1"
AutoKickToggle1.Size = UDim2.new(0.7, 0, 0, 50)
AutoKickToggle1.Position = UDim2.new(0.15, 0, 0, 100)
AutoKickToggle1.BackgroundColor3 = Color3.new(0.4, 0.1, 0.1)
AutoKickToggle1.Text = "DESACTIVADO (TECLA K)"
AutoKickToggle1.TextColor3 = Color3.new(1, 1, 1)
AutoKickToggle1.TextScaled = true
AutoKickToggle1.Font = Enum.Font.RobotoBold
AutoKickToggle1.CornerRadius = UDim.new(0, 15)
AutoKickToggle1.Parent = Option1Frame

--// MARCO OPCIÓN 2
local Option2Frame = Instance.new("Frame")
Option2Frame.Name = "Option2Frame"
Option2Frame.Size = UDim2.new(1, -30, 0, 200)
Option2Frame.Position = UDim2.new(0, 15, 0, 280)
Option2Frame.BackgroundColor3 = Color3.new(0.1, 0.25, 0.1)
Option2Frame.BackgroundTransparency = 0.2
Option2Frame.CornerRadius = UDim.new(0, 15)
Option2Frame.Parent = MainFrame

local Option2Title = Instance.new("TextLabel")
Option2Title.Name = "Option2Title"
Option2Title.Size = UDim2.new(1, 0, 0, 40)
Option2Title.Position = UDim2.new(0, 0, 0, 10)
Option2Title.BackgroundTransparency = 1
Option2Title.Text = "OPCIÓN 2: AUTO KICK + COLLECT"
Option2Title.TextColor3 = Color3.new(1, 1, 1)
Option2Title.TextScaled = true
Option2Title.Font = Enum.Font.RobotoBold
Option2Title.Parent = Option2Frame

local AutoKickLabel2 = Instance.new("TextLabel")
AutoKickLabel2.Name = "AutoKickLabel2"
AutoKickLabel2.Size = UDim2.new(1, 0, 0, 35)
AutoKickLabel2.Position = UDim2.new(0, 0, 0, 60)
AutoKickLabel2.BackgroundTransparency = 1
AutoKickLabel2.Text = "ACTIVAR AUTO KICK:"
AutoKickLabel2.TextColor3 = Color3.new(1, 1, 1)
AutoKickLabel2.TextScaled = true
AutoKickLabel2.Font = Enum.Font.Roboto
AutoKickLabel2.Parent = Option2Frame

local AutoKickToggle2 = Instance.new("TextButton")
AutoKickToggle2.Name = "AutoKickToggle2"
AutoKickToggle2.Size = UDim2.new(0.7, 0, 0, 45)
AutoKickToggle2.Position = UDim2.new(0.15, 0, 0, 100)
AutoKickToggle2.BackgroundColor3 = Color3.new(0.1, 0.4, 0.1)
AutoKickToggle2.Text = "DESACTIVADO (TECLA L)"
AutoKickToggle2.TextColor3 = Color3.new(1, 1, 1)
AutoKickToggle2.TextScaled = true
AutoKickToggle2.Font = Enum.Font.RobotoBold
AutoKickToggle2.CornerRadius = UDim.new(0, 15)
AutoKickToggle2.Parent = Option2Frame

local AutoCollectLabel = Instance.new("TextLabel")
AutoCollectLabel.Name = "AutoCollectLabel"
AutoCollectLabel.Size = UDim2.new(1, 0, 0, 35)
AutoCollectLabel.Position = UDim2.new(0, 0, 0, 155)
AutoCollectLabel.BackgroundTransparency = 1
AutoCollectLabel.Text = "ACTIVAR AUTO COLLECT:"
AutoCollectLabel.TextColor3 = Color3.new(1, 1, 1)
AutoCollectLabel.TextScaled = true
AutoCollectLabel.Font = Enum.Font.Roboto
AutoCollectLabel.Parent = Option2Frame

local AutoCollectToggle = Instance.new("TextButton")
AutoCollectToggle.Name = "AutoCollectToggle"
AutoCollectToggle.Size = UDim2.new(0.7, 0, 0, 45)
AutoCollectToggle.Position = UDim2.new(0.15, 0, 0, 190)
AutoCollectToggle.BackgroundColor3 = Color3.new(0.1, 0.4, 0.1)
AutoCollectToggle.Text = "DESACTIVADO (TECLA C)"
AutoCollectToggle.TextColor3 = Color3.new(1, 1, 1)
AutoCollectToggle.TextScaled = true
AutoCollectToggle.Font = Enum.Font.RobotoBold
AutoCollectToggle.CornerRadius = UDim.new(0, 15)
AutoCollectToggle.Parent = Option2Frame

--// BOTÓN DE CIERRE
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -45, 0, 5)
CloseButton.BackgroundColor3 = Color3.new(0.8, 0.1, 0.1)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.TextScaled = true
CloseButton.Font = Enum.Font.RobotoBold
CloseButton.CornerRadius = UDim.new(1, 0)
CloseButton.Parent = MainFrame


--// FUNCIONES DE CONTROL
-- Alternar Auto Kick Opción 1 (Tecla K)
local function ToggleAutoKickOpt1()
    AutoKickOpt1Enabled = not AutoKickOpt1Enabled
    local estado = AutoKickOpt1Enabled and "ACTIVADO" or "DESACTIVADO"
    AutoKickToggle1.Text = estado .. " (TECLA K)"
    AutoKickToggle1.BackgroundColor3 = AutoKickOpt1Enabled and Color3.new(0.6, 0.2, 0.2) or Color3.new(0.4, 0.1, 0.1)
end

AutoKickToggle1.MouseButton1Click:Connect(ToggleAutoKickOpt1)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.K then
        ToggleAutoKickOpt1()
    end
end)

-- Alternar Auto Kick Opción 2 (Tecla L)
local function ToggleAutoKickOpt2()
    AutoKickOpt2Enabled = not AutoKickOpt2Enabled
    local estado = AutoKickOpt2Enabled and "ACTIVADO" or "DESACTIVADO"
    AutoKickToggle2.Text = estado .. " (TECLA L)"
    AutoKickToggle2.BackgroundColor3 = AutoKickOpt2Enabled and Color3.new(0.2, 0.6, 0.2) or Color3.new(0.1, 0.4, 0.1)
end

AutoKickToggle2.MouseButton1Click:Connect(ToggleAutoKickOpt2)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.L then
        ToggleAutoKickOpt2()
    end
end)

-- Alternar Auto Collect (Tecla C)
local function ToggleAutoCollect()
    AutoCollectEnabled = not AutoCollectEnabled
    local estado = AutoCollectEnabled and "ACTIVADO" or "DESACTIVADO"
    AutoCollectToggle.Text = estado .. " (TECLA C)"
    AutoCollectToggle.BackgroundColor3 = AutoCollectEnabled and Color3.new(0.2, 0.6, 0.2) or Color3.new(0.1, 0.4, 0.1)
end

AutoCollectToggle.MouseButton1Click:Connect(ToggleAutoCollect)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.C then
        ToggleAutoCollect()
    end
end)

-- Cerrar menú
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    AutoKickOpt1Enabled = false
    AutoKickOpt2Enabled = false
    AutoCollectEnabled = false
end)


--// LÓGICA PRINCIPAL DEL JUEGO
-- Función para encontrar el Lucky Block
local function FindLuckyBlock()
    local PossibleBlocks = Workspace:FindFirstChild("LuckyBlocks") or Workspace:FindFirstChild("Blocks")
    if not PossibleBlocks then PossibleBlocks = Workspace end

    local ClosestBlock = nil
    local ClosestDistance = math.huge

    for _, Block in pairs(PossibleBlocks:GetChildren()) do
        if Block:IsA("BasePart") and (Block.Name:lower():find("lucky") or Block.Name:lower():find("block")) then
            if HumanoidRootPart then
                local Distance = (HumanoidRootPart.Position - Block.Position).Magnitude
                if Distance < ClosestDistance then
                    ClosestDistance = Distance
                    ClosestBlock = Block
                end
            end
        end
    end
    return ClosestBlock
end

-- Función para patear el bloque
local function KickBlock(Block)
    if not Block or not Humanoid or not HumanoidRootPart then return end

    local TargetPosition = Block.Position + Vector3.new(0, 0.5, 0)
    Humanoid:MoveTo(TargetPosition)
    local moveFinished = Humanoid.MoveToFinished:Wait(0.3)
    if not moveFinished then return end

    firetouchinterest(HumanoidRootPart, Block, 0)
    task.wait(0.1)
    firetouchinterest(HumanoidRootPart, Block, 1)
    task.wait(0.2)
end

-- Función para recolectar objetos
local function CollectItems()
    if not HumanoidRootPart then return end

    for _, Item in pairs(Workspace:GetDescendants()) do
        if AutoCollectEnabled and Item:IsA("BasePart") then
            local itemName = Item.Name:lower()
            if itemName:find("orange") or itemName:find("ball") or itemName:find("coin") or itemName:find("cup") then
                local Distance = (HumanoidRootPart.Position - Item.Position).Magnitude
                if Distance < 15 then
                    Humanoid:MoveTo(Item.Position)
                    Humanoid.MoveToFinished:Wait(0.15)
                    firetouchinterest(HumanoidRootPart, Item, 0)
                    task.wait(0.05)
                    firetouchinterest(HumanoidRootPart, Item, 1)
                end
            end
        end
    end
end

-- Actualizar personaje si se resetea
LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid = Character:WaitForChild("Humanoid")
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
end)

-- Bucle principal optimizado
RunService.Heartbeat:Connect(function()
    -- Ejecutar Auto Kick Opción 1
    if AutoKickOpt1Enabled then
        local Block = FindLuckyBlock()
        if Block then KickBlock(Block) end
    end

    -- Ejecutar Auto Kick Opción 2
    if AutoKickOpt2Enabled then
        local Block = FindLuckyBlock()
        if Block then KickBlock(Block) end
    end

    -- Ejecutar Auto Collect
    if AutoCollectEnabled then
        CollectItems()
    end
end)


print("JoseAngel_Blox Block Cup - Script cargado correctamente!")
