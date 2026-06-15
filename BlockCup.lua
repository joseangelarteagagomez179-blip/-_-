-- =============================================================================
-- SCRIPT: JoseAngel_Blox Block Cup (Versión Optimizada para Delta)
-- =============================================================================

-- CONFIGURACIÓN RÁPIDA: Ajusta la velocidad aquí de forma directa
local VelocidadPersonalizada = 50 

-- SERVICIOS
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer

-- Asegurar que el PlayerGui esté completamente cargado en Delta
if not LocalPlayer:FindFirstChild("PlayerGui") then
    LocalPlayer:GetPropertyChangedSignal("Parent"):Wait()
end

-- =============================================================================
-- INTERFAZ GRÁFICA (GUI) - COMPATIBLE CON MÓVIL / DELTA
-- =============================================================================

-- Eliminar versión previa si ya existía para evitar que se duplique
if LocalPlayer.PlayerGui:FindFirstChild("JoseAngel_Blox_BlockCup") then
    LocalPlayer.PlayerGui.JoseAngel_Blox_BlockCup:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Blox_BlockCup"
ScreenGui.ResetOnSpawn = false
-- Usar CoreGui si está disponible en Delta, si no, PlayerGui por defecto
local CoreGui = game:GetService("CoreGui")
ScreenGui.Parent = (CoreGui:FindFirstChild("RobloxGui") or LocalPlayer:WaitForChild("PlayerGui"))

-- Marco Principal Cuadrado
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 340, 0, 240)
MainFrame.Position = UDim2.new(0.5, -170, 0.3, -120)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- Fondo Oscuro
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Parent = ScreenGui

-- Bordes Redondeados (No puntiagudos)
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

-- Borde Fijo de Color Rojo/Negro Estilo Neón (Más seguro para Delta que el gradiente rotativo)
local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 3
UIStroke.Color = Color3.fromRGB(220, 0, 0) -- Rojo Intenso
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = MainFrame

-- Animación de parpadeo suave del borde (Rojo a Negro)
task.spawn(function()
    while task.wait(1.5) do
        pcall(function()
            TweenService:Create(UIStroke, TweenInfo.new(1.5), {Color = Color3.fromRGB(0, 0, 0)}):Play()
            task.wait(1.5)
            TweenService:Create(UIStroke, TweenInfo.new(1.5), {Color = Color3.fromRGB(220, 0, 0)}):Play()
        end)
    end
end)

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "JoseAngel_Blox Block Cup"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

-- Contenedor de Botones
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -50)
ContentFrame.Position = UDim2.new(0, 10, 0, 40)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Función para generar los botones estables
local function CrearBotonMovel(texto, posicion)
    local Boton = Instance.new("TextButton")
    Boton.Size = UDim2.new(1, 0, 0, 40)
    Boton.Position = posicion
    Boton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Boton.Text = texto .. " [OFF]"
    Boton.TextColor3 = Color3.fromRGB(255, 80, 80)
    Boton.TextSize = 13
    Boton.Font = Enum.Font.GothamSemibold
    Boton.Parent = ContentFrame

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Boton
    return Boton
end

local BtnAutoKick = CrearBotonMovel("1) Auto Kick & Evadir", UDim2.new(0, 0, 0, 10))
local BtnAutoCollect = CrearBotonMovel("2) Auto Collect Block Cup", UDim2.new(0, 0, 0, 60))

-- Indicador de Walkspeed
local InfoLabel = Instance.new("TextLabel")
InfoLabel.Size = UDim2.new(1, 0, 0, 20)
InfoLabel.Position = UDim2.new(0, 0, 0, 115)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Text = "Walkspeed Activo: " .. tostring(VelocidadPersonalizada)
InfoLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
InfoLabel.TextSize = 11
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.Parent = ContentFrame

-- Botón para Minimizar/Cerrar la GUI (Esencial en Delta Móvil)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(40, 10, 10)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.Parent = MainFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 5)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- =============================================================================
-- LÓGICA DE EJECUCIÓN (ANTI-CRASH PARA DELTA)
-- =============================================================================

