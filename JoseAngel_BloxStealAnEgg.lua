-- ╔══════════════════════════════════════════════════════════════╗
-- ║               🥚 JOSEANGEL_BLOX — STEAL AN EGG v1.1          ║
-- ║           ✅ Animación de carga • Pestañas • Diseño Azul      ║
-- ╚══════════════════════════════════════════════════════════════╝

-- Servicios
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local character, rootPart, humanoid

-- Actualizar personaje
local function updateChar()
    character = LocalPlayer.Character
    if character then
        rootPart = character:FindFirstChild("HumanoidRootPart")
        humanoid = character:FindFirstChild("Humanoid")
    end
end
updateChar()
LocalPlayer.CharacterAdded:Connect(updateChar)

-- ════════════════ COLORES Y ESTILO ════════════════
local COLORS = {
    FondoPrincipal = Color3.fromHex("#001a33"),       -- Azul marino oscuro
    FondoSecundario = Color3.fromHex("#00264d"),       -- Azul marino medio
    Borde = Color3.fromHex("#0066cc"),                 -- Azul brillante
    TextoAzul = Color3.fromHex("#00ccff"),             -- Azul claro brillante
    ToggleActivo = Color3.fromHex("#0099ff"),          -- Azul encendido
    ToggleInactivo = Color3.fromHex("#003366"),        -- Azul apagado
    TransparenteTexto = Color3.fromHex("#99ccff"),      -- Azul transparente
    Blanco = Color3.fromHex("#ffffff")
}

local esquinasRedondeadas = UDim.new(0, 16)

-- ════════════════ ANIMACIÓN DE CARGA ════════════════
local CargaGui = Instance.new("ScreenGui")
CargaGui.Name = "JoseAngel_Blox_Carga"
CargaGui.Parent = PlayerGui
CargaGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local CargaFondo = Instance.new("Frame")
CargaFondo.Name = "CargaFondo"
CargaFondo.Size = UDim2.new(1, 0, 1, 0)
CargaFondo.BackgroundColor3 = COLORS.FondoPrincipal
CargaFondo.Parent = CargaGui

local CargaContenedor = Instance.new("Frame")
CargaContenedor.Size = UDim2.new(0, 400, 0, 150)
CargaContenedor.Position = UDim2.new(0.5, -200, 0.5, -75)
CargaContenedor.BackgroundTransparency = 1
CargaContenedor.Parent = CargaFondo

local TituloCarga = Instance.new("TextLabel")
TituloCarga.Size = UDim2.new(1, 0, 0, 50)
TituloCarga.BackgroundTransparency = 1
TituloCarga.Text = "Bienvenidos a Script JoseAngel_Blox"
TituloCarga.Font = Enum.Font.GothamBold
TituloCarga.TextSize = 28
TituloCarga.TextColor3 = COLORS.TextoAzul
TituloCarga.Parent = CargaContenedor

-- Efecto de movimiento en el título
local movimientoOffset = 0
RunService.RenderStepped:Connect(function(delta)
    movimientoOffset = movimientoOffset + delta * 5
    TituloCarga.TextTransparency = NumberSequence.new{0, 0.3 + math.sin(movimientoOffset) * 0.3, 0}
end)

local BarraFondo = Instance.new("Frame")
BarraFondo.Size = UDim2.new(1, 0, 0, 25)
BarraFondo.Position = UDim2.new(0, 0, 0, 80)
BarraFondo.BackgroundColor3 = COLORS.FondoSecundario
BarraFondo.BorderSizePixel = 2
BarraFondo.BorderColor3 = COLORS.Borde
BarraFondo.Parent = CargaContenedor
Instance.new("UICorner", BarraFondo).CornerRadius = esquinasRedondeadas

local BarraProgreso = Instance.new("Frame")
BarraProgreso.Size = UDim2.new(0, 0, 1, 0)
BarraProgreso.BackgroundColor3 = COLORS.ToggleActivo
BarraProgreso.Parent = BarraFondo
Instance.new("UICorner", BarraProgreso).CornerRadius = esquinasRedondeadas

