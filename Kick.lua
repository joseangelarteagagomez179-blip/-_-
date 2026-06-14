--[[
    NOMBRE: JoseAngel_Blox_kick
    AUTOR: JoseAngel_Blox
    VERSIÓN: 2.1.0
    COMPATIBILIDAD: Kick a Lucky Block (ID: 89469502395769)
    ACTUALIZACIONES: 
    - Soporte para nuevas pelotas (13/06/2026)
    - Soporte para objetos del evento Block Cup (14/06/2026)
    REPOSITORIO: https://github.com/[TuUsuario]/JoseAngel_Blox-Kick-Script
--]]

-- ==============================================
-- CONFIGURACIÓN GENERAL
-- ==============================================
local Config = {
    -- Teclas de control
    Teclas = {
        ToggleAutoColeccion = Enum.KeyCode.F1,
        ToggleAutoColeccionEvento = Enum.KeyCode.F2, -- Tecla exclusiva para Block Cup
        ToggleAutoKick = Enum.KeyCode.F3,
        ToggleMejoras = Enum.KeyCode.F4,
        ToggleInvisibilidad = Enum.KeyCode.F5,
        TeleportToBoss = Enum.KeyCode.F6,
        TeleportToEvento = Enum.KeyCode.F7, -- Teletransporte al área del evento
        ResetValores = Enum.KeyCode.F8,
        AbrirMenu = Enum.KeyCode.F9
    },

    -- Configuración de funcionalidades
    Funcionalidades = {
        AutoColeccionarTodo = true,
        AutoColeccionarEvento = true, -- Habilitar/deshabilitar colección de Block Cup
        AutoKickBlocks = true,
        MejorarVelocidadSalto = true,
        VelocidadMax = 80, -- Aumentada para moverse rápido en el evento
        SaltoMax = 150,
        InvisibilidadActiva = false
    },

    -- IDs y nombres de objetos (actualizados 14/06/2026)
    ObjetosJuego = {
        BloquesSuerte = "LuckyBlock",
        PelotasEstandar = "Coin",
        NuevasPelotas = {
            "PowerBall",
            "DefenseBall",
            "XPBoostBall",
            "GoldBall"
        },
        -- Objetos del evento Block Cup
        ObjetosBlockCup = {
            "CupToken",       -- Monedas del evento
            "BlockCupMedal",  -- Medallas (bronce/plata/oro)
            "CupPowerUp",     -- Mejoras exclusivas del evento
            "FinalReward"     -- Recompensas finales del evento
        },
        AreasJuego = {
            BossSpawn = "BossSpawnLocation",
            EventoBlockCup = "BlockCupArena" -- Zona del evento
        },
        JugadorPart = "HumanoidRootPart"
    }
}

-- ==============================================
-- VARIABLES GLOBALES
-- ==============================================
local Jugador = game:GetService("Players").LocalPlayer
local Personaje = Jugador.Character or Jugador.CharacterAdded:Wait()
local Humanoide = Personaje:WaitForChild("Humanoid")
local RaizPersonaje = Personaje:WaitForChild(Config.ObjetosJuego.JugadorPart)
local MundoJuego = game:GetService("Workspace"):WaitForChild("GameWorld")
local ValoresOriginales = {
    Velocidad = Humanoide.WalkSpeed,
    Salto = Humanoide.JumpPower
}
local MenuActivo = false

-- ==============================================
-- FUNCION AUXILIAR: LOGS
-- ==============================================
local function Log(mensaje: string, tipo: string?)
    local prefijo = tipo == "ERROR" and "[❌ ERROR]" or "[✅ INFO]"
    print(`{prefijo} [{os.date("%H:%M:%S")}] JoseAngel_Blox_kick - {mensaje}`)
end

-- ==============================================
-- FUNCIONALIDAD 1: AUTO-COLECCIÓN ESTÁNDAR + NUEVAS PELOTAS
-- ==============================================
local AutoColeccionActivo = Config.Funcionalidades.AutoColeccionarTodo
local function ToggleAutoColeccion()
    AutoColeccionActivo = not AutoColeccionActivo
    Log(`Auto-colección estándar {AutoColeccionActivo and "ACTIVADA" or "DESACTIVADA"} (incluye nuevas pelotas)`)

    if AutoColeccionActivo then
        while AutoColeccionActivo do
            task.wait(0.1)
            -- Pelotas estándar
            for _, pelota in ipairs(MundoJuego:GetDescendants()) do
                if pelota.Name == Config.ObjetosJuego.PelotasEstandar and pelota:IsA("Part") then
                    RaizPersonaje.CFrame = pelota.CFrame
                end
            end
            -- Nuevas pelotas
            for _, tipoPelota in ipairs(Config.ObjetosJuego.NuevasPelotas) do
                for _, pelota in ipairs(MundoJuego:GetDescendants()) do
                    if pelota.Name == tipoPelota and pelota:IsA("Part") then
                        RaizPersonaje.CFrame = pelota.CFrame
                    end
                end
            end
        end
    end
