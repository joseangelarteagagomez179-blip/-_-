--==============================================================
-- SCRIPT: JoseAngel_Blox Steal An Huevo
-- CREADO POR: JoseAngel_Blox
-- VERSIÓN: 1.2
-- FECHA: 09/09/2026
--==============================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

--// ELIMINAR GUI ANTERIOR
local oldGui = PlayerGui:FindFirstChild("JoseAngel_Blox_StealAnEgg")
if oldGui then oldGui:Destroy() end

--==============================================================
--// INTERFAZ PRINCIPAL (MÁS PEQUEÑA)
--==============================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Blox_StealAnEgg"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- VENTANA MÁS PEQUEÑA (380x260)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 380, 0, 260)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -130)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(0, 150, 255)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

--==============================================================
--// TÍTULO AZUL EN MOVIMIENTO
--==============================================================
local TitleFrame = Instance.new("Frame")
TitleFrame.Size = UDim2.new(1, 0, 0, 42)
TitleFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
TitleFrame.BorderSizePixel = 0
TitleFrame.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleFrame

local TitlePatch = Instance.new("Frame")
TitlePatch.Size = UDim2.new(1, 0, 0, 12)
TitlePatch.Position = UDim2.new(0, 0, 1, -12)
TitlePatch.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
TitlePatch.BorderSizePixel = 0
TitlePatch.Parent = TitleFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "JoseAngel_Blox Steal An Huevo"
TitleLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextScaled = true
TitleLabel.TextSize = 18
TitleLabel.Parent = TitleFrame

local TitlePadding = Instance.new("UIPadding")
TitlePadding.PaddingLeft = UDim.new(0, 8)
TitlePadding.PaddingRight = UDim.new(0, 8)
TitlePadding.Parent = TitleLabel

-- Animación del título
task.spawn(function()
    local hueOffset = 0
    while ScreenGui.Parent do
        hueOffset = (hueOffset + 0.005) % 1
        TitleLabel.TextColor3 = Color3.fromHSV(hueOffset * 0.15 + 0.55, 1, 1)
        TitleLabel.Position = UDim2.new(0, math.sin(tick() * 2) * 2, 0, 0)
        task.wait(0.05)
    end
end)

-- Subtítulo transparente
local SubtitleLabel = Instance.new("TextLabel")
SubtitleLabel.Size = UDim2.new(1, 0, 0, 14)
SubtitleLabel.Position = UDim2.new(0, 0, 0, 40)
SubtitleLabel.BackgroundTransparency = 1
SubtitleLabel.Text = "Creado por JoseAngel_Blox"
SubtitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SubtitleLabel.TextTransparency = 0.5
SubtitleLabel.Font = Enum.Font.Gotham
SubtitleLabel.TextSize = 11
SubtitleLabel.Parent = MainFrame

--==============================================================
--// PANEL IZQUIERDO (PESTAÑAS)
--==============================================================
local TabPanel = Instance.new("Frame")
TabPanel.Size = UDim2.new(0, 100, 1, -75)
TabPanel.Position = UDim2.new(0, 8, 0, 58)
TabPanel.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
TabPanel.BorderSizePixel = 0
TabPanel.Parent = MainFrame

local TabPanelCorner = Instance.new("UICorner")
TabPanelCorner.CornerRadius = UDim.new(0, 8)
TabPanelCorner.Parent = TabPanel

local TabLayout = Instance.new("UIListLayout")
TabLayout.Padding = UDim.new(0, 4)
TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabLayout.Parent = TabPanel

local TabPadding = Instance.new("UIPadding")
TabPadding.PaddingTop = UDim.new(0, 6)
TabPadding.PaddingLeft = UDim.new(0, 4)
TabPadding.PaddingRight = UDim.new(0, 4)
TabPadding.Parent = TabPanel

--==============================================================
--// PANEL DERECHO (CONTENIDO)
--==============================================================
local ContentPanel = Instance.new("Frame")
ContentPanel.Size = UDim2.new(1, -120, 1, -75)
ContentPanel.Position = UDim2.new(0, 112, 0, 58)
ContentPanel.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
ContentPanel.BorderSizePixel = 0
ContentPanel.Parent = MainFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 8)
ContentCorner.Parent = ContentPanel

