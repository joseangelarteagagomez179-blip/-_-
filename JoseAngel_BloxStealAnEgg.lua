--==============================================================
-- SCRIPT: JoseAngel_Blox Steal An Egg
-- CREADO POR: JoseAngel_Blox
-- VERSIÓN: 1.1
-- FECHA: 09/09/2026
--==============================================================

--// SERVICIOS
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

--// ELIMINAR GUI ANTERIOR SI EXISTE
local oldGui = PlayerGui:FindFirstChild("JoseAngel_Blox_StealAnEgg")
if oldGui then oldGui:Destroy() end

--==============================================================
--// CREAR INTERFAZ PRINCIPAL
--==============================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Blox_StealAnEgg"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

--// VENTANA PRINCIPAL (cuadrada con esquinas redondeadas)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 550, 0, 400)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(0, 150, 255)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

--==============================================================
--// TÍTULO CON LETRAS AZULES EN MOVIMIENTO
--==============================================================
local TitleFrame = Instance.new("Frame")
TitleFrame.Size = UDim2.new(1, 0, 0, 60)
TitleFrame.Position = UDim2.new(0, 0, 0, 0)
TitleFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
TitleFrame.BorderSizePixel = 0
TitleFrame.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 16)
TitleCorner.Parent = TitleFrame

-- Parche para que las esquinas inferiores del título no queden redondeadas
local TitlePatch = Instance.new("Frame")
TitlePatch.Size = UDim2.new(1, 0, 0, 16)
TitlePatch.Position = UDim2.new(0, 0, 1, -16)
TitlePatch.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
TitlePatch.BorderSizePixel = 0
TitlePatch.Parent = TitleFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, 0, 1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "JoseAngel_Blox Steal An Egg"
TitleLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextScaled = true
TitleLabel.TextSize = 28
TitleLabel.Parent = TitleFrame

local TitlePadding = Instance.new("UIPadding")
TitlePadding.PaddingLeft = UDim.new(0, 10)
TitlePadding.PaddingRight = UDim.new(0, 10)
TitlePadding.Parent = TitleLabel

-- Efecto de texto en movimiento (degradado azul animado)
local titleText = "JoseAngel_Blox Steal An Egg"
local hueOffset = 0
task.spawn(function()
    while ScreenGui.Parent do
        hueOffset = (hueOffset + 0.005) % 1
        local color = Color3.fromHSV(hueOffset * 0.15 + 0.55, 1, 1) -- Rango azul
        TitleLabel.TextColor3 = color
        task.wait(0.05)
    end
end)

-- Efecto adicional: el texto se desplaza ligeramente
task.spawn(function()
    while ScreenGui.Parent do
        for i = 1, 30 do
            TitleLabel.Position = UDim2.new(0, math.sin(i * 0.2) * 3, 0, 0)
            task.wait(0.03)
        end
    end
end)

--==============================================================
--// SUBTÍTULO: "Creado por JoseAngel_Blox" (transparente)
--==============================================================
local SubtitleLabel = Instance.new("TextLabel")
SubtitleLabel.Name = "SubtitleLabel"
SubtitleLabel.Size = UDim2.new(1, 0, 0, 20)
SubtitleLabel.Position = UDim2.new(0, 0, 0, 55)
SubtitleLabel.BackgroundTransparency = 1
SubtitleLabel.Text = "Creado por JoseAngel_Blox"
SubtitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SubtitleLabel.TextTransparency = 0.5 -- Transparente
SubtitleLabel.Font = Enum.Font.Gotham
SubtitleLabel.TextSize = 14
SubtitleLabel.Parent = MainFrame

--==============================================================
--// PANEL IZQUIERDO (PESTAÑAS)
--==============================================================
local TabPanel = Instance.new("Frame")
TabPanel.Name = "TabPanel"
TabPanel.Size = UDim2.new(0, 140, 1, -110)
TabPanel.Position = UDim2.new(0, 10, 0, 85)
TabPanel.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
TabPanel.BorderSizePixel = 0
TabPanel.Parent = MainFrame

local TabPanelCorner = Instance.new("UICorner")
TabPanelCorner.CornerRadius = UDim.new(0, 10)
TabPanelCorner.Parent = TabPanel

local TabLayout = Instance.new("UIListLayout")
TabLayout.Padding = UDim.new(0, 6)
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Parent = TabPanel

