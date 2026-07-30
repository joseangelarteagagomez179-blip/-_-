-- ==========================================
-- ╔══════════════════════════════════════════╗
-- ║   MANSION TYCOON HELPER v1.0            ║
-- ║   Creador: JoseAngel_Blox               ║
-- ║   Juego: Mansion Tycoon (ID: 12912731475)║
-- ╚══════════════════════════════════════════╝
-- ==========================================

-- ==========================================
-- 1. SERVICIOS Y CONFIGURACIÓN INICIAL
-- ==========================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local MarketplaceService = game:GetService("MarketplaceService")

local LocalPlayer = Players.LocalPlayer
local TARGET_PLACE_ID = 12912731475 -- Mansion Tycoon

-- Configuración del script (fácil de editar)
local CONFIG = {
    CreatorName = "JoseAngel_Blox",
    Version = "1.0",
    AutoCollect = false,
    AutoBuy = false,
    CollectRadius = 15,
    BuyDelay = 0.5,
    ThemeColor = Color3.fromRGB(0, 120, 255), -- Azul corporativo
}

-- ==========================================
-- 2. VERIFICACIÓN DE JUEGO (Game Check)
-- ==========================================
if game.PlaceId ~= TARGET_PLACE_ID then
    local currentGameName = "Desconocido"
    local success, info = pcall(function()
        return MarketplaceService:GetProductInfo(game.PlaceId)
    end)
    if success and info then
        currentGameName = info.Name
    end

    warn("⛔ [" .. CONFIG.CreatorName .. "] ALTO: Este script es EXCLUSIVO para Mansion Tycoon.")
    warn("🎮 Juego actual: " .. currentGameName .. " (ID: " .. game.PlaceId .. ")")
    warn("💡 Únete a Mansion Tycoon para usar este script.")
    return
end

print("✅ [" .. CONFIG.CreatorName .. "] Juego verificado. Cargando Mansion Tycoon Helper v" .. CONFIG.Version .. "...")

-- ==========================================
-- 3. DETECCIÓN DINÁMICA DEL TYCOON
-- ==========================================
local function getPlayerTycoon()
    -- Método 1: Carpeta directa con nombre del jugador
    local directTycoon = workspace:FindFirstChild(LocalPlayer.Name)
    if directTycoon then
        local ownerValue = directTycoon:FindFirstChild("Owner")
        if ownerValue and ownerValue.Value == LocalPlayer then
            return directTycoon
        end
    end

    -- Método 2: Buscar en carpetas contenedoras comunes
    local containers = {"Tycoons", "Bases", "Plots", "TycoonPlots"}
    for _, containerName in ipairs(containers) do
        local container = workspace:FindFirstChild(containerName)
        if container then
            local playerBase = container:FindFirstChild(LocalPlayer.Name)
            if playerBase then
                return playerBase
            end
        end
    end

    -- Método 3: Búsqueda profunda (fallback)
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ObjectValue") and obj.Name == "Owner" and obj.Value == LocalPlayer then
            return obj.Parent
        end
    end

    return nil
end