local EstadoAutoKick = false
local EstadoAutoCollect = false
local PosicionOriginal = nil

-- Bucle de velocidad seguro
task.spawn(function()
    while true do
        task.wait(0.5)
        pcall(function()
            local Character = LocalPlayer.Character
            local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
            if Humanoid and Humanoid.WalkSpeed ~= VelocidadPersonalizada then
                Humanoid.WalkSpeed = VelocidadPersonalizada
            end
        end)
    end
end)

-- LÓGICA 1: AUTO KICK CON RETROCESO SEGURO
task.spawn(function()
    while true do
        task.wait(0.15) -- Tiempo optimizado para no generar lag en móvil
        if EstadoAutoKick then
            pcall(function()
                local Character = LocalPlayer.Character
                local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                
                if RootPart then
                    if not PosicionOriginal then
                        PosicionOriginal = RootPart.CFrame
                    end

                    -- Buscar remotos válidos del juego
                    local KickEvent = ReplicatedStorage:FindFirstChild("KickBlock") or ReplicatedStorage:FindFirstChild("Hit") or ReplicatedStorage:FindFirstChild("Events"):FindFirstChild("Kick")
                    if KickEvent and KickEvent:IsA("RemoteEvent") then
                        KickEvent:FireServer()
                    end

                    -- Evaluar si el bloque desapareció para retroceder
                    local BloqueActivo = workspace:FindFirstChild("LuckyBlock") or workspace:FindFirstChild("Block")
                    if not BloqueActivo and PosicionOriginal then
                        RootPart.CFrame = RootPart.CFrame * CFrame.new(0, 0, 12) -- Retroceso
                        task.wait(0.3)
                        RootPart.CFrame = PosicionOriginal -- Regresar
                    end
                end
            end)
        end
    end
end)

-- LÓGICA 2: AUTO COLLECT BOLAS NARANJAS (BLOQUE CUP)
task.spawn(function()
    while true do
        task.wait(0.4)
        if EstadoAutoCollect then
            pcall(function()
                local Character = LocalPlayer.Character
                local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                
                if RootPart then
                    -- Buscar en el Workspace usando un método rápido que no sature a Delta
                    for _, objeto in ipairs(workspace:GetChildren()) do
                        if not EstadoAutoCollect then break end
                        
                        -- Comprobación por nombre o jerarquía del evento Block Cup
                        if objeto:IsA("BasePart") and (objeto.Name:lower():match("orange") or objeto.Name:lower():match("cup") or objeto.Name:lower():match("ball")) then
                            RootPart.CFrame = objeto.CFrame
                            task.wait(0.2)
                            break
                        elseif objeto.Name == "DroppedItems" or objeto.Name == "EventItems" then
                            -- Si los objetos están dentro de una carpeta específica del juego
                            for _, subObjeto in ipairs(objeto:GetChildren()) do
                                if subObjeto:IsA("BasePart") then
                                    RootPart.CFrame = subObjeto.CFrame
                                    task.wait(0.2)
                                    break
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- =============================================================================
-- COMPORTAMIENTO DE LOS BOTONES
-- =============================================================================

BtnAutoKick.MouseButton1Click:Connect(function()
    EstadoAutoKick = not EstadoAutoKick
    if EstadoAutoKick then
        BtnAutoKick.Text = "1) Auto Kick & Evadir [ON]"
        BtnAutoKick.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        BtnAutoKick.Text = "1) Auto Kick & Evadir [OFF]"
        BtnAutoKick.TextColor3 = Color3.fromRGB(255, 80, 80)
        PosicionOriginal = nil
    end
end)

BtnAutoCollect.MouseButton1Click:Connect(function()
    EstadoAutoCollect = not EstadoAutoCollect
    if EstadoAutoCollect then
        BtnAutoCollect.Text = "2) Auto Collect [ON]"
        BtnAutoCollect.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        BtnAutoCollect.Text = "2) Auto Collect [OFF]"
        BtnAutoCollect.TextColor3 = Color3.fromRGB(255, 80, 80)
    end
