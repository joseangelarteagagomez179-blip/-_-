-- ╔══════════════════════════════════════════════════════════════╗
-- ║               🥚 JOSEANGEL_BLOX — STEAL AN EGG v1.1          ║
-- ║                   ✅ VERSIÓN CORREGIDA ✅                     ║
-- ╚══════════════════════════════════════════════════════════════╝

-- Servicios
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

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
    FondoPrincipal = Color3.fromHex("#001a33"),
    FondoSecundario = Color3.fromHex("#00264d"),
    Borde = Color3.fromHex("#0066cc"),
    TextoAzul = Color3.fromHex("#00ccff"),
    ToggleActivo = Color3.fromHex("#0099ff"),
    ToggleInactivo = Color3.fromHex("#003366"),
    TransparenteTexto = Color3.fromHex("#99ccff"),
    Blanco = Color3.fromHex("#ffffff")
}
local esquinasRedondeadas = UDim.new(0, 16)

-- ════════════════ CREAR INTERFAZ PRINCIPAL ANTES DE CARGA ════════════════
local MainGui = Instance.new("ScreenGui")
MainGui.Name = "JoseAngel_Blox_StealAnEgg_v1_1"
MainGui.Parent = PlayerGui
MainGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
MainGui.ResetOnSpawn = false -- 🔑 SOLUCIÓN: No reiniciar al reaparecer

-- Botón flotante
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Size = UDim2.new(0, 55, 0, 55)
ToggleBtn.Position = UDim2.new(0.02, 0, 0.5, -27)
ToggleBtn.BackgroundColor3 = COLORS.FondoPrincipal
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
MainFrame.Visible = false -- Oculto hasta que termine la carga
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

-- Efecto brillo
local efectoTiempo = 0
RunService.RenderStepped:Connect(function(delta)
    efectoTiempo = efectoTiempo + delta * 2
    local brillo = 0.6 + math.sin(efectoTiempo) * 0.4
    TituloPrincipal.TextColor3 = Color3.fromRGB(0, math.floor(150 + brillo * 105), math.floor(200 + brillo * 55))
end)

-- ════════════════ PANEL PESTAÑAS IZQUIERDA ════════════════
local PanelPestanas = Instance.new("Frame")
PanelPestanas.Size = UDim2.new(0, 130, 1, -75)
PanelPestanas.Position = UDim2.new(0, 10, 0, 70)
PanelPestanas.BackgroundColor3 = COLORS.FondoSecundario
PanelPestanas.Parent = MainFrame
Instance.new("UICorner", PanelPestanas).CornerRadius = esquinasRedondeadas

-- ════════════════ PANEL CONTENIDO DERECHA ════════════════
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

local function crearBotonPestana(nombre, posY)
    local btn = Instance.new("TextButton")
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
        for _, b in pairs(pestanas) do b.BackgroundColor3 = COLORS.ToggleInactivo end
        btn.BackgroundColor3 = COLORS.ToggleActivo
        pestanaActiva = nombre
        for n, c in pairs(contenido) do c.Visible = (n == nombre) end
    end)
    pestanas[nombre] = btn
end

-- ════════════════ CONTENIDO INFO ════════════════
local InfoContenido = Instance.new("ScrollingFrame")
InfoContenido.Size = UDim2.new(1, -15, 1, -15)
InfoContenido.Position = UDim2.new(0, 5, 0, 5)
InfoContenido.BackgroundTransparency = 1
InfoContenido.ScrollBarThickness = 4
InfoContenido.ScrollBarColor3 = COLORS.Borde
InfoContenido.Visible = true
InfoContenido.Parent = PanelContenido

local function agregarTexto(texto, posY, tam, negrito)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 30)
    lbl.Position = UDim2.new(0, 0, 0, posY)
    lbl.BackgroundTransparency = 1
    lbl.Text = texto
    lbl.Font = negrito and Enum.Font.GothamBold or Enum.Font.Gotham
    lbl.TextSize = tam
    lbl.TextColor3 = COLORS.Blanco
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = InfoContenido
end

agregarTexto("📌 Nombre del Creador: JoseAngel_Blox", 10, 15, false)
agregarTexto("📅 Fecha de lanzamiento: 08/09/2026", 45, 15, false)
agregarTexto("🔖 Versión: 1.1", 80, 15, false)
agregarTexto("📝 UPDATE:", 115, 16, true)
agregarTexto("Nuevo script para Steal An Egg. Este es un script básico para aprender a usar un script para este juego. ¡Espero que lo disfrutes mucho!", 150, 14, false)
InfoContenido.CanvasSize = UDim2.new(0, 0, 0, 220)
contenido.Info = InfoContenido