local PorcentajeTxt = Instance.new("TextLabel")
PorcentajeTxt.Size = UDim2.new(1, 0, 0, 30)
PorcentajeTxt.Position = UDim2.new(0, 0, 0, 115)
PorcentajeTxt.BackgroundTransparency = 1
PorcentajeTxt.Text = "0%"
PorcentajeTxt.Font = Enum.Font.Gotham
PorcentajeTxt.TextSize = 20
PorcentajeTxt.TextColor3 = COLORS.Blanco
PorcentajeTxt.Parent = CargaContenedor

-- Animación de carga
task.spawn(function()
    for i = 1, 100 do
        task.wait(0.035)
        BarraProgreso.Size = UDim2.new(i / 100, 0, 1, 0)
        PorcentajeTxt.Text = tostring(i) .. "%"
        PorcentajeTxt.TextColor3 = Color3.fromHSV(i / 300, 0.8, 1)
    end
    task.wait(0.3)
    CargaGui:Destroy()
    MainFrame.Visible = true
end)

-- ════════════════ INTERFAZ PRINCIPAL ════════════════
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "JoseAngel_Blox_StealAnEgg_v1_1"
MainGui.Parent = PlayerGui
MainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Botón flotante
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Size = UDim2.new(0, 55, 0, 55)
ToggleBtn.Position = UDim2.new(0.02, 0, 0.5, -27)
ToggleBtn.BackgroundColor3 = COLORS.FondoPrincipal
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Text = "🥚"
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 30
ToggleBtn.TextColor3 = COLORS.TextoAzul
ToggleBtn.Parent = MainGui
Instance.new("UICorner", ToggleBtn).CornerRadius = esquinasRedondeadas

-- Ventana Principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 520, 0, 380)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -190)
MainFrame.BackgroundColor3 = COLORS.FondoPrincipal
MainFrame.BorderSizePixel = 3
MainFrame.BorderColor3 = COLORS.Borde
MainFrame.Visible = false
MainFrame.ClipsDescendants = true
MainFrame.Parent = MainGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 20)

-- ════════════════ TÍTULO CON EFECTO DE MOVIMIENTO ════════════════
local HeaderFrame = Instance.new("Frame")
HeaderFrame.Size = UDim2.new(1, 0, 0, 65)
HeaderFrame.BackgroundColor3 = COLORS.FondoSecundario
HeaderFrame.Parent = MainFrame
Instance.new("UICorner", HeaderFrame).CornerRadius = UDim.new(0, 20)

local TituloPrincipal = Instance.new("TextLabel")
TituloPrincipal.Size = UDim2.new(1, -20, 0, 35)
TituloPrincipal.Position = UDim2.new(0, 10, 0, 5)
TituloPrincipal.BackgroundTransparency = 1
TituloPrincipal.Text = "JoseAngel_Blox Steal An Egg"
TituloPrincipal.Font = Enum.Font.GothamBold
TituloPrincipal.TextSize = 24
TituloPrincipal.TextColor3 = COLORS.TextoAzul
TituloPrincipal.TextXAlignment = Enum.TextXAlignment.Center
TituloPrincipal.Parent = HeaderFrame

local SubTitulo = Instance.new("TextLabel")
SubTitulo.Size = UDim2.new(1, -20, 0, 20)
SubTitulo.Position = UDim2.new(0, 10, 0, 40)
SubTitulo.BackgroundTransparency = 1
SubTitulo.Text = "Creado por JoseAngel_Blox"
SubTitulo.Font = Enum.Font.Gotham
SubTitulo.TextSize = 14
SubTitulo.TextColor3 = COLORS.TransparenteTexto
SubTitulo.TextTransparency = 0.4
SubTitulo.TextXAlignment = Enum.TextXAlignment.Center
SubTitulo.Parent = HeaderFrame

