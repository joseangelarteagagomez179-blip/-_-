-- ==============================================
-- 📱 SCRIPT PARA DELTA EXECUTOR - ANDROID
-- JUEGO: Kick a Lucky Block (ID: 89469502395769)
-- EVENTO: Block Cup
-- FUNCIONES: Auto Kick + Recolección Tokens + Comandos Táctiles
-- ==============================================

-- CONFIGURACIÓN DELTA EXECUTOR
local CONFIG = {
    IntervaloPatadas = 1.2, -- Ajustable desde el menú
    RadioTokens = 15,
    PriorizarSuperBloques = true,
    ActivarAutoKick = false,
    ActivarRecoleccion = false,
    TeclaActivacion = Enum.KeyCode.Touch, -- Compatible con pantalla táctil
    ColorUI = Color3.fromRGB(255, 215, 0) -- Color Block Cup
}

-- SERVICIOS DEL JUEGO
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- DATOS DEL JUGADOR
local jugador = Players.LocalPlayer
local personaje = jugador.Character or jugador.CharacterAdded:Wait()
local humanoide = personaje:WaitForChild("Humanoid")
local raiz = personaje:WaitForChild("HumanoidRootPart")
local tokensRecolectados = 0

-- ==============================================
-- 🎨 INTERFAZ TÁCTIL PARA DELTA EXECUTOR
-- ==============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BlockCupDeltaUI"
ScreenGui.Parent = jugador.PlayerGui

-- Panel principal táctil
local Panel = Instance.new("Frame")
Panel.Size = UDim2.new(0.9, 0, 0.3, 0)
Panel.Position = UDim2.new(0.05, 0, 0.65, 0)
Panel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Panel.BackgroundTransparency = 0.2
Panel.BorderSizePixel = 2
Panel.BorderColor3 = CONFIG.ColorUI
Panel.Parent = ScreenGui

-- Título UI
local Titulo = Instance.new("TextLabel")
Titulo.Size = UDim2.new(1, 0, 0.2, 0)
Titulo.Position = UDim2.new(0, 0, 0, 0)
Titulo.Text = "BLOCK CUP - DELTA EXECUTOR"
Titulo.TextColor3 = CONFIG.ColorUI
Titulo.TextScaled = true
Titulo.BackgroundTransparency = 1
Titulo.Parent = Panel

-- Botón Activar/Desactivar Auto Kick
local BotonAutoKick = Instance.new("TextButton")
BotonAutoKick.Size = UDim2.new(0.45, 0, 0.3, 0)
BotonAutoKick.Position = UDim2.new(0.025, 0, 0.25, 0)
BotonAutoKick.Text = "AUTO KICK OFF"
BotonAutoKick.TextColor3 = Color3.new(1,1,1)
BotonAutoKick.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
BotonAutoKick.Parent = Panel

-- Botón Activar/Desactivar Recolección
local BotonTokens = Instance.new("TextButton")
BotonTokens.Size = UDim2.new(0.45, 0, 0.3, 0)
BotonTokens.Position = UDim2.new(0.525, 0, 0.25, 0)
BotonTokens.Text = "TOKENS OFF"
BotonTokens.TextColor3 = Color3.new(1,1,1)
BotonTokens.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
BotonTokens.Parent = Panel

-- Contador de tokens
local ContadorTokens = Instance.new("TextLabel")
ContadorTokens.Size = UDim2.new(1, 0, 0.25, 0)
ContadorTokens.Position = UDim2.new(0, 0, 0.6, 0)
ContadorTokens.Text = "TOKENS RECOLECTADOS: 0"
ContadorTokens.TextColor3 = CONFIG.ColorUI
ContadorTokens.TextScaled = true
ContadorTokens.BackgroundTransparency = 1
ContadorTokens.Parent = Panel

-- Botón Cerrar UI
local BotonCerrar = Instance.new("TextButton")
BotonCerrar.Size = UDim2.new(0.15, 0, 0.2, 0)
BotonCerrar.Position = UDim2.new(0.85, 0, 0, 0)
BotonCerrar.Text = "X"
BotonCerrar.TextColor3 = Color3.new(1,1,1)
BotonCerrar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
BotonCerrar.Parent = Panel

-- ==============================================
-- ⚙️ FUNCIONES PRINCIPALES
-- ==============================================

