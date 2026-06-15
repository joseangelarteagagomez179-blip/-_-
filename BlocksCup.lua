--// SERVICIOS Y VARIABLES BASE
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

--// VARIABLES DE CONTROL
local AutoKickEnabled = false
local AutoCollectEnabled = false
local SelectedOption = 1 -- 1 = Opción 1 (Solo Auto Kick) | 2 = Opción 2 (Auto Kick + Auto Collect)

--// CREACIÓN DEL GUI PRINCIPAL
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_BloxBlockCup"
ScreenGui.Parent = game:GetService("CoreGui") -- Ubicación segura para exploits

--// MARCO PRINCIPAL CON FONDO ANIMADO
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.2, 0)
MainFrame.BackgroundTransparency = 1
MainFrame.Parent = ScreenGui

--// FONDO ANIMADO: RAYOS NEGROS Y ROJOS GIRANDO
local RayContainer = Instance.new("Frame")
RayContainer.Name = "RayContainer"
RayContainer.Size = UDim2.new(1, 0, 1, 0)
RayContainer.BackgroundTransparency = 1
RayContainer.ClipsDescendants = false
RayContainer.Parent = MainFrame

-- Función para crear rayos
local function CreateRay(color, thickness, offsetAngle)
    local Ray = Instance.new("Frame")
    Ray.Name = "AnimatedRay"
    Ray.Size = UDim2.new(0, thickness, 0, 200)
    Ray.Position = UDim2.new(0.5, -thickness/2, 0, -100)
    Ray.BackgroundColor3 = color
    Ray.BackgroundTransparency = 0.3
    Ray.Rotation = offsetAngle
    Ray.Parent = RayContainer

    -- Animación de rotación
    local TweenInfo = TweenInfo.new(
        8, -- Duración de la rotación (segundos)
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.InOut,
        -1 -- Repetir infinitamente
    )
    local Tween = TweenService:Create(Ray, TweenInfo, {Rotation = offsetAngle + 360})
    Tween:Play()
end

-- Crear rayos (8 en total: 4 negros, 4 rojos)
for i = 0, 3 do
    CreateRay(Color3.new(0,0,0), 5, i*90) -- Rayos negros
    CreateRay(Color3.new(1,0,0), 3, i*90 + 45) -- Rayos rojos
end

--// MARCO DE CONTENIDO (Sobre el fondo animado)
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -20, 1, -20)
ContentFrame.Position = UDim2.new(0, 10, 0, 10)
ContentFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
ContentFrame.BackgroundTransparency = 0.5
ContentFrame.BorderSizePixel = 0
ContentFrame.CornerRadius = UDim.new(0, 10)
ContentFrame.Parent = MainFrame