-- Efecto de movimiento en el título principal
local efectoTiempo = 0
RunService.RenderStepped:Connect(function(delta)
    efectoTiempo = efectoTiempo + delta * 2
    local brillo = 0.6 + math.sin(efectoTiempo) * 0.4
    TituloPrincipal.TextColor3 = Color3.fromRGB(
        0, 
        math.floor(150 + brillo * 105), 
        math.floor(200 + brillo * 55)
    )
end)

-- ════════════════ PANEL DE PESTAÑAS (IZQUIERDA) ════════════════
local PanelPestanas = Instance.new("Frame")
PanelPestanas.Size = UDim2.new(0, 130, 1, -75)
PanelPestanas.Position = UDim2.new(0, 10, 0, 70)
PanelPestanas.BackgroundColor3 = COLORS.FondoSecundario
PanelPestanas.Parent = MainFrame
Instance.new("UICorner", PanelPestanas).CornerRadius = esquinasRedondeadas

-- ════════════════ PANEL DE CONTENIDO (DERECHA) ════════════════
local PanelContenido = Instance.new("Frame")
PanelContenido.Size = UDim2.new(1, -160, 1, -75)
PanelContenido.Position = UDim2.new(0, 145, 0, 70)
PanelContenido.BackgroundColor3 = COLORS.FondoSecundario
PanelContenido.Parent = MainFrame
Instance.new("UICorner", PanelContenido).CornerRadius = esquinasRedondeadas

-- ════════════════ SISTEMA DE PESTAÑAS ════════════════
local pestanaActiva = "Info"
local pestanas = {}
local contenido = {}

-- Función para crear botón de pestaña
local function crearBotonPestana(nombre, posY)
    local btn = Instance.new("TextButton")
    btn.Name = "Pestana_" .. nombre
    btn.Size = UDim2.new(1, -10, 0, 45)
    btn.Position = UDim2.new(0, 5, 0, posY)
    btn.BackgroundColor3 = nombre == "Info" and COLORS.ToggleActivo or COLORS.ToggleInactivo
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Text = nombre
    btn.TextColor3 = COLORS.Blanco
    btn.Parent = PanelPestanas
    Instance.new("UICorner", btn).CornerRadius = esquinasRedondeadas

    btn.MouseButton1Click:Connect(function()
        -- Restaurar todos
        for _, b in pairs(pestanas) do
            b.BackgroundColor3 = COLORS.ToggleInactivo
        end
        btn.BackgroundColor3 = COLORS.ToggleActivo
        pestanaActiva = nombre
        -- Cambiar contenido
        for n, c in pairs(contenido) do
            c.Visible = (n == nombre)
        end
    end)

    pestanas[nombre] = btn
    return btn
end

-- ════════════════ CONTENIDO: INFO ════════════════
local InfoContenido = Instance.new("ScrollingFrame")
InfoContenido.Name = "InfoContenido"
InfoContenido.Size = UDim2.new(1, -15, 1, -15)
InfoContenido.Position = UDim2.new(0, 5, 0, 5)
InfoContenido.BackgroundTransparency = 1
InfoContenido.ScrollBarThickness = 4
InfoContenido.ScrollBarColor3 = COLORS.Borde
InfoContenido.Visible = true
InfoContenido.Parent = PanelContenido

local function agregarTextoInfo(texto, posY, tam, negrito)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, tam == 16 and 25 or 35)
    lbl.Position = UDim2.new(0, 0, 0, posY)
    lbl.BackgroundTransparency = 1
    lbl.Text = texto
    lbl.Font = negrito and Enum.Font.GothamBold or Enum.Font.Gotham
    lbl.TextSize = tam or 14
    lbl.TextColor3 = COLORS.Blanco
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = InfoContenido
    return lbl
end

agregarTextoInfo("📌 Nombre del Creador: JoseAngel_Blox", 10, 15, false)
agregarTextoInfo("📅 Fecha de lanzamiento: 08/09/2026", 40, 15, false)
agregarTextoInfo("🔖 Versión: 1.1", 70, 15, false)
agregarTextoInfo("📝 UPDATE:", 100, 16, true)
agregarTextoInfo("Nuevo script para Steal An Egg. Este es un script básico para aprender a usar un script para este juego. ¡Espero que lo disfrutes mucho!", 130, 14, false)