local TabPadding = Instance.new("UIPadding")
TabPadding.PaddingTop = UDim.new(0, 8)
TabPadding.PaddingLeft = UDim.new(0, 6)
TabPadding.PaddingRight = UDim.new(0, 6)
TabPadding.Parent = TabPanel

--==============================================================
--// PANEL DERECHO (CONTENIDO)
--==============================================================
local ContentPanel = Instance.new("Frame")
ContentPanel.Name = "ContentPanel"
ContentPanel.Size = UDim2.new(1, -170, 1, -110)
ContentPanel.Position = UDim2.new(0, 160, 0, 85)
ContentPanel.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
ContentPanel.BorderSizePixel = 0
ContentPanel.Parent = MainFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 10)
ContentCorner.Parent = ContentPanel

local ContentPadding = Instance.new("UIPadding")
ContentPadding.PaddingTop = UDim.new(0, 10)
ContentPadding.PaddingLeft = UDim.new(0, 10)
ContentPadding.PaddingRight = UDim.new(0, 10)
ContentPadding.PaddingBottom = UDim.new(0, 10)
ContentPadding.Parent = ContentPanel

--==============================================================
--// SISTEMA DE PESTAÑAS
--==============================================================
local tabs = {}
local activeTab = nil

local function createTab(name)
    local button = Instance.new("TextButton")
    button.Name = name .. "Tab"
    button.Size = UDim2.new(1, 0, 0, 38)
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    button.Text = name
    button.TextColor3 = Color3.fromRGB(200, 200, 200)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 14
    button.BorderSizePixel = 0
    button.Parent = TabPanel

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button

    -- Página de contenido
    local page = Instance.new("Frame")
    page.Name = name .. "Page"
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Parent = ContentPanel

    tabs[name] = { Button = button, Page = page }

    button.MouseButton1Click:Connect(function()
        for _, tab in pairs(tabs) do
            tab.Page.Visible = false
            tab.Button.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
            tab.Button.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
        page.Visible = true
        button.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        activeTab = name
    end)

    return page
end

--==============================================================
--// PESTAÑA 1: INFO
--==============================================================
local infoPage = createTab("Info")

local infoScroll = Instance.new("ScrollingFrame")
infoScroll.Size = UDim2.new(1, 0, 1, 0)
infoScroll.BackgroundTransparency = 1
infoScroll.BorderSizePixel = 0
infoScroll.ScrollBarThickness = 5
infoScroll.CanvasSize = UDim2.new(0, 0, 0, 400)
infoScroll.Parent = infoPage

local infoLayout = Instance.new("UIListLayout")
infoLayout.Padding = UDim.new(0, 6)
infoLayout.SortOrder = Enum.SortOrder.LayoutOrder
infoLayout.Parent = infoScroll

local function createInfoLabel(text, color, size)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, size or 22)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = color or Color3.fromRGB(220, 220, 220)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextWrapped = true
    label.Parent = infoScroll
    return label
end

createInfoLabel("Nombre del Creador: JoseAngel_Blox", Color3.fromRGB(0, 170, 255), 24)
createInfoLabel("Fecha de lanzamiento: 09/09/2026", Color3.fromRGB(220, 220, 220))
createInfoLabel("Versión: 1.1", Color3.fromRGB(220, 220, 220))
createInfoLabel("", Color3.fromRGB(220, 220, 220), 10)
createInfoLabel("UPDATE:", Color3.fromRGB(0, 255, 150), 22)
createInfoLabel(
    "Bienvenido o bienvenida a mi Script, este script es nuevo para este juego llamado roba un huevo y es uno de los mejores scripts básico. Si eres nuevo o nueva usando Delta, este es el mejor script fácil para este juego, así que espero que disfrutes del script. Atentamente, JoseAngel_Blox.",
    Color3.fromRGB(200, 200, 200),
    80
)

--==============================================================
--// PESTAÑA 2: MAIN
--==============================================================
local mainPage = createTab("Main")

local mainScroll = Instance.new("ScrollingFrame")
mainScroll.Size = UDim2.new(1, 0, 1, 0)
mainScroll.BackgroundTransparency = 1
mainScroll.BorderSizePixel = 0
mainScroll.ScrollBarThickness = 5
mainScroll.CanvasSize = UDim2.new(0, 0, 0, 400)
mainScroll.Parent = mainPage