end

-- ==============================================
-- FUNCIONALIDAD 2: AUTO-COLECCIÓN EXCLUSIVA DEL EVENTO BLOCK CUP
-- ==============================================
local AutoColeccionEventoActivo = Config.Funcionalidades.AutoColeccionarEvento
local function ToggleAutoColeccionEvento()
    AutoColeccionEventoActivo = not AutoColeccionEventoActivo
    Log(`Auto-colección Block Cup {AutoColeccionEventoActivo and "ACTIVADA" or "DESACTIVADA"} (tokens, medallas y más)`)

    if AutoColeccionEventoActivo then
        while AutoColeccionEventoActivo do
            task.wait(0.08) -- Intervalo más rápido para el evento
            -- Coleccionar objetos del Block Cup
            for _, objetoEvento in ipairs(Config.ObjetosJuego.ObjetosBlockCup) do
                for _, objeto in ipairs(MundoJuego:GetDescendants()) do
                    if objeto.Name == objetoEvento and objeto:IsA("Part") then
                        RaizPersonaje.CFrame = objeto.CFrame
                    end
                end
            end
        end
    end
end

-- ==============================================
-- FUNCIONALIDAD 3: AUTO-KICK DE BLOQUES (INCLUYE BLOQUES DEL EVENTO)
-- ==============================================
local AutoKickActivo = Config.Funcionalidades.AutoKickBlocks
local function ToggleAutoKick()
    AutoKickActivo = not AutoKickActivo
    Log(`Auto-kick de bloques {AutoKickActivo and "ACTIVADO" or "DESACTIVADO"} (incluye bloques del Block Cup)`)

    if AutoKickActivo then
        while AutoKickActivo do
            task.wait(0.2)
            -- Bloques de suerte estándar
            for _, bloque in ipairs(MundoJuego:GetDescendants()) do
                if bloque.Name == Config.ObjetosJuego.BloquesSuerte and bloque:IsA("Part") then
                    local Fuerza = Instance.new("BodyVelocity")
                    Fuerza.Velocity = (RaizPersonaje.CFrame.LookVector * 50) + Vector3.new(0, 20, 0)
                    Fuerza.Parent = bloque
                    task.delay(0.5, function() Fuerza:Destroy() end)
                end
            end
            -- Bloques exclusivos del Block Cup
            for _, bloque in ipairs(MundoJuego:GetDescendants()) do
                if bloque.Name == "BlockCupBlock" and bloque:IsA("Part") then
                    local FuerzaEvento = Instance.new("BodyVelocity")
                    FuerzaEvento.Velocity = (RaizPersonaje.CFrame.LookVector * 60) + Vector3.new(0, 25, 0)
                    FuerzaEvento.Parent = bloque
                    task.delay(0.5, function() FuerzaEvento:Destroy() end)
                end
            end
        end
    end
end

-- ==============================================
-- FUNCIONALIDAD 4: MEJORAS DE VELOCIDAD Y SALTO
-- ==============================================
local MejorasActivas = Config.Funcionalidades.MejorarVelocidadSalto
local function ToggleMejoras()
    MejorasActivas = not MejorasActivas
    if MejorasActivas then
        Humanoide.WalkSpeed = Config.Funcionalidades.VelocityMax
        Humanoide.JumpPower = Config.Funcionalidades.SaltoMax
        Log(`Mejoras activadas - Velocidad: {Config.Funcionalidades.VelocityMax} | Salto: {Config.Funcionalidades.SaltoMax}`)
    else
        Humanoide.WalkSpeed = ValoresOriginales.Velocidad
        Humanoide.JumpPower = ValoresOriginales.Salto
        Log("Mejoras desactivadas - Valores restaurados")
    end
end