-- ════════════════ CONTENIDO MAIN ════════════════
local MainContenido = Instance.new("ScrollingFrame")
MainContenido.Size = UDim2.new(1, -15, 1, -15)
MainContenido.Position = UDim2.new(0, 5, 0, 5)
MainContenido.BackgroundTransparency = 1
MainContenido.ScrollBarThickness = 4
MainContenido.ScrollBarColor3 = COLORS.Borde
MainContenido.Visible = false
MainContenido.Parent = PanelContenido

local estados = { AutoRobar=false, AutoEclosionar=false, Velocidad=false, ESP=false, Vender=false, Cinta=false }
local originalSpeed = 16

local function crearToggle(nombre, desc, posY, clave)
    local Cont = Instance.new("Frame")
    Cont.Size = UDim2.new(1, 0, 0, 55)
    Cont.Position = UDim2.new(0, 0, 0, posY)
    Cont.BackgroundColor3 = COLORS.FondoPrincipal
    Cont.Parent = MainContenido
    Instance.new("UICorner", Cont).CornerRadius = esquinasRedondeadas

    local N = Instance.new("TextLabel")
    N.Size = UDim2.new(1, -55, 0, 25)
    N.Position = UDim2.new(0, 10, 0, 5)
    N.BackgroundTransparency = 1
    N.Text = nombre
    N.Font = Enum.Font.GothamBold
    N.TextSize = 15
    N.TextColor3 = COLORS.TextoAzul
    N.TextXAlignment = Enum.TextXAlignment.Left
    N.Parent = Cont

    local D = Instance.new("TextLabel")
    D.Size = UDim2.new(1, -55, 0, 20)
    D.Position = UDim2.new(0, 10, 0, 30)
    D.BackgroundTransparency = 1
    D.Text = desc
    D.Font = Enum.Font.Gotham
    D.TextSize = 11
    D.TextColor3 = COLORS.TransparenteTexto
    D.TextXAlignment = Enum.TextXAlignment.Left
    D.Parent = Cont

    local T = Instance.new("TextButton")
    T.Size = UDim2.new(0, 45, 0, 30)
    T.Position = UDim2.new(1, -50, 0.5, -15)
    T.BackgroundColor3 = COLORS.ToggleInactivo
    T.Text = "❌"
    T.Font = Enum.Font.GothamBold
    T.TextSize = 16
    T.TextColor3 = COLORS.Blanco
    T.Parent = Cont
    Instance.new("UICorner", T).CornerRadius = esquinasRedondeadas

    T.MouseButton1Click:Connect(function()
        estados[clave] = not estados[clave]
        T.BackgroundColor3 = estados[clave] and COLORS.ToggleActivo or COLORS.ToggleInactivo
        T.Text = estados[clave] and "✅" or "❌"
        if clave == "Velocidad" and humanoid then
            humanoid.WalkSpeed = estados[clave] and 48 or originalSpeed
        end
    end)
end

crearToggle("🥚 Auto Robar Huevos", "Detecta el huevo más cercano, se teletransporta e interactúa", 5, "AutoRobar")
crearToggle("🐣 Auto Eclosionar", "Usa automáticamente el eclosionador/incubadora", 65, "AutoEclosionar")
crearToggle("🏃 Velocidad x3", "Aumenta tu velocidad de movimiento", 125, "Velocidad")
crearToggle("👁️ ESP Huevos", "Resalta huevos a través de paredes con etiqueta", 185, "ESP")
crearToggle("💰 Auto Vender Mascotas", "(Base lista para ampliar)", 245, "Vender")
crearToggle("⚡ Auto Cinta de Correr", "Entrena velocidad automáticamente", 305, "Cinta")

MainContenido.CanvasSize = UDim2.new(0, 0, 0, 370)
contenido.Main = MainContenido

-- Activar pestaña por defecto
crearBotonPestana("Info", 10)
crearBotonPestana("Main", 65)

-- ════════════════ ANIMACIÓN DE CARGA ════════════════
local CargaGui = Instance.new("ScreenGui")
CargaGui.Name = "JoseAngel_Blox_Carga"
CargaGui.Parent = PlayerGui

local Fondo = Instance.new("Frame")
Fondo.Size = UDim2.new(1, 0, 1, 0)
Fondo.BackgroundColor3 = COLORS.FondoPrincipal
Fondo.Parent = CargaGui

local Contenedor = Instance.new("Frame")
Contenedor.Size = UDim2.new(0, 400, 0, 150)
Contenedor.Position = UDim2.new(0.5, -200, 0.5, -75)
Contenedor.BackgroundTransparency = 1
Contenedor.Parent = Fondo