local mainLayout = Instance.new("UIListLayout")
mainLayout.Padding = UDim.new(0, 8)
mainLayout.SortOrder = Enum.SortOrder.LayoutOrder
mainLayout.Parent = mainScroll

-- Función para crear botones de toggle
local function createToggle(text, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 40)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    frame.BorderSizePixel = 0
    frame.Parent = mainScroll

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -70, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(230, 230, 230)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 50, 0, 26)
    toggleBtn.Position = UDim2.new(1, -60, 0.5, -13)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    toggleBtn.Text = "OFF"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.TextSize = 12
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Parent = frame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = toggleBtn

    local state = false
    toggleBtn.MouseButton1Click:Connect(function()
        state = not state
        toggleBtn.Text = state and "ON" or "OFF"
        toggleBtn.BackgroundColor3 = state and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(60, 60, 80)
        callback(state)
    end)

    return frame
end

--==============================================================
--// FUNCIONES DEL SCRIPT
--==============================================================

--// 1. AUTO FARM (teletransportar a StartArea)
local autoFarmEnabled = false
local function startAutoFarm()
    task.spawn(function()
        while autoFarmEnabled do
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local startArea = workspace:FindFirstChild("StartArea")
                    or workspace:FindFirstChild("SpawnLocation")
                    or workspace:FindFirstChild("Start")
                if startArea then
                    char.HumanoidRootPart.CFrame = CFrame.new(startArea.Position + Vector3.new(0, 5, 0))
                end
            end
            task.wait(1)
        end
    end)
end

createToggle("Auto Farm (ir a StartArea)", function(state)
    autoFarmEnabled = state
    if state then startAutoFarm() end
end)

--// 2. AUTO COLLECT EGGS
local autoCollectEnabled = false
local function startAutoCollect()
    task.spawn(function()
        while autoCollectEnabled do
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local myPos = char.HumanoidRootPart.Position
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and (obj.Name:lower():find("egg") or obj.Name:lower():find("huevo")) then
                        local dist = (obj.Position - myPos).Magnitude
                        if dist < 15 then
                            char.HumanoidRootPart.CFrame = CFrame.new(obj.Position + Vector3.new(0, 3, 0))
                            task.wait(0.1)
                        end
                    end
                end
            end
            task.wait(0.5)
        end
    end)
end

createToggle("Auto-Collect Eggs", function(state)
    autoCollectEnabled = state
    if state then startAutoCollect() end
end)

--// 3. SPEED HACK
local speedEnabled = false
local defaultSpeed = 16
local function applySpeed()
    task.spawn(function()
        while speedEnabled do
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.WalkSpeed = 100
            end
            task.wait(0.2)
        end
        -- Restaurar al desactivar
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = defaultSpeed
        end
    end)
end

createToggle("Speed Hack", function(state)
    speedEnabled = state
    if state then applySpeed() end
end)

--// 4. AUTO HATCH EGGS
local autoHatchEnabled = false
local function startAutoHatch()
    task.spawn(function()
        while autoHatchEnabled do
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                -- Buscar objetos que parezcan incubadoras o zonas de hatch
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("BasePart") then
                        local name = obj.Name:lower()
                        if name:find("hatch") or name:find("incubat") or name:find("incubad") then
                            char.HumanoidRootPart.CFrame = CFrame.new(obj.Position + Vector3.new(0, 4, 0))
                            task.wait(0.3)
                        end
                    end
                end
            end
            task.wait(1)
        end
    end)
end

createToggle("Auto Hatch Eggs", function(state)
    autoHatchEnabled = state
    if state then startAutoHatch() end
end)

--==============================================================
--// ACTIVAR PESTAÑA INFO POR DEFECTO
--==============================================================
tabs["Info"].Button.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
tabs["Info"].Button.TextColor3 = Color3.fromRGB(255, 255, 255)
tabs["Info"].Page.Visible = true
activeTab = "Info"

--==============================================================
--// NOTIFICACIÓN
--==============================================================
pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "JoseAngel_Blox Steal An Egg",
        Text = "Script cargado correctamente. Versión 1.1",
        Duration = 5,
    })
end)