-- ==============================================
-- FUNCIONALIDAD 5: INVISIBILIDAD
-- ==============================================
local function ToggleInvisibilidad()
    Config.Funcionalidades.InvisibilidadActiva = not Config.Funcionalidades.InvisibilidadActiva
    for _, parte in ipairs(Personaje:GetDescendants()) do
        if parte:IsA("BasePart") or parte:IsA("Decal") then
            parte.Transparency = Config.Funcionalidades.InvisibilidadActiva and 1 or 0
        end
    end
    Log(`Invisibilidad {Config.Funcionalidades.InvisibilidadActiva and "ACTIVADA" or "DESACTIVADA"}`)
end

-- ==============================================
-- FUNCIONALIDAD 6: TELETRANSPORTES
-- ==============================================
local function TeleportToBoss()
    local BossSpawn = MundoJuego:FindFirstChild(Config.ObjetosJuego.AreasJuego.BossSpawn)
    if BossSpawn then
        RaizPersonaje.CFrame = BossSpawn.CFrame + Vector3.new(0, 5, 0)
        Log("Teletransportado al spawn del Boss")
    else
        Log("No se encontró el spawn del Boss", "ERROR")
    end
end

local function TeleportToEvento()
    local AreaEvento = MundoJuego:FindFirstChild(Config.ObjetosJuego.AreasJuego.EventoBlockCup)
    if AreaEvento then
        RaizPersonaje.CFrame = AreaEvento.CFrame + Vector3.new(0, 5, 0)
        Log("Teletransportado a la arena del Block Cup")
    else
        Log("No se encontró la zona del evento Block Cup", "ERROR")
    end
end

-- ==============================================
-- FUNCIONALIDAD 7: RESET DE VALORES
-- ==============================================
local function ResetValores()
    AutoColeccionActivo = false
    AutoColeccionEventoActivo = false
    AutoKickActivo = false
    MejorasActivas = false
    Config.Funcionalidades.InvisibilidadActiva = false

    Humanoide.WalkSpeed = ValoresOriginales.Velocidad
    Humanoide.JumpPower = ValoresOriginales.Salto
    for _, parte in ipairs(Personaje:GetDescendants()) do
        if parte:IsA("BasePart") or parte:IsA("Decal") then
            parte.Transparency = 0
        end
    end
    Log("Todos los valores han sido reiniciados (incluye configuración del Block Cup)")
end

-- ==============================================
-- SISTEMA DE ENTRADA DE TECLADO
-- ==============================================
game:GetService("UserInputService").InputBegan:Connect(function(input: InputObject, procesado: boolean)
    if procesado then return end

    if input.KeyCode == Config.Teclas.ToggleAutoColeccion then
        task.spawn(ToggleAutoColeccion)
    elseif input.KeyCode == Config.Teclas.ToggleAutoColeccionEvento then
        task.spawn(ToggleAutoColeccionEvento)
    elseif input.KeyCode == Config.Teclas.ToggleAutoKick then
        task.spawn(ToggleAutoKick)
    elseif input.KeyCode == Config.Teclas.ToggleMejoras then
        ToggleMejoras()
    elseif input.KeyCode == Config.Teclas.ToggleInvisibilidad then
        ToggleInvisibilidad()
    elseif input.KeyCode == Config.Teclas.TeleportToBoss then
        TeleportToBoss()
    elseif input.KeyCode == Config.Teclas.TeleportToEvento then
        TeleportToEvento()
    elseif input.KeyCode == Config.Teclas.ResetValores then
        ResetValores()
    elseif input.KeyCode == Config.Teclas.AbrirMenu then
        MenuActivo = not MenuActivo
        Log(`Menú {MenuActivo and "ABIERTO - Consulta controles a continuación" or "CERRADO"}`)
    end
end)

-- ==============================================
-- INICIALIZACIÓN DEL SCRIPT
-- ==============================================
Log("SCRIPT CARGADO CORRECTAMENTE PARA KICK A LUCKY BLOCK")
Log("✨ INCLUYE SOPORTE PARA EL EVENTO BLOCK CUP ✨")
Log("CONTROLES:")
Log("- F1: Auto-colección estándar + nuevas pelotas")
Log("- F2: Auto-colección EXCLUSIVA del Block Cup")
Log("- F3: Auto-kick de bloques (estándar + evento)")
Log("- F4: Mejoras de velocidad/salto")
Log("- F5: Invisibilidad")
Log("- F6: Teletransporte al Boss")
Log("- F7: Teletransporte a la arena del Block Cup")
Log("- F8: Resetear todos los valores")
Log("- F9: Abrir/cerrar menú")
Log("¡DISFRÚTALO! | JoseAngel_Blox")