local TituloCarga = Instance.new("TextLabel")
TituloCarga.Size = UDim2.new(1, 0, 0, 50)
TituloCarga.BackgroundTransparency = 1
TituloCarga.Text = "Bienvenidos a Script JoseAngel_Blox"
TituloCarga.Font = Enum.Font.GothamBold
TituloCarga.TextSize = 28
TituloCarga.TextColor3 = COLORS.TextoAzul
TituloCarga.Parent = Contenedor

local BarraFondo = Instance.new("Frame")
BarraFondo.Size = UDim2.new(1, 0, 0, 25)
BarraFondo.Position = UDim2.new(0, 0, 0, 80)
BarraFondo.BackgroundColor3 = COLORS.FondoSecundario
BarraFondo.Parent = Contenedor
Instance.new("UICorner", BarraFondo).CornerRadius = esquinasRedondeadas

local BarraProgreso = Instance.new("Frame")
BarraProgreso.Size = UDim2.new(0, 0, 1, 0)
BarraProgreso.BackgroundColor3 = COLORS.ToggleActivo
BarraProgreso.Parent = BarraFondo
Instance.new("UICorner", BarraProgreso).CornerRadius = esquinasRedondeadas

local Porcentaje = Instance.new("TextLabel")
Porcentaje.Size = UDim2.new(1, 0, 0, 30)
Porcentaje.Position = UDim2.new(0, 0, 0, 115)
Porcentaje.BackgroundTransparency = 1
Porcentaje.Text = "0%"
Porcentaje.Font = Enum.Font.Gotham
Porcentaje.TextSize = 20
Porcentaje.TextColor3 = COLORS.Blanco
Porcentaje.Parent = Contenedor

-- ════════════════ INICIAR CARGA ════════════════
task.spawn(function()
    for i = 1, 100 do
        task.wait(0.035)
        BarraProgreso.Size = UDim2.new(i/100, 0, 1, 0)
        Porcentaje.Text = tostring(i) .. "%"
    end
    task.wait(0.3)
    CargaGui:Destroy()
    
    -- ✅ MOSTRAR EL MENÚ PRINCIPAL AL TERMINAR
    MainFrame.Visible = true
    print("✅ JoseAngel_Blox — Menú cargado correctamente")
end)

-- ════════════════ LÓGICA DE FUNCIONES ════════════════
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
    for _, e in ipairs(eggs) do
        if e and e.Parent then
            local d = (rootPart.Position - e.Position).Magnitude
            if d < dist then dist = d; nearest = e end
        end
    end
    return nearest
end

local function interact(obj)
    if obj then
        local cd = obj:FindFirstChildOfClass("ClickDetector")
        if cd then fireclickdetector(cd) end
    end
end

RunService.Heartbeat:Connect(function()
    if not rootPart then return end
    if estados.AutoRobar then
        local egg = getNearestEgg()
        if egg then
            local d = (rootPart.Position - egg.Position).Magnitude
            if d > 15 then
                rootPart.CFrame = CFrame.new(egg.Position + Vector3.new(0, 2, 0))
            elseif d < 8 then
                interact(egg)
            end
        end
    end
    if estados.AutoEclosionar then
        for _, d in ipairs(workspace:GetDescendants()) do
            if d.Name:find("Incubator") or d.Name:find("Eclosionador") then interact(d) end
        end
    end
    if estados.Cinta then
        for _, d in ipairs(workspace:GetDescendants()) do
            if d.Name:find("Treadmill") or d.Name:find("Cinta") then interact(d) end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if estados.ESP then
        for _, e in ipairs(getEggs()) do
            if not ESPObjects[e] then
                local bill = Instance.new("BillboardGui")
                bill.AlwaysOnTop = true
                bill.Size = UDim2.new(0, 80, 0, 25)
                local lbl = Instance.new("TextLabel")
                lbl.Size = UDim2.new(1,0,1,0)
                lbl.BackgroundTransparency = 1
                lbl.Text = "🥚 HUEVO"
                lbl.Font = Enum.Font.GothamBold
                lbl.TextSize = 12
                lbl.TextColor3 = COLORS.TextoAzul
                lbl.Parent = bill
                bill.Parent = e
                ESPObjects[e] = bill
            end
        end
    else
        for k, v in pairs(ESPObjects) do v:Destroy(); ESPObjects[k] = nil end
    end
end)

-- ════════════════ ABRIR/CERRAR MENÚ ════════════════
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

print("✅ JoseAngel_Blox Steal An Egg v1.1 — LISTO PARA USAR")
