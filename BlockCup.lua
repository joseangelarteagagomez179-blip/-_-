-- =============================================================================
-- SCRIPT: JoseAngel_Blox Block Cup
-- JUEGO: Kick a Lucky Block (Evento Block Cup)
-- =============================================================================

-- CONFIGURACIÓN RÁPIDA: Cambia este valor para modificar la velocidad de tu personaje
local VelocidadPersonalizada = 50 

-- SERVICIOS DE ROBLOX
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenInfoData = TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true)

local LocalPlayer = Players.LocalPlayer

-- =============================================================================
-- INTERFAZ GRÁFICA (GUI) - DISEÑO CUADRADO CON ESQUINAS REDONDEADAS
-- =============================================================================

-- Crear ScreenGui principal (Protegido para que no se borre al morir)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Blox_BlockCup"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Contenedor Principal de la Interfaz
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 380, 0, 260)
MainFrame.Position = UDim2.new(0.5, -190, 0.4, -130)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- Fondo bonito oscuro
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- Permite arrastrar la interfaz con el mouse
MainFrame.Parent = ScreenGui

-- Redondear Esquinas de la Interfaz Principal (No puntiagudas)
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Bordes con Colores Rojo y Negro Movimiento Cuadricular (Gradiente)
local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),   -- Rojo
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 0, 0)),   -- Negro
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))    -- Rojo
})
UIGradient.Parent = MainFrame

-- Animación del Borde (Efecto de movimiento continuo)
TweenService:Create(UIGradient, TweenInfoData, {Rotation = 360}):Play()

-- Título del Script
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "JoseAngel_Blox Block Cup"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

-- Contenedor interior para las opciones
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -60)
ContentFrame.Position = UDim2.new(0, 10, 0, 45)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Estilo base para los botones de encendido/apagado
local function CrearBoton(nombre, texto, posicion)
    local Boton = Instance.new("TextButton")
    Boton.Name = nombre
    Boton.Size = UDim2.new(1, 0, 0, 45)
    Boton.Position = posicion
    Boton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Boton.Text = texto .. ": [APAGADO]"
    Boton.TextColor3 = Color3.fromRGB(255, 100, 100)
    Boton.TextSize = 14
    Boton.Font = Enum.Font.GothamSemibold
    Boton.Parent = ContentFrame

    local BotonCorner = Instance.new("UICorner")
    BotonCorner.CornerRadius = UDim.new(0, 8)
    BotonCorner.Parent = Boton
    
    return Boton
end

local BtnAutoKick = CrearBoton("BtnAutoKick", "1) Auto Kick & Evadir", UDim2.new(0, 0, 0, 10))
local BtnAutoCollect = CrearBoton("BtnAutoCollect", "2) Auto Collect Blocks Cup (Bolas Naranjas)", UDim2.new(0, 0, 0, 70))

-- Nota sobre velocidad en la interfaz
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, 0, 0, 25)
SpeedLabel.Position = UDim2.new(0, 0, 0, 130)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Walkspeed configurado en: " .. tostring(VelocidadPersonalizada)
SpeedLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
SpeedLabel.TextSize = 12
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.Parent = ContentFrame

-- =============================================================================
-- LOGICA DEL SCRIPT (FUNCIONES INTERNAS)
-- =============================================================================

local EstadoAutoKick = false
local EstadoAutoCollect = false
local PosicionOriginal = nil

-- Aplicar velocidad constante mientras el script esté vivo
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = VelocidadPersonalizada
            end
        end)
    end
end)

-- FUNCIÓN 1: AUTO KICK Y RETROCESO AUTOMÁTICO
task.spawn(function()
    while true do
        task.wait(0.1) -- Velocidad rápida de golpeo
        if EstadoAutoKick then
            pcall(function()
                local Character = LocalPlayer.Character
                local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                
                -- Guardar posición antes de que explote el bloque si no se ha guardado
                if not PosicionOriginal and RootPart then
                    PosicionOriginal = RootPart.CFrame
                end

                -- Detectar si hay un bloque cerca o si está en proceso de caer/explotar
                -- (El juego usa la carpeta Workspace para los bloques generados)
                local Bloque = workspace:FindFirstChild("LuckyBlock") or workspace:FindFirstChild("Block")
                
                -- Disparar evento de patear bloque remotamente (Simula el clic/tecla de forma nativa y veloz)
                local KickEvent = ReplicatedStorage:FindFirstChild("KickBlock") or ReplicatedStorage:FindFirstChild("Hit")
                if KickEvent and KickEvent:IsA("RemoteEvent") then
                    KickEvent:FireServer()
                end

                -- Mecánica de Retroceso Automático: Si el bloque desaparece o su vida llega a cero, el personaje retrocede
                if not Bloque and RootPart and PosicionOriginal then
                    -- Mover hacia atrás simulando esquivar la explosión/caída
                    RootPart.CFrame = RootPart.CFrame * CFrame.new(0, 0, 15) 
                    task.wait(0.4)
                    -- Regresar de inmediato a la zona de golpeo
                    RootPart.CFrame = PosicionOriginal
                end
            end)
        end
    end
end)

-- FUNCIÓN 2: AUTO COLLECT BLOCKS CUP (BOLAS NARANJAS)
task.spawn(function()
    while true do
        task.wait(0.3) -- Escaneo constante del mapa
        if EstadoAutoCollect then
            pcall(function()
                local Character = LocalPlayer.Character
                local RootPart = Character and Character:FindFirstChild("HumanoidRootPart")
                
                if RootPart then
                    -- Buscar las Bolas Naranjas en el espacio de juego (Workspace)
                    -- Analiza por nombre aproximado o características visuales para evitar fallas si cambia de ID
                    for _, objeto in pairs(workspace:GetDescendants()) do
                        if EstadoAutoCollect == false then break end
                        
                        -- Filtro seguro por nombre común del evento Cup o características del objeto naranja
                        if objeto:IsA("TouchTransmitter") and (objeto.Parent.Name:lower():match("orange") or objeto.Parent.Name:lower():match("ball") or objeto.Parent.Name:lower():match("cup")) then
                            local BolaNaranja = objeto.Parent
                            if BolaNaranja and BolaNaranja:IsA("BasePart") then
                                -- Moverse de forma segura hacia la Bola Naranja (Teletransporte controlado por coordenadas)
                                RootPart.CFrame = BolaNaranja.CFrame
                                task.wait(0.2) -- Pausa milimétrica para asegurar que el motor registre la recolección
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- =============================================================================
-- ENLAZAR COMPORTAMIENTO DE LOS BOTONES DE LA INTERFAZ
-- =============================================================================

BtnAutoKick.MouseButton1Click:Connect(function()
    EstadoAutoKick = not EstadoAutoKick
    if EstadoAutoKick then
        BtnAutoKick.Text = "1) Auto Kick & Evadir: [ENCENDIDO]"
        BtnAutoKick.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        BtnAutoKick.Text = "1) Auto Kick & Evadir: [APAGADO]"
        BtnAutoKick.TextColor3 = Color3.fromRGB(255, 100, 100)
        PosicionOriginal = nil
    end
end)

BtnAutoCollect.MouseButton1Click:Connect(function()
    EstadoAutoCollect = not EstadoAutoCollect
    if EstadoAutoCollect then
        BtnAutoCollect.Text = "2) Auto Collect: [ENCENDIDO]"
        BtnAutoCollect.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        BtnAutoCollect.Text = "2) Auto Collect: [APAGADO]"
        BtnAutoCollect.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

print("¡Interface JoseAngel_Blox Block Cup cargada con éxito!")