--// TÍTULO DEL MENU
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, 0, 0, 50)
TitleLabel.Position = UDim2.new(0, 0, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "JoseAngel_Blox Block Cup"
TitleLabel.TextColor3 = Color3.new(1, 0.2, 0.2)
TitleLabel.TextScaled = true
TitleLabel.Font = Enum.Font.RobotoBold
TitleLabel.Parent = ContentFrame

--// OPCIONES DE SELECCIÓN
local Option1Button = Instance.new("TextButton")
Option1Button.Name = "Option1Button"
Option1Button.Size = UDim2.new(0.45, 0, 0, 40)
Option1Button.Position = UDim2.new(0.05, 0, 0, 60)
Option1Button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
Option1Button.Text = "Opción 1: Solo Auto Kick"
Option1Button.TextColor3 = Color3.new(1,1,1)
Option1Button.Font = Enum.Font.Roboto
Option1Button.CornerRadius = UDim.new(0, 5)
Option1Button.Parent = ContentFrame

local Option2Button = Instance.new("TextButton")
Option2Button.Name = "Option2Button"
Option2Button.Size = UDim2.new(0.45, 0, 0, 40)
Option2Button.Position = UDim2.new(0.5, 0, 0, 60)
Option2Button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
Option2Button.Text = "Opción 2: Auto Kick + Collect"
Option2Button.TextColor3 = Color3.new(1,1,1)
Option2Button.Font = Enum.Font.Roboto
Option2Button.CornerRadius = UDim.new(0, 5)
Option2Button.Parent = ContentFrame

--// CONTROLES DE CADA OPCIÓN
local ControlFrame = Instance.new("Frame")
ControlFrame.Name = "ControlFrame"
ControlFrame.Size = UDim2.new(1, 0, 0, 150)
ControlFrame.Position = UDim2.new(0, 0, 0, 110)
ControlFrame.BackgroundTransparency = 1
ControlFrame.Parent = ContentFrame

-- Control Opción 1
local Option1Control = Instance.new("Frame")
Option1Control.Name = "Option1Control"
Option1Control.Size = UDim2.new(1, 0, 1, 0)
Option1Control.BackgroundTransparency = 1
Option1Control.Parent = ControlFrame

local AutoKickToggle1 = Instance.new("TextButton")
AutoKickToggle1.Name = "AutoKickToggle1"
AutoKickToggle1.Size = UDim2.new(1, 0, 0, 50)
AutoKickToggle1.Position = UDim2.new(0, 0, 0, 0)
AutoKickToggle1.BackgroundColor3 = Color3.new(0.3, 0.1, 0.1)
AutoKickToggle1.Text = "Auto Kick DESACTIVADO (Presiona K para alternar)"
AutoKickToggle1.TextColor3 = Color3.new(1,1,1)
AutoKickToggle1.Font = Enum.Font.Roboto
AutoKickToggle1.CornerRadius = UDim.new(0, 5)
AutoKickToggle1.Parent = Option1Control

-- Control Opción 2
local Option2Control = Instance.new("Frame")
Option2Control.Name = "Option2Control"
Option2Control.Size = UDim2.new(1, 0, 1, 0)
Option2Control.BackgroundTransparency = 1
Option2Control.Visible = false
Option2Control.Parent = ControlFrame

local AutoKickToggle2 = Instance.new("TextButton")
AutoKickToggle2.Name = "AutoKickToggle2"
AutoKickToggle2.Size = UDim2.new(1, 0, 0, 50)
AutoKickToggle2.Position = UDim2.new(0, 0, 0, 0)
AutoKickToggle2.BackgroundColor3 = Color3.new(0.3, 0.1, 0.1)
AutoKickToggle2.Text = "Auto Kick DESACTIVADO (K para alternar)"
AutoKickToggle2.TextColor3 = Color3.new(1,1,1)
AutoKickToggle2.Font = Enum.Font.Roboto
AutoKickToggle2.CornerRadius = UDim.new(0, 5)
AutoKickToggle2.Parent = Option2Control

local AutoCollectToggle = Instance.new("TextButton")
AutoCollectToggle.Name = "AutoCollectToggle"
AutoCollectToggle.Size = UDim2.new(1, 0, 0, 50)
AutoCollectToggle.Position = UDim2.new(0, 0, 0, 60)
AutoCollectToggle.BackgroundColor3 = Color3.new(0.1, 0.3, 0.1)
AutoCollectToggle.Text = "Auto Collect DESACTIVADO (C para alternar)"
AutoCollectToggle.TextColor3 = Color3.new(1,1,1)
AutoCollectToggle.Font = Enum.Font.Roboto
AutoCollectToggle.CornerRadius = UDim.new(0, 5)
AutoCollectToggle.Parent = Option2Control

--// BOTÓN PARA CERRAR
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundColor3 = Color3.new(0.8, 0.1, 0.1)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.new(1,1,1)
CloseButton.Font = Enum.Font.RobotoBold
CloseButton.CornerRadius = UDim.new(1, 0)
CloseButton.Parent = MainFrame


--// FUNCIONES DE INTERFAZ
-- Cambiar entre opciones
local function UpdateSelectedOption(option)
    SelectedOption = option
    Option1Button.BackgroundColor3 = option == 1 and Color3.new(0.4, 0.1, 0.1) or Color3.new(0.2, 0.2, 0.2)
    Option2Button.BackgroundColor3 = option == 2 and Color3.new(0.1, 0.4, 0.1) or Color3.new(0.2, 0.2, 0.2)
    Option1Control.Visible = option == 1
    Option2Control.Visible = option == 2
end

Option1Button.MouseButton1Click:Connect(function()
    UpdateSelectedOption(1)
end)

Option2Button.MouseButton1Click:Connect(function()
    UpdateSelectedOption(2)
end)

-- Cerrar GUI
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    AutoKickEnabled = false
    AutoCollectEnabled = false
end)

-- Alternar Auto Kick
local function ToggleAutoKick()
    AutoKickEnabled = not AutoKickEnabled
    local text = AutoKickEnabled and "Auto Kick ACTIVADO" or "Auto Kick DESACTIVADO"
    AutoKickToggle1.Text = text .. " (Presiona K para alternar)"
    AutoKickToggle2.Text = text .. " (K para alternar)"
    AutoKickToggle1.BackgroundColor3 = AutoKickEnabled and Color3.new(0.5, 0.2, 0.2) or Color3.new(0.3, 0.1, 0.1)
    AutoKickToggle2.BackgroundColor3 = AutoKickEnabled and Color3.new(0.5, 0.2, 0.2) or Color3.new(0.3, 0.1, 0.1)
end