local ContentPadding = Instance.new("UIPadding")
ContentPadding.PaddingTop = UDim.new(0, 6)
ContentPadding.PaddingLeft = UDim.new(0, 6)
ContentPadding.PaddingRight = UDim.new(0, 6)
ContentPadding.PaddingBottom = UDim.new(0, 6)
ContentPadding.Parent = ContentPanel

--==============================================================
--// SISTEMA DE PESTAÑAS
--==============================================================
local tabs = {}

local function createTab(name)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 30)
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    button.Text = name
    button.TextColor3 = Color3.fromRGB(200, 200, 200)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 12
    button.BorderSizePixel = 0
    button.Parent = TabPanel

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button

    local page = Instance.new("Frame")
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
    end)

    return page
end

--==============================================================
--// PESTAÑA INFO
--==============================================================
local infoPage = createTab("Info")

local infoScroll = Instance.new("ScrollingFrame")
infoScroll.Size = UDim2.new(1, 0, 1, 0)
infoScroll.BackgroundTransparency = 1
infoScroll.BorderSizePixel = 0
infoScroll.ScrollBarThickness = 4
infoScroll.CanvasSize = UDim2.new(0, 0, 0, 300)
infoScroll.Parent = infoPage

local infoLayout = Instance.new("UIListLayout")
infoLayout.Padding = UDim.new(0, 4)
infoLayout.SortOrder = Enum.SortOrder.LayoutOrder
infoLayout.Parent = infoScroll

local function createInfoLabel(text, color, size)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -8, 0, size or 18)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = color or Color3.fromRGB(220, 220, 220)
    label.Font = Enum.Font.Gotham
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextWrapped = true
    label.Parent = infoScroll
    return label
end

createInfoLabel("Nombre: JoseAngel_Blox", Color3.fromRGB(0, 170, 255), 18)
createInfoLabel("Fecha: 09/09/2026", Color3.fromRGB(220, 220, 220))
createInfoLabel("Versión: 1.2", Color3.fromRGB(220, 220, 220))
createInfoLabel("", Color3.fromRGB(220, 220, 220), 6)
createInfoLabel("UPDATE:", Color3.fromRGB(0, 255, 150), 16)
createInfoLabel(
    "Bienvenido a mi Script. Este script es nuevo para el juego roba un huevo. Si eres nuevo usando Delta, este es el mejor script. ¡Disfrútalo! - JoseAngel_Blox",
    Color3.fromRGB(200, 200, 200),
    70
)

--==============================================================
--// PESTAÑA MAIN
--==============================================================
local mainPage = createTab("Main")

local mainScroll = Instance.new("ScrollingFrame")
mainScroll.Size = UDim2.new(1, 0, 1, 0)
mainScroll.BackgroundTransparency = 1
mainScroll.BorderSizePixel = 0
mainScroll.ScrollBarThickness = 4
mainScroll.CanvasSize = UDim2.new(0, 0, 0, 320)
mainScroll.Parent = mainPage

local mainLayout = Instance.new("UIListLayout")
mainLayout.Padding = UDim.new(0, 5)
mainLayout.SortOrder = Enum.SortOrder.LayoutOrder
mainLayout.Parent = mainScroll

--==============================================================
--// FUNCIÓN PARA CREAR TOGGLES
--==============================================================
local function createToggle(text, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -6, 0, 32)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    frame.BorderSizePixel = 0
    frame.Parent = mainScroll

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -55, 1, 0)
    label.Position = UDim2.new(0, 8, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(230, 230, 230)
    label.Font = Enum.Font.Gotham
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 42, 0, 20)
    toggleBtn.Position = UDim2.new(1, -48, 0.5, -10)
    toggleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    toggleBtn.Text = "OFF"
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.TextSize = 10
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Parent = frame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 5)
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
--// UTILIDADES
--==============================================================
local function getChar()
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local function getHRP()
    local char = LocalPlayer.Character
    if char then
        return char:FindFirstChild("HumanoidRootPart")
    end
    return nil
end

local function getHumanoid()
    local char = LocalPlayer.Character
    if char then
        return char:FindFirstChildOfClass("Humanoid")
    end
    return nil
end

