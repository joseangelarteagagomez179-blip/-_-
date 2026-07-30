-- JoseAngel_Blox Pro Weights v1.1
-- Fecha: 30/07/2026
-- Creado por JoseAngel_Blox

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- Evitar duplicados
if PlayerGui:FindFirstChild("JoseAngel_Blox_Pro_Weights") then
    PlayerGui.JoseAngel_Blox_Pro_Weights:Destroy()
end

-- Crear ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "JoseAngel_Blox_Pro_Weights"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = PlayerGui

-- Contenedor principal (cuadrado con esquinas redondeadas)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 380)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -190)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
mainFrame.BorderSizePixel = 0
mainFrame.BackgroundTransparency = 0.2
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

-- Simular esquinas redondeadas con ImageLabel (círculo blanco transparente)
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = mainFrame

-- Título
local title = Instance.new("TextLabel")
title.Text = "JoseAngel_Blox Pro Weights"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 10)
title.Parent = mainFrame

-- Firma
local signature = Instance.new("TextLabel")
signature.Text = "Creado por JoseAngel_Blox"
signature.Font = Enum.Font.Creepster -- Fuente "bonita" y estilizada
signature.TextSize = 16
signature.TextColor3 = Color3.fromRGB(200, 200, 255)
signature.BackgroundTransparency = 1
signature.Size = UDim2.new(1, 0, 0, 25)
signature.Position = UDim2.new(0, 0, 0, 40)
signature.Parent = mainFrame

-- Barra de pestañas
local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(1, 0, 0, 40)
tabFrame.Position = UDim2.new(0, 0, 0, 75)
tabFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
tabFrame.BorderSizePixel = 0
tabFrame.Parent = mainFrame

local tabCorner = Instance.new("UICorner")
tabCorner.CornerRadius = UDim.new(0, 8)
tabCorner.Parent = tabFrame

-- Botón Info
local btnInfo = Instance.new("TextButton")
btnInfo.Text = "Info"
btnInfo.Font = Enum.Font.GothamSemibold
btnInfo.TextSize = 14
btnInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
btnInfo.BackgroundColor3 = Color3.fromRGB(70, 70, 85)
btnInfo.Size = UDim2.new(0.5, -2, 1, -4)
btnInfo.Position = UDim2.new(0, 2, 0, 2)
btnInfo.BorderSizePixel = 0
btnInfo.Parent = tabFrame

local btnInfoCorner = Instance.new("UICorner")
btnInfoCorner.CornerRadius = UDim.new(0, 6)
btnInfoCorner.Parent = btnInfo

-- Botón Weights Pro
local btnWeights = Instance.new("TextButton")
btnWeights.Text = "Weights Pro"
btnWeights.Font = Enum.Font.GothamSemibold
btnWeights.TextSize = 14
btnWeights.TextColor3 = Color3.fromRGB(200, 200, 200)
btnWeights.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
btnWeights.Size = UDim2.new(0.5, -2, 1, -4)
btnWeights.Position = UDim2.new(0.5, 2, 0, 2)
btnWeights.BorderSizePixel = 0
btnWeights.Parent = tabFrame

local btnWeightsCorner = Instance.new("UICorner")
btnWeightsCorner.CornerRadius = UDim.new(0, 6)
btnWeightsCorner.Parent = btnWeights

-- Contenido de las pestañas
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, 0, 1, -125)
contentFrame.Position = UDim2.new(0, 0, 0, 115)
contentFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainFrame

local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 10)
contentCorner.Parent = contentFrame

-- Texto de Info
local infoText = Instance.new("TextLabel")
infoText.Text = [[Nombre del Creador: JoseAngel_Blox
Fecha de creación: 30/07/2026
Versión: 1.1
Update: Nuevo Script - 0 Bugs - Mayor compatibilidad]]
infoText.Font = Enum.Font.Gotham
infoText.TextSize = 14
infoText.TextColor3 = Color3.fromRGB(220, 220, 255)
infoText.BackgroundTransparency = 1
infoText.Size = UDim2.new(1, -20, 1, -10)
infoText.Position = UDim2.new(0, 10, 0, 5)
infoText.TextXAlignment = Enum.TextXAlignment.Left
infoText.TextYAlignment = Enum.TextYAlignment.Top
infoText.RichText = false
infoText.Parent = contentFrame