AutoKickToggle1.MouseButton1Click:Connect(ToggleAutoKick)
AutoKickToggle2.MouseButton1Click:Connect(ToggleAutoKick)
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.K then
        ToggleAutoKick()
    end
end)

-- Alternar Auto Collect (solo Opción 2)
local function ToggleAutoCollect()
    AutoCollectEnabled = not AutoCollectEnabled
    local text = AutoCollectEnabled and "Auto Collect ACTIVADO" or "Auto Collect DESACTIVADO"
    AutoCollectToggle.Text = text .. " (C para alternar)"
    AutoCollectToggle.BackgroundColor3 = AutoCollectEnabled and Color3.new(0.2, 0.5, 0.2) or Color3.new(0.1, 0.3, 0.1)
end

AutoCollectToggle.MouseButton1Click:Connect(ToggleAutoCollect)
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.C then
        ToggleAutoCollect()
    end
end)


--// LÓGICA PRINCIPAL DEL JUEGO
-- Función para encontrar el Lucky Block
local function FindLuckyBlock()
    -- Busca bloques con nombres comunes en el juego (ajusta si es necesario)
    local PossibleBlocks = Workspace:FindFirstChild("LuckyBlocks") or Workspace:FindFirstChild("Blocks")
    if not PossibleBlocks then return nil end

    local ClosestBlock = nil
    local ClosestDistance = math.huge

    for _, Block in ipairs(PossibleBlocks:GetChildren()) do
        if Block:IsA("BasePart") and HumanoidRootPart then
            local Distance = (HumanoidRootPart.Position - Block.Position).Magnitude
            if Distance < ClosestDistance then
                ClosestDistance = Distance
                ClosestBlock = Block
            end
        end
    end
    return ClosestBlock
end

-- Función para patear el bloque
local function KickBlock(Block)
    if not Block or not Humanoid or not HumanoidRootPart then return end

    -- Mover personaje cerca del bloque (si es necesario)
    local TargetPosition = Block.Position + Vector3.new(0, 0.5, 0)
    Humanoid:MoveTo(TargetPosition)
    Humanoid.MoveToFinished:Wait(0.2) -- Esperar un poco para llegar

    -- Simular animación de patada (método seguro sin detectar fácilmente)
    local KickAnimation = Instance.new("Animation")
    KickAnimation.AnimationId = "rbxassetid://123456789" -- Animación genérica de patada (ajusta ID si quieres)
    local LoadedAnim = Humanoid:LoadAnimation(KickAnimation)
    LoadedAnim:Play()

    -- Interactuar con el bloque (método que usa las funciones nativas del juego)
    firetouchinterest(HumanoidRootPart, Block, 0)
    task.wait(0.1)
    firetouchinterest(HumanoidRootPart, Block, 1)
    task.wait(0.2) -- Esperar entre patadas para evitar bugs
end

-- Función para recolectar objetos
local function CollectItems()
    if not HumanoidRootPart then return end

    -- Buscar objetos a recolectar: Orange Balls, monedas, etc.
    local Collectibles = Workspace:GetDescendants()
    for _, Item in ipairs(Collectibles) do
        if AutoCollectEnabled and Item:IsA("BasePart") then
            -- Nombres comunes de objetos en el evento
            if string.find(Item.Name:lower(), "orange") or string.find(Item.Name:lower(), "ball") or string.find(Item.Name:lower(), "coin") or string.find(Item.Name:lower(), "cup") then
                local Distance = (HumanoidRootPart.Position - Item.Position).Magnitude
                if Distance < 15 then -- Recoger solo si está cerca
                    Humanoid:MoveTo(Item.Position)
                    Humanoid.MoveToFinished:Wait(0.1)
                    firetouchinterest(HumanoidRootPart, Item, 0)
                    task.wait(0.05)
                    firetouchinterest(HumanoidRootPart, Item, 1)
                end
            end
        end
    end
end

-- Bucle principal (optimizado para no consumir muchos recursos)
RunService.Heartbeat:Connect(function()
    -- Actualizar personaje si se resetea
    if not Character or not Character.Parent then
        Character = LocalPlayer.CharacterAdded:Wait()
        Humanoid = Character:WaitForChild("Humanoid")
        HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    end

    -- Ejecutar Auto Kick si está activado
    if AutoKickEnabled then
        local Block = FindLuckyBlock()
        if Block then
            KickBlock(Block)
        end
    end

    -- Ejecutar Auto Collect si está activado y es la Opción 2
    if AutoCollectEnabled and SelectedOption == 2 then
        CollectItems()
    end
end)


--// INICIALIZACIÓN
UpdateSelectedOption(1) -- Seleccionar Opción 1 por defecto
print("JoseAngel_Blox Block Cup - Script cargado correctamente!")