--==============================================================
--// 1. AUTO FARM - CORRER A ZONA SEGURA (NO TELETRANSPORTAR)
--==============================================================
local autoFarmEnabled = false
local autoFarmConn = nil

local function startAutoFarm()
    if autoFarmConn then autoFarmConn:Disconnect() end
    autoFarmConn = RunService.Heartbeat:Connect(function()
        if not autoFarmEnabled then return end

        local hrp = getHRP()
        local humanoid = getHumanoid()
        if not hrp or not humanoid then return end

        -- Buscar zona segura / StartArea
        local target = nil
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") or obj:IsA("SpawnLocation") then
                local n = obj.Name:lower()
                if n:find("startarea") or n:find("safe") or n:find("segura") or n:find("spawn") then
                    target = obj
                    break
                end
            end
        end

        if target then
            local direction = (target.Position - hrp.Position)
            local distance = direction.Magnitude

            -- Si ya estamos cerca, no hacer nada
            if distance > 8 then
                -- Velocidad forzada alta
                humanoid.WalkSpeed = 120
                -- Mover al personaje hacia el objetivo
                local moveDir = direction.Unit
                humanoid:Move(moveDir, false)
                -- Mirar hacia el objetivo
                hrp.CFrame = CFrame.new(hrp.Position, Vector3.new(target.Position.X, hrp.Position.Y, target.Position.Z))
            else
                humanoid:Move(Vector3.new(0, 0, 0), false)
            end
        else
            -- Si no encuentra StartArea, ir al spawn general
            local spawn = workspace:FindFirstChildOfClass("SpawnLocation")
            if spawn then
                local direction = (spawn.Position - hrp.Position)
                if direction.Magnitude > 8 then
                    humanoid.WalkSpeed = 120
                    humanoid:Move(direction.Unit, false)
                end
            end
        end
    end)
end

createToggle("Auto Farm (correr a StartArea)", function(state)
    autoFarmEnabled = state
    if state then
        startAutoFarm()
    else
        if autoFarmConn then autoFarmConn:Disconnect(); autoFarmConn = nil end
        local h = getHumanoid()
        if h then h.WalkSpeed = 16 end
    end
end)

--==============================================================
--// 2. AUTO-COLLECT HUEVOS (SIN TELETRANSPORTAR)
--==============================================================
local autoCollectEnabled = false
local autoCollectConn = nil

local function startAutoCollect()
    if autoCollectConn then autoCollectConn:Disconnect() end
    autoCollectConn = RunService.Heartbeat:Connect(function()
        if not autoCollectEnabled then return end

        local hrp = getHRP()
        local humanoid = getHumanoid()
        if not hrp or not humanoid then return end

        -- Buscar huevos reales cercanos (no caminadoras)
        local closestEgg = nil
        local closestDist = 60 -- radio de búsqueda

        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") then
                local n = obj.Name:lower()
                -- Excluir caminadoras/treadmills
                if not n:find("treadmill") and not n:find("caminadora") then
                    if n:find("egg") or n:find("huevo") or n:find("eggzone") then
                        local dist = (obj.Position - hrp.Position).Magnitude
                        if dist < closestDist then
                            closestDist = dist
                            closestEgg = obj
                        end
                    end
                end
            end
        end

        if closestEgg then
            local direction = (closestEgg.Position - hrp.Position)
            if direction.Magnitude > 4 then
                humanoid.WalkSpeed = 100
                humanoid:Move(direction.Unit, false)
            else
                -- Estamos encima, intentar recoger con ProximityPrompt
                local prompt = closestEgg:FindFirstChildOfClass("ProximityPrompt")
                if prompt then
                    pcall(function() fireproximityprompt(prompt) end)
                end
            end
        end
    end)
end

createToggle("Auto-Collect Huevos", function(state)
    autoCollectEnabled = state
    if state then
        startAutoCollect()
    else
        if autoCollectConn then autoCollectConn:Disconnect(); autoCollectConn = nil end
    end
end)

--==============================================================
--// 3. AUTO TREADMILL (CAMINADORA)
--==============================================================
local autoTreadmillEnabled = false
local autoTreadmillConn = nil