InfoContenido.CanvasSize = UDim2.new(0, 0, 0, 200)
contenido.Info = InfoContenido

-- ════════════════ CONTENIDO: MAIN ════════════════
local MainContenido = Instance.new("ScrollingFrame")
MainContenido.Name = "MainContenido"
MainContenido.Size = UDim2.new(1, -15, 1, -15)
MainContenido.Position = UDim2.new(0, 5, 0, 5)
MainContenido.BackgroundTransparency = 1
MainContenido.ScrollBarThickness = 4
MainContenido.ScrollBarColor3 = COLORS.Borde
MainContenido.Visible = false
MainContenido.Parent = PanelContenido

-- Estados
local estados = {
    AutoRobar = false,
    AutoEclosionar = false,
    Velocidad = false,
    ESP = false,
    Vender = false,
    Cinta = false
}
local originalSpeed = 16

-- Función crear Toggle Azul
local function crearToggle(nombre, descripcion, posY, claveEstado)
    local Contenedor = Instance.new("Frame")
    Contenedor.Size = UDim2.new(1, 0, 0, 55)
    Contenedor.Position = UDim2.new(0, 0, 0, posY)
    Contenedor.BackgroundColor3 = COLORS.FondoPrincipal
    Contenedor.Parent = MainContenido
    Instance.new("UICorner", Contenedor).CornerRadius = esquinasRedondeadas

    local NombreTxt = Instance.new("TextLabel")
    NombreTxt.Size = UDim2.new(1, -55, 0, 25)
    NombreTxt.Position = UDim2.new(0, 10, 0, 5)
    NombreTxt.BackgroundTransparency = 1
    NombreTxt.Text = nombre
    NombreTxt.Font = Enum.Font.GothamBold
    NombreTxt.TextSize = 15
    NombreTxt.TextColor3 = COLORS.TextoAzul
    NombreTxt.TextXAlignment = Enum.TextXAlignment.Left
    NombreTxt.Parent = Contenedor

    local DescTxt = Instance.new("TextLabel")
    DescTxt.Size = UDim2.new(1, -55, 0, 20)
    DescTxt.Position = UDim2.new(0, 10, 0, 30)
    DescTxt.BackgroundTransparency = 1
    DescTxt.Text = descripcion
    DescTxt.Font = Enum.Font.Gotham
    DescTxt.TextSize = 11
    DescTxt.TextColor3 = COLORS.TransparenteTexto
    DescTxt.TextXAlignment = Enum.TextXAlignment.Left
    DescTxt.Parent = Contenedor

    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(0, 45, 0, 30)
    Toggle.Position = UDim2.new(1, -50, 0.5, -15)
    Toggle.BackgroundColor3 = COLORS.ToggleInactivo
    Toggle.Text = "❌"
    Toggle.Font = Enum.Font.GothamBold
    Toggle.TextSize = 16
    Toggle.TextColor3 = COLORS.Blanco
    Toggle.Parent = Contenedor
    Instance.new("UICorner", Toggle).CornerRadius = esquinasRedondeadas

    Toggle.MouseButton1Click:Connect(function()
        estados[claveEstado] = not estados[claveEstado]
        Toggle.BackgroundColor3 = estados[claveEstado] and COLORS.ToggleActivo or COLORS.ToggleInactivo
        Toggle.Text = estados[claveEstado] and "✅" or "❌"
        -- Acción especial para velocidad
        if claveEstado == "Velocidad" and humanoid then
            humanoid.WalkSpeed = estados[claveEstado] and 48 or originalSpeed
        end
    end)

    return Toggle
end