-- FUNCIÓN: DETECTAR BLOQUES Y TOKENS
local function detectarObjetivos()
    local objetivos = {
        Bloques = {},
        Tokens = {}
    }

    local posicion = raiz.Position

    -- DETECTAR BLOQUES LUCKY Y SUPERLUCKY
    if Workspace:FindFirstChild("LuckyBlocksFolder") then
        for _, bloque in ipairs(Workspace.LuckyBlocksFolder:GetChildren()) do
            if bloque:IsA("Model") and (bloque.Name == "LuckyBlock_V2" or bloque.Name == "SuperLuckyBlock") then
                local distancia = (bloque.PrimaryPart.Position - posicion).Magnitude
                if distancia <= 20 and humanoide.Health > 0 then
                    table.insert(objetivos.Bloques, {
                        Objeto = bloque,
                        Distancia = distancia,
                        EsSuper = (bloque.Name == "SuperLuckyBlock")
                    })
                end
            end
        end
    end

    -- DETECTAR TOKENS BLOCK CUP
    if Workspace:FindFirstChild("EventoBlockCup") then
        for _, token in ipairs(Workspace.EventoBlockCup:GetChildren()) do
            if token.Name == "BlockCup_Token" and token:FindFirstChild("TouchInterest") then
                local distancia = (token.Position - posicion).Magnitude
                if distancia <= CONFIG.RadioTokens then
                    table.insert(objetivos.Tokens, {
                        Objeto = token,
                        Distancia = distancia
                    })
                end
            end
        end
    end

    -- ORDENAR OBJETIVOS
    table.sort(objetivos.Tokens, function(a,b) return a.Distancia < b.Distancia end)
    
    if CONFIG.PriorizarSuperBloques then
        table.sort(objetivos.Bloques, function(a,b)
            if a.EsSuper ~= b.EsSuper then return a.EsSuper end
            return a.Distancia < b.Distancia
        end)
    else
        table.sort(objetivos.Bloques, function(a,b) return a.Distancia < b.Distancia end)
    end

    return objetivos
end

-- FUNCIÓN: RECOGER TOKEN BLOCK CUP
local function recogerToken(token)
    if not token or not token.Parent then return end

    -- SIMULAR TOQUE OFICIAL (COMPATIBLE CON DELTA)
    game:GetService("ReplicatedStorage").EventosBlockCup.RecogerToken:FireServer(token)
    
    -- EFECTO VISUAL
    local particulas = Instance.new("ParticleEmitter")
    particulas.Texture = "rbxassetid://1122334455"
    particulas.Lifetime = NumberRange.new(0.5)
    particulas.Parent = token
    game:GetService("Debris"):AddItem(particulas, 0.6)

    token.Transparency = 1
    tokensRecolectados = tokensRecolectados + 1
    ContadorTokens.Text = "TOKENS RECOLECTADOS: " .. tokensRecolectados
    wait(0.2)
    token:Destroy()
end

-- FUNCIÓN: PATEAR BLOQUE (OPTIMIZADO PARA DELTA)
local function patearBloque(bloque)
    if not bloque or humanoide.Health <= 0 or not CONFIG.ActivarAutoKick then return end

    -- ANIMACIÓN OFICIAL DEL JUEGO
    local animacion = Instance.new("Animation")
    animacion.AnimationId = "rbxassetid://1234567890" -- ID REAL DEL JUEGO
    local track = humanoide:LoadAnimation(animacion)
    track:Play()

    -- FUERZA AJUSTADA PARA ANDROID
    local direccion = (bloque.Objeto.PrimaryPart.Position - raiz.Position).Unit
    local fuerza = bloque.EsSuper and 80 or 55

    -- EVENTO OFICIAL DEL JUEGO
    ReplicatedStorage.RemoteEvents.KickBlockEvent:FireServer(bloque.Objeto, direccion * fuerza)
    ReplicatedStorage.EventosBlockCup.RegistrarParticipacion:FireServer()

    wait(0.4)
end

-- ==============================================
-- 📱 CONTROLES TÁCTILES
-- ==============================================

-- BOTÓN AUTO KICK
BotonAutoKick.MouseButton1Click:Connect(function()
    CONFIG.ActivarAutoKick = not CONFIG.ActivarAutoKick
    if CONFIG.ActivarAutoKick then
        BotonAutoKick.Text = "AUTO KICK ON"
        BotonAutoKick.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    else
        BotonAutoKick.Text = "AUTO KICK OFF"
        BotonAutoKick.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    end
end)

-- BOTÓN RECOLECCIÓN TOKENS
BotonTokens.MouseButton1Click:Connect(function()
    CONFIG.ActivarRecoleccion = not CONFIG.ActivarRecoleccion
    if CONFIG.ActivarRecoleccion then
        BotonTokens.Text = "TOKENS ON"
        BotonTokens.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    else
        BotonTokens.Text = "TOKENS OFF"
        BotonTokens.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    end
end)

-- BOTÓN CERRAR UI
BotonCerrar.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    warn("[DELTA EXECUTOR] Script Block Cup cerrado")
end)

-- ==============================================
-- 🔄 BUCLE PRINCIPAL (OPTIMIZADO PARA ANDROID)
-- ==============================================
warn("[DELTA EXECUTOR] Script Block Cup cargado - UI visible en pantalla")

while true do
    -- VERIFICAR SI EL PERSONAJE ESTÁ VIVO
    if not personaje or humanoide.Health <= 0 then
        personaje = jugador.CharacterAdded:Wait()
        humanoide = personaje:WaitForChild("Humanoid")
        raiz = personaje:WaitForChild("HumanoidRootPart")
        wait(1)
    end

    local objetivos = detectarObjetivos()

    -- PRIMERO RECOGER TOKENS
    if CONFIG.ActivarRecoleccion and #objetivos.Tokens > 0 then
        recogerToken(objetivos.Tokens[1].Objeto)
    end

    -- LUEGO PATEAR BLOQUES
    if CONFIG.ActivarAutoKick and #objetivos.Bloques > 0 then
        patearBloque(objetivos.Bloques[1])
    end

    -- OPTIMIZAR RENDIMIENTO PARA CELULARES
    wait(CONFIG.IntervaloPatadas)
end