-- Botones de Weights Pro
local autoSpeedBtn = Instance.new("TextButton")
autoSpeedBtn.Text = "Auto Speed Weight"
autoSpeedBtn.Font = Enum.Font.GothamBold
autoSpeedBtn.TextSize = 15
autoSpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoSpeedBtn.BackgroundColor3 = Color3.fromRGB(60, 100, 200)
autoSpeedBtn.Size = UDim2.new(1, -20, 0, 35)
autoSpeedBtn.Position = UDim2.new(0, 10, 0, 10)
autoSpeedBtn.BorderSizePixel = 0
autoSpeedBtn.Visible = false
autoSpeedBtn.Parent = contentFrame

local autoSpeedCorner = Instance.new("UICorner")
autoSpeedCorner.CornerRadius = UDim.new(0, 6)
autoSpeedCorner.Parent = autoSpeedBtn

local autoClickBtn = Instance.new("TextButton")
autoClickBtn.Text = "Auto Click x2"
autoClickBtn.Font = Enum.Font.GothamBold
autoClickBtn.TextSize = 15
autoClickBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
autoClickBtn.BackgroundColor3 = Color3.fromRGB(60, 200, 100)
autoClickBtn.Size = UDim2.new(1, -20, 0, 35)
autoClickBtn.Position = UDim2.new(0, 10, 0, 55)
autoClickBtn.BorderSizePixel = 0
autoClickBtn.Visible = false
autoClickBtn.Parent = contentFrame

local autoClickCorner = Instance.new("UICorner")
autoClickCorner.CornerRadius = UDim.new(0, 6)
autoClickCorner.Parent = autoClickBtn

-- Estado de funciones (para activar/desactivar)
local isAutoSpeedActive = false
local isAutoClickActive = false

-- Funciones reales (puedes personalizarlas según el juego)
autoSpeedBtn.MouseButton1Click:Connect(function()
    isAutoSpeedActive = not isAutoSpeedActive
    autoSpeedBtn.BackgroundColor3 = isAutoSpeedActive and Color3.fromRGB(50, 200, 100) or Color3.fromRGB(60, 100, 200)
    autoSpeedBtn.Text = isAutoSpeedActive and "✔ Auto Speed Weight (ON)" or "Auto Speed Weight"

    if isAutoSpeedActive then
        -- Aquí iría la lógica real para "Auto Speed Weight"
        -- Ejemplo genérico: simular presión de tecla o evento
        spawn(function()
            while isAutoSpeedActive do
                wait(0.05)
                -- 🔧 Reemplaza esto con la llamada real al RemoteEvent del juego
                -- Ej: game:GetService("ReplicatedStorage").Remotes.SpeedWeight:FireServer()
                print("[JoseAngel_Blox] Auto Speed Weight activado (simulado)")
            end
        end)
    end
end)

autoClickBtn.MouseButton1Click:Connect(function()
    isAutoClickActive = not isAutoClickActive
    autoClickBtn.BackgroundColor3 = isAutoClickActive and Color3.fromRGB(50, 200, 100) or Color3.fromRGB(60, 200, 100)
    autoClickBtn.Text = isAutoClickActive and "✔ Auto Click x2 (ON)" or "Auto Click x2"

    if isAutoClickActive then
        spawn(function()
            while isAutoClickActive do
                wait(0.01) -- Click muy rápido
                -- 🔧 Reemplaza con la función real del juego
                print("[JoseAngel_Blox] Auto Click x2 activado (simulado)")
            end
        end)
    end
end)

-- Cambiar pestañas
btnInfo.MouseButton1Click:Connect(function()
    btnInfo.BackgroundColor3 = Color3.fromRGB(70, 70, 85)
    btnInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnWeights.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    btnWeights.TextColor3 = Color3.fromRGB(200, 200, 200)
    
    infoText.Visible = true
    autoSpeedBtn.Visible = false
    autoClickBtn.Visible = false
end)

btnWeights.MouseButton1Click:Connect(function()
    btnWeights.BackgroundColor3 = Color3.fromRGB(70, 70, 85)
    btnWeights.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnInfo.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    btnInfo.TextColor3 = Color3.fromRGB(200, 200, 200)
    
    infoText.Visible = false
    autoSpeedBtn.Visible = true
    autoClickBtn.Visible = true
end)

-- Mensaje de inicio
print("✅ JoseAngel_Blox Pro Weights v1.1 cargado correctamente.")