-- Crear todos los toggles
crearToggle("🥚 Auto Robar Huevos", "Detecta el huevo más cercano, se teletransporta e interactúa", 5, "AutoRobar")
crearToggle("🐣 Auto Eclosionar", "Usa automáticamente el eclosionador/incubadora", 65, "AutoEclosionar")
crearToggle("🏃 Velocidad x3", "Aumenta tu velocidad de movimiento", 125, "Velocidad")
crearToggle("👁️ ESP Huevos", "Resalta huevos a través de paredes con etiqueta", 185, "ESP")
crearToggle("💰 Auto Vender Mascotas", "(Base lista para ampliar)", 245, "Vender")
crearToggle("⚡ Auto Cinta de Correr", "Entrena velocidad automáticamente", 305, "Cinta")

MainContenido.CanvasSize = UDim2.new(0, 0, 0, 370)
contenido.Main = MainContenido

-- Crear botones de pestañas
crearBotonPestana("Info", 10)
crearBotonPestana("Main", 65)

-- ════════════════ LÓGICA PRINCIPAL ════════════════
local ESPObjects = {}

local function getEggs()
    local eggs = {}
    for _, d in ipairs(workspace:GetDescendants()) do
        if d:IsA("BasePart") and (d.Name:find("Egg") or d.Name:find("Huevo")) then
            table.insert(eggs, d)
        end
    end
    return eggs
end

local function getNearestEgg()
    if not rootPart then return nil end
    local eggs = getEggs()
    local nearest, dist = nil, math.huge
    for _, egg in ipairs(eggs) do
        if egg and egg.Parent then
            local d = (rootPart.Position - egg.Position).Magnitude
            if d < dist then dist = d; nearest = egg end
        end
    end
    return nearest
end

local function interactWith(obj)
    if obj then
        local click = obj:FindFirstChildOfClass("ClickDetector")
        if click then fireclickdetector(click) end
    end
end

RunService.Heartbeat:Connect(function()
    if not character or not rootPart then return end

    -- Auto Robar
    if estados.AutoRobar then
        local egg = getNearestEgg()
        if egg then
            local dist = (rootPart.Position - egg.Position).Magnitude
            if dist > 15 then
                rootPart.CFrame = CFrame.new(egg.Position + Vector3.new(0, 2, 0))
                task.wait(0.1)
            elseif dist < 8 then
                interactWith(egg)
            end
        end
    end

    -- Auto Eclosionar
    if estados.AutoEclosionar then
        for _, d in ipairs(workspace:GetDescendants()) do
            if d.Name:find("Incubator") or d.Name:find("Eclosionador") then
                interactWith(d)
            end
        end
    end

    -- Auto Cinta
    if estados.Cinta then
        for _, d in ipairs(workspace:GetDescendants()) do
            if d.Name:find("Treadmill") or d.Name:find("Cinta") then
                interactWith(d)
            end
        end
    end
end)

-- ESP
RunService.RenderStepped:Connect(function()
    if estados.ESP then
        for _, egg in ipairs(getEggs()) do
            if not ESPObjects[egg] then
                local bill = Instance.new("BillboardGui")
                bill.AlwaysOnTop = true
                bill.Size = UDim2.new(0, 80, 0, 25)
                bill.Parent = egg
                local lbl = Instance.new("TextLabel")
                lbl.Size = UDim2.new(1, 0, 1, 0)
                lbl.BackgroundTransparency = 1
                lbl.Text = "🥚 HUEVO"
                lbl.Font = Enum.Font.GothamBold
                lbl.TextSize = 12
                lbl.TextColor3 = COLORS.TextoAzul
                lbl.Parent = bill
                ESPObjects[egg] = bill
            end
        end
    else
        for k, v in pairs(ESPObjects) do
            v:Destroy()
            ESPObjects[k] = nil
        end
    end
end)

-- ════════════════ MOSTRAR/OCULTAR SCRIPT ════════════════
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- ════════════════ FINALIZACIÓN ════════════════
print("✅ JoseAngel_Blox Steal An Egg v1.1 — CARGADO CON ÉXITO!")
print("🎨 Diseño azul marino • Animación de carga • Pestañas")