local function startAutoTreadmill()
    if autoTreadmillConn then autoTreadmillConn:Disconnect() end
    autoTreadmillConn = RunService.Heartbeat:Connect(function()
        if not autoTreadmillEnabled then return end

        local hrp = getHRP()
        local humanoid = getHumanoid()
        if not hrp or not humanoid then return end

        -- Buscar caminadora
        local treadmill = nil
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") then
                local n = obj.Name:lower()
                if n:find("treadmill") or n:find("caminadora") or n:find("walk") then
                    treadmill = obj
                    break
                end
            end
        end

        if treadmill then
            local direction = (treadmill.Position - hrp.Position)
            if direction.Magnitude > 4 then
                humanoid.WalkSpeed = 100
                humanoid:Move(direction.Unit, false)
            else
                -- Quedarse quieto sobre la caminadora
                humanoid:Move(Vector3.new(0, 0, 0), false)
                -- Buscar ProximityPrompt para activarla
                local prompt = treadmill:FindFirstChildOfClass("ProximityPrompt")
                if prompt then
                    pcall(function() fireproximityprompt(prompt) end)
                end
            end
        end
    end)
end

createToggle("Auto Treadmill", function(state)
    autoTreadmillEnabled = state
    if state then
        startAutoTreadmill()
    else
        if autoTreadmillConn then autoTreadmillConn:Disconnect(); autoTreadmillConn = nil end
    end
end)

--==============================================================
--// 4. SPEED HACK (CORREGIDO)
--==============================================================
local speedEnabled = false
local speedValue = 100
local speedConn = nil

local function startSpeedHack()
    if speedConn then speedConn:Disconnect() end
    speedConn = RunService.Heartbeat:Connect(function()
        if not speedEnabled then return end
        local humanoid = getHumanoid()
        if humanoid then
            humanoid.WalkSpeed = speedValue
        end
    end)
end

createToggle("Speed Hack", function(state)
    speedEnabled = state
    if state then
        startSpeedHack()
    else
        if speedConn then speedConn:Disconnect(); speedConn = nil end
        local h = getHumanoid()
        if h then h.WalkSpeed = 16 end
    end
end)

--==============================================================
--// 5. AUTO HATCH HUEVOS
--==============================================================
local autoHatchEnabled = false
local autoHatchConn = nil

local function startAutoHatch()
    if autoHatchConn then autoHatchConn:Disconnect() end
    autoHatchConn = RunService.Heartbeat:Connect(function()
        if not autoHatchEnabled then return end

        local hrp = getHRP()
        local humanoid = getHumanoid()
        if not hrp or not humanoid then return end

        -- Buscar zonas de incubación/hatch
        local hatchZone = nil
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") then
                local n = obj.Name:lower()
                if n:find("hatch") or n:find("incubat") or n:find("incubad") or n:find("eclosion") then
                    hatchZone = obj
                    break
                end
            end
        end

        if hatchZone then
            local direction = (hatchZone.Position - hrp.Position)
            if direction.Magnitude > 4 then
                humanoid.WalkSpeed = 100
                humanoid:Move(direction.Unit, false)
            else
                humanoid:Move(Vector3.new(0, 0, 0), false)
                -- Activar hatch
                local prompt = hatchZone:FindFirstChildOfClass("ProximityPrompt")
                if prompt then
                    pcall(function() fireproximityprompt(prompt) end)
                end
                -- También buscar botones de hatch dentro
                for _, child in pairs(hatchZone:GetChildren()) do
                    if child:IsA("ProximityPrompt") then
                        pcall(function() fireproximityprompt(child) end)
                    end
                end
            end
        end
    end)
end

createToggle("Auto Hatch Huevos", function(state)
    autoHatchEnabled = state
    if state then
        startAutoHatch()
    else
        if autoHatchConn then autoHatchConn:Disconnect(); autoHatchConn = nil end
    end
end)

--==============================================================
--// ACTIVAR PESTAÑA INFO
--==============================================================
tabs["Info"].Button.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
tabs["Info"].Button.TextColor3 = Color3.fromRGB(255, 255, 255)
tabs["Info"].Page.Visible = true

--// NOTIFICACIÓN
pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "JoseAngel_Blox Steal An Huevo",
        Text = "Versión 1.2 cargada correctamente",
        Duration = 5,
    })
end)

print("[JoseAngel_Blox] Script v1.2 cargado")