print("[JoseAngel_Blox Steal An Egg] Script cargado - Versión 1.1")--==============================================================
-- SCRIPT: JoseAngel_Blox Steal An Egg
-- CREADO POR: JoseAngel_Blox
-- VERSIÓN: 1.1
-- FECHA: 09/09/2026
--==============================================================

--// SERVICIOS
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

--// ELIMINAR GUI ANTERIOR SI EXISTE
local oldGui = PlayerGui:FindFirstChild("JoseAngel_Blox_StealAnEgg")
if oldGui then oldGui:Destroy() end

--==============================================================
--// CREAR INTERFAZ PRINCIPAL
--==============================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Blox_StealAnEgg"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

--// VENTANA PRINCIPAL (cuadrada con esquinas redondeadas)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 550, 0, 400)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(0, 150, 255)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

--==============================================================
--// TÍTULO CON LETRAS AZULES EN MOVIMIENTO
--==============================================================
local TitleFrame = Instance.new("Frame")
TitleFrame.Size = UDim2.new(1, 0, 0, 60)
TitleFrame.Position = UDim2.new(0, 0, 0, 0)
TitleFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
TitleFrame.BorderSizePixel = 0
TitleFrame.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 16)
TitleCorner.Parent = TitleFrame

-- Parche para que las esquinas inferiores del título no queden redondeadas
local TitlePatch = Instance.new("Frame")
TitlePatch.Size = UDim2.new(1, 0, 0, 16)
TitlePatch.Position = UDim2.new(0, 0, 1, -16)
TitlePatch.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
TitlePatch.BorderSizePixel = 0
TitlePatch.Parent = TitleFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, 0, 1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "JoseAngel_Blox Steal An Egg"
TitleLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextScaled = true
TitleLabel.TextSize = 28
TitleLabel.Parent = TitleFrame

local TitlePadding = Instance.new("UIPadding")
TitlePadding.PaddingLeft = UDim.new(0, 10)
TitlePadding.PaddingRight = UDim.new(0, 10)
TitlePadding.Parent = TitleLabel

-- Efecto de texto en movimiento (degradado azul animado)
local titleText = "JoseAngel_Blox Steal An Egg"
local hueOffset = 0
task.spawn(function()
    while ScreenGui.Parent do
        hueOffset = (hueOffset + 0.005) % 1
        local color = Color3.fromHSV(hueOffset * 0.15 + 0.55, 1, 1) -- Rango azul
        TitleLabel.TextColor3 = color
        task.wait(0.05)
    end
end)

-- Efecto adicional: el texto se desplaza ligeramente
task.spawn(function()
    while ScreenGui.Parent do
        for i = 1, 30 do
            TitleLabel.Position = UDim2.new(0, math.sin(i * 0.2) * 3, 0, 0)
            task.wait(0.03)
        end
    end
end)

--==============================================================
--// SUBTÍTULO: "Creado por JoseAngel_Blox" (transparente)
--==============================================================
local SubtitleLabel = Instance.new("TextLabel")
SubtitleLabel.Name = "SubtitleLabel"
SubtitleLabel.Size = UDim2.new(1, 0, 0, 20)
SubtitleLabel.Position = UDim2.new(0, 0, 0, 55)
SubtitleLabel.BackgroundTransparency = 1
SubtitleLabel.Text = "Creado por JoseAngel_Blox"
SubtitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SubtitleLabel.TextTransparency = 0.5 -- Transparente
SubtitleLabel.Font = Enum.Font.Gotham
SubtitleLabel.TextSize = 14
SubtitleLabel.Parent = MainFrame

--==============================================================
--// PANEL IZQUIERDO (PESTAÑAS)
--==============================================================
local TabPanel = Instance.new("Frame")
TabPanel.Name = "TabPanel"
TabPanel.Size = UDim2.new(0, 140, 1, -110)
TabPanel.Position = UDim2.new(0, 10, 0, 85)
TabPanel.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
TabPanel.BorderSizePixel = 0
TabPanel.Parent = MainFrame

local TabPanelCorner = Instance.new("UICorner")
TabPanelCorner.CornerRadius = UDim.new(0, 10)
TabPanelCorner.Parent = TabPanel

local TabLayout = Instance.new("UIListLayout")
TabLayout.Padding = UDim.new(0, 6)
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Parent = TabPanel