-- ==========================================
-- 4. SISTEMA DE NOTIFICACIONES
-- ==========================================
local function createNotification(title, text, duration)
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(0, 300, 0, 60)
    notif.Position = UDim2.new(1, -320, 0.5, 0)
    notif.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    notif.BorderSizePixel = 0
    notif.BackgroundTransparency = 0.1
    notif.Parent = LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild(CONFIG.CreatorName .. "_GUI") or LocalPlayer.PlayerGui

    local corner = Instance.new("UICorner", notif)
    corner.CornerRadius = UDim.new(0, 8)

    local stroke = Instance.new("UIStroke", notif)
    stroke.Color = CONFIG.ThemeColor
    stroke.Thickness = 2

    local titleLabel = Instance.new("TextLabel", notif)
    titleLabel.Size = UDim2.new(1, -20, 0, 25)
    titleLabel.Position = UDim2.new(0, 10, 0, 5)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "🔔 " .. title
    titleLabel.TextColor3 = CONFIG.ThemeColor
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 14
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local textLabel = Instance.new("TextLabel", notif)
    textLabel.Size = UDim2.new(1, -20, 0, 30)
    textLabel.Position = UDim2.new(0, 10, 0, 25)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.Font = Enum.Font.Gotham
    textLabel.TextSize = 12
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.TextWrapped = true

    -- Animación de entrada
    notif.Position = UDim2.new(1, 50, 0.5, 0)
    TweenService:Create(notif, TweenInfo.new(0.3), {Position = UDim2.new(1, -320, 0.5, 0)}):Play()

    task.delay(duration or 3, function()
        TweenService:Create(notif, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
        task.wait(0.3)
        notif:Destroy()
    end)
end

-- ==========================================
-- 5. CREACIÓN DE LA GUI PRINCIPAL
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = CONFIG.CreatorName .. "_GUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Frame principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 400)
MainFrame.Position = UDim2.new(0, 20, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local mainCorner = Instance.new("UICorner", MainFrame)
mainCorner.CornerRadius = UDim.new(0, 10)

local mainStroke = Instance.new("UIStroke", MainFrame)
mainStroke.Color = CONFIG.ThemeColor
mainStroke.Thickness = 2

-- Barra superior (Header)
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = CONFIG.ThemeColor
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local headerCorner = Instance.new("UICorner", Header)
headerCorner.CornerRadius = UDim.new(0, 10)

-- Título
local TitleLabel = Instance.new("TextLabel", Header)
TitleLabel.Size = UDim2.new(1, -60, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "🏠 Mansion Tycoon\n👤 " .. CONFIG.CreatorName
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 14
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.TextYAlignment = Enum.TextYAlignment.Center

-- Botón de cerrar
local CloseButton = Instance.new("TextButton", Header)
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -45, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.Parent = Header

local closeCorner = Instance.new("UICorner", CloseButton)
closeCorner.CornerRadius = UDim.new(0, 8)

-- Contenedor de botones
local ButtonContainer = Instance.new("ScrollingFrame", MainFrame)
ButtonContainer.Size = UDim2.new(1, -20, 1, -70)
ButtonContainer.Position = UDim2.new(0, 10, 0, 60)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.ScrollBarThickness = 4
ButtonContainer.ScrollBarImageColor3 = CONFIG.ThemeColor
ButtonContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
ButtonContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y

local listLayout = Instance.new("UIListLayout", ButtonContainer)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 10)

-- ==========================================
-- 6. FUNCIÓN PARA CREAR BOTONES TOGGLE
-- ==========================================
local function createToggleButton(name, description, defaultState, callback)
    local buttonFrame = Instance.new("Frame", ButtonContainer)
    buttonFrame.Size = UDim2.new(1, -10, 0, 70)
    buttonFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    buttonFrame.BorderSizePixel = 0

    local frameCorner = Instance.new("UICorner", buttonFrame)
    frameCorner.CornerRadius = UDim.new(0, 8)

    local nameLabel = Instance.new("TextLabel", buttonFrame)
    nameLabel.Size = UDim2.new(1, -100, 0, 30)
    nameLabel.Position = UDim2.new(0, 10, 0, 5)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = name
    nameLabel.TextColor3 = Color3.new(1, 1, 1)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 15
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left

    local descLabel = Instance.new("TextLabel", buttonFrame)
    descLabel.Size = UDim2.new(1, -100, 0, 30)
    descLabel.Position = UDim2.new(0, 10, 0, 35)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = description
    descLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextSize = 11
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.TextWrapped = true

    local toggleButton = Instance.new("TextButton", buttonFrame)
    toggleButton.Size = UDim2.new(0, 80, 0, 35)
    toggleButton.Position = UDim2.new(1, -90, 0.5, -17)
    toggleButton.BackgroundColor3 = defaultState and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(80, 80, 80)
    toggleButton.Text = defaultState and "ON" or "OFF"
    toggleButton.TextColor3 = Color3.new(1, 1, 1)
    toggleButton.Font = Enum.Font.GothamBold
    toggleButton.TextSize = 14

    local toggleCorner = Instance.new("UICorner", toggleButton)
    toggleCorner.CornerRadius = UDim.new(0, 6)

    local currentState = defaultState

    toggleButton.MouseButton1Click:Connect(function()
        currentState = not currentState
        toggleButton.Text = currentState and "ON" or "OFF"
        TweenService:Create(toggleButton, TweenInfo.new(0.2), {
            BackgroundColor3 = currentState and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(80, 80, 80)
        }):Play()
        callback(currentState)
        createNotification(name, currentState and "Activado" or "Desactivado", 2)
    end)

    return toggleButton
end

-- ==========================================
-- 7. FUNCIONES PRINCIPALES DEL SCRIPT
-- ==========================================

-- AUTO-COLLECT
local function autoCollectLoop()
    task.spawn(function()
        while CONFIG.AutoCollect do
            local myTycoon = getPlayerTycoon()
            local character = LocalPlayer.Character
            if myTycoon and character and character:FindFirstChild("HumanoidRootPart") then
                local root = character.HumanoidRootPart
                
                -- Buscar colectores de dinero en el tycoon del jugador
                for _, obj in ipairs(myTycoon:GetDescendants()) do
                    if obj:IsA("BasePart") and (obj.Name:lower():find("collect") or obj.Name:lower():find("drop") or obj.Name:lower():find("money")) then
                        if CONFIG.AutoCollect then
                            local distance = (root.Position - obj.Position).Magnitude
                            if distance < CONFIG.CollectRadius then
                                firetouchinterest(root, obj, 0)
                                task.wait(0.05)
                                firetouchinterest(root, obj, 1)
                            end
                        end
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end

-- AUTO-BUY
local function autoBuyLoop()
    task.spawn(function()
        while CONFIG.AutoBuy do
            local myTycoon = getPlayerTycoon()
            if myTycoon then
                -- Buscar botones de compra en el tycoon
                for _, obj in ipairs(myTycoon:GetDescendants()) do
                    if obj:IsA("ClickDetector") or (obj:IsA("BasePart") and obj.Name:lower():find("button")) then
                        if CONFIG.AutoBuy then
                            local character = LocalPlayer.Character
                            if character and character:FindFirstChild("HumanoidRootPart") then
                                local root = character.HumanoidRootPart
                                local distance = (root.Position - obj.Position).Magnitude
                                if distance < 10 then
                                    if obj:IsA("ClickDetector") then
                                        fireclickdetector(obj)
                                    else
                                        firetouchinterest(root, obj, 0)
                                        task.wait(0.05)
                                        firetouchinterest(root, obj, 1)
                                    end
                                    task.wait(CONFIG.BuyDelay)
                                end
                            end
                        end
                    end
                end
            end
            task.wait(1)
        end
    end)
end

-- ==========================================
-- 8. CREAR BOTONES EN LA GUI
-- ==========================================
createToggleButton("Auto-Collect", "Recolecta dinero automáticamente", false, function(state)
    CONFIG.AutoCollect = state
    if state then autoCollectLoop() end
end)

createToggleButton("Auto-Buy", "Compra mejoras automáticamente", false, function(state)
    CONFIG.AutoBuy = state
    if state then autoBuyLoop() end
end)

-- ==========================================
-- 9. FUNCIONALIDAD DE LA GUI
-- ==========================================

-- Hacer la GUI arrastrable
local dragging = false
local dragInput, mousePos, framePos

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        mousePos = input.Position
        framePos = MainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - mousePos
        MainFrame.Position = UDim2.new(
            framePos.X.Scale,
            framePos.X.Offset + delta.X,
            framePos.Y.Scale,
            framePos.Y.Offset + delta.Y
        )
    end
end)

-- Botón de cerrar
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- ==========================================
-- 10. MENSAJE FINAL Y DETECCIÓN DE TYCOON
-- ==========================================
task.wait(1)
local myTycoon = getPlayerTycoon()
if myTycoon then
    createNotification("¡Listo!", "Tycoon detectado: " .. myTycoon.Name, 3)
    print("✅ [" .. CONFIG.CreatorName .. "] Tycoon del jugador detectado: " .. myTycoon.Name)
else
    createNotification("Aviso", "Reclama tu Tycoon primero", 4)
    warn("⚠️ [" .. CONFIG.CreatorName .. "] No se detectó un Tycoon reclamado. Pisa el botón de 'Claim' en el juego.")
end

createNotification("Script Cargado", CONFIG.CreatorName .. " v" .. CONFIG.Version, 3)
print("==========================================")
print("✅ [" .. CONFIG.CreatorName .. "] Mansion Tycoon Helper v" .. CONFIG.Version .. " cargado exitosamente")
print("==========================================")