local TabPadding = Instance.new("UIPadding")
TabPadding.PaddingTop = UDim.new(0, 8)
TabPadding.PaddingLeft = UDim.new(0, 6)
TabPadding.PaddingRight = UDim.new(0, 6)
TabPadding.Parent = TabPanel

--==============================================================
--// PANEL DERECHO (CONTENIDO)
--==============================================================
local ContentPanel = Instance.new("Frame")
ContentPanel.Name = "ContentPanel"
ContentPanel.Size = UDim2.new(1, -170, 1, -110)
ContentPanel.Position = UDim2.new(0, 160, 0, 85)
ContentPanel.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
ContentPanel.BorderSizePixel = 0
ContentPanel.Parent = MainFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 10)
ContentCorner.Parent = ContentPanel

local ContentPadding = Instance.new("UIPadding")
ContentPadding.PaddingTop = UDim.new(0, 10)
ContentPadding.PaddingLeft = UDim.new(0, 10)
ContentPadding.PaddingRight = UDim.new(0, 10)
ContentPadding.PaddingBottom = UDim.new(0, 10)
ContentPadding.Parent = ContentPanel

--==============================================================
--// SISTEMA DE PESTAÑAS
--==============================================================
local tabs = {}
local activeTab = nil

local function createTab(name)
    local button = Instance.new("TextButton")
    button.Name = name .. "Tab"
    button.Size = UDim2.new(1, 0, 0, 38)
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    button.Text = name
    button.TextColor3 = Color3.fromRGB(200, 200, 200)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 14
    button.BorderSizePixel = 0
    button.Parent = TabPanel

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button

    -- Página de contenido
    local page = Instance.new("Frame")
    page.Name = name .. "Page"
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Parent = ContentPanel

    tabs[name] = { Button = button, Page = page }

    button.MouseButton1Click:Connect(function()
        for _, tab in pairs(tabs) do
            tab.Page.Visible = false
            tab.Button.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
            tab.Button.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
        page.Visible = true
        button.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        activeTab = name
    end)

    return page
end

--==============================================================
--// PESTAÑA 1: INFO
--==============================================================
local infoPage = createTab("Info")

local infoScroll = Instance.new("ScrollingFrame")
infoScroll.Size = UDim2.new(1, 0, 1, 0)
infoScroll.BackgroundTransparency = 1
infoScroll.BorderSizePixel = 0
infoScroll.ScrollBarThickness = 5
infoScroll.CanvasSize = UDim2.new(0, 0, 0, 400)
infoScroll.Parent = infoPage

local infoLayout = Instance.new("UIListLayout")
infoLayout.Padding = UDim.new(0, 6)
infoLayout.SortOrder = Enum.SortOrder.LayoutOrder
infoLayout.Parent = infoScroll

local function createInfoLabel(text, color, size)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, size or 22)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = color or Color3.fromRGB(220, 220, 220)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextWrapped = true
    label.Parent = infoScroll
    return label
end

createInfoLabel("Nombre del Creador: JoseAngel_Blox", Color3.fromRGB(0, 170, 255), 24)
createInfoLabel("Fecha de lanzamiento: 09/09/2026", Color3.fromRGB(220, 220, 220))
createInfoLabel("Versión: 1.1", Color3.fromRGB(220, 220, 220))
createInfoLabel("", Color3.fromRGB(220, 220, 220), 10)
createInfoLabel("UPDATE:", Color3.fromRGB(0, 255, 150), 22)
createInfoLabel(
    "Bienvenido o bienvenida a mi Script, este script es nuevo para este juego llamado roba un huevo y es uno de los mejores scripts básico. Si eres nuevo o nueva usando Delta, este es el mejor script fácil para este juego, así que espero que disfrutes del script. Atentamente, JoseAngel_Blox.",
    Color3.fromRGB(200, 200, 200),
    80
)

--==============================================================
--// PESTAÑA 2: MAIN
--==============================================================
local mainPage = createTab("Main")

local mainScroll = Instance.new("ScrollingFrame")
mainScroll.Size = UDim2.new(1, 0, 1, 0)
mainScroll.BackgroundTransparency = 1
mainScroll.BorderSizePixel = 0
mainScroll.ScrollBarThickness = 5
mainScroll.CanvasSize = UDim2.new(0, 0, 0, 400)
mainScroll.Parent = mainPage

local mainLayout = Instance.new("UIListLayout")
mainLayout.Padding = UDim.new(0, 8)
mainLayout.SortOrder = Enum.SortOrder.LayoutOrder
mainLayout.Parent = mainScroll

-- Función para crear botones de toggle
local function createToggle(text, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 40)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    frame.BorderSizePixel = 0
    frame.Parent = mainScroll

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -70, 1, 0)
    label.Position = UDim2.new(0, 12, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(230, 230, 230)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 50, 0, 26)
    toggleBtn.Position = UDim2.new(1, -60, 0.5, -13)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    toggleBtn.Text = "OFF"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.TextSize = 12
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Parent = frame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = toggleBtn

    local state = false
    toggleBtn.MouseButton1Click:Connect(function()
        state = not state
        toggleBtn.Text = state and "ON" or "OFF"
        toggleBtn.BackgroundColor3 = state and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(60, 60, 80)
        callback(state)
    end)

    return frame
end

--==============================================================
--// FUNCIONES DEL SCRIPT
--==============================================================

--// 1. AUTO FARM (teletransportar a StartArea)
local autoFarmEnabled = false
local function startAutoFarm()
    task.spawn(function()
        while autoFarmEnabled do
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local startArea = workspace:FindFirstChild("StartArea")
                    or workspace:FindFirstChild("SpawnLocation")
                    or workspace:FindFirstChild("Start")
                if startArea then
                    char.HumanoidRootPart.CFrame = CFrame.new(startArea.Position + Vector3.new(0, 5, 0))
                end
            end
            task.wait(1)
        end
    end)
end

createToggle("Auto Farm (ir a StartArea)", function(state)
    autoFarmEnabled = state
    if state then startAutoFarm() end
end)

--// 2. AUTO COLLECT EGGS
local autoCollectEnabled = false
local function startAutoCollect()
    task.spawn(function()
        while autoCollectEnabled do
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local myPos = char.HumanoidRootPart.Position
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("BasePart") and (obj.Name:lower():find("egg") or obj.Name:lower():find("huevo")) then
                        local dist = (obj.Position - myPos).Magnitude
                        if dist < 15 then
                            char.HumanoidRootPart.CFrame = CFrame.new(obj.Position + Vector3.new(0, 3, 0))
                            task.wait(0.1)
                        end
                    end
                end
            end
            task.wait(0.5)
        end
    end)
end

createToggle("Auto-Collect Eggs", function(state)
    autoCollectEnabled = state
    if state then startAutoCollect() end
end)

--// 3. SPEED HACK
local speedEnabled = false
local defaultSpeed = 16
local function applySpeed()
    task.spawn(function()
        while speedEnabled do
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.WalkSpeed = 100
            end
            task.wait(0.2)
        end
        -- Restaurar al desactivar
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = defaultSpeed
        end
    end)
end

createToggle("Speed Hack", function(state)
    speedEnabled = state
    if state then applySpeed() end
end)

--// 4. AUTO HATCH EGGS
local autoHatchEnabled = false
local function startAutoHatch()
    task.spawn(function()
        while autoHatchEnabled do
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                -- Buscar objetos que parezcan incubadoras o zonas de hatch
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("BasePart") then
                        local name = obj.Name:lower()
                        if name:find("hatch") or name:find("incubat") or name:find("incubad") then
                            char.HumanoidRootPart.CFrame = CFrame.new(obj.Position + Vector3.new(0, 4, 0))
                            task.wait(0.3)
                        end
                    end
                end
            end
            task.wait(1)
        end
    end)
end

createToggle("Auto Hatch Eggs", function(state)
    autoHatchEnabled = state
    if state then startAutoHatch() end
end)

--==============================================================
--// ACTIVAR PESTAÑA INFO POR DEFECTO
--==============================================================
tabs["Info"].Button.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
tabs["Info"].Button.TextColor3 = Color3.fromRGB(255, 255, 255)
tabs["Info"].Page.Visible = true
activeTab = "Info"

--==============================================================
--// NOTIFICACIÓN
--==============================================================
pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "JoseAngel_Blox Steal An Egg",
        Text = "Script cargado correctamente. Versión 1.1",
        Duration = 5,
    })
end)

print("[JoseAngel_Blox Steal An Egg] Script cargado - Versión 1.1")
