--[[
    SCRIPT: Recolector de Bolas Naranjas (VERSIÓN EDUCATIVA)
    JUEGO: Kick a Lucky Block - Evento Copa de Bloques
    
    ⚠️ NOTA: Este script es una plantilla educativa.
    Las funciones de movimiento y recolección están simuladas (solo prints).
    Para que funcione realmente, necesitarías implementar la lógica
    específica de interacción con el juego, lo cual no recomendamos.
--]]

-- ===== CONFIGURACIÓN =====
local RADIO_BUSQUEDA = 50      -- Distancia para buscar bolas (estudios)
local TIEMPO_ENTRE_BUSQUEDAS = 1  -- Segundos entre cada búsqueda

-- ===== SERVICIOS =====
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")

-- ===== OBTENER PERSONAJE =====
local function getCharacter()
    local character = LocalPlayer.Character
    if not character or character.Parent == nil then
        LocalPlayer.CharacterAdded:Wait()
        character = LocalPlayer.Character
    end
    return character
end

-- ===== BUSCAR BOLAS NARANJAS EN EL MAPA =====
local function buscarBolasNaranjas()
    local bolasEncontradas = {}
    
    -- Buscar en todo Workspace objetos que parezcan bolas naranjas
    for _, objeto in pairs(Workspace:GetDescendants()) do
        -- ⚠️ COMPLETAR: Reemplazar "OrangeBall" con el nombre real del objeto
        local nombre = objeto.Name:lower()
        if objeto.ClassName == "Part" or objeto.ClassName == "MeshPart" then
            if nombre:find("orange") or nombre:find("naranja") or nombre:find("ball") or nombre:find("bola") then
                -- Verificar color aproximado (naranja)
                local color = objeto.Color
                if color and color.r > 0.5 and color.g < 0.4 and color.b < 0.2 then
                    table.insert(bolasEncontradas, objeto)
                end
            end
        end
    end
    
    return bolasEncontradas
end

-- ===== MOVERSE HACIA UN PUNTO (SIMULADO) =====
local function moverHacia(punto)
    -- ⚠️ Esta función está simulada (solo print)
    -- En un script real, se usaría: humanoid:MoveTo(punto)
    print("[SIMULADO] Moviéndose hacia: " .. tostring(punto))
    return true
end

-- ===== RECOGER BOLA (SIMULADO) =====
local function recogerBola(bola)
    -- ⚠️ Esta función está simulada
    -- En un script real, se activaría un ClickDetector o RemoteEvent
    print("[SIMULADO] Recogiendo bola: " .. bola.Name)
    return true
end

-- ===== BUCLE PRINCIPAL DE RECOLECCIÓN =====
local function iniciarRecolector()
    print("[Recolector] Iniciando búsqueda de Bolas Naranjas...")
    
    while true do
        -- Pequeña pausa para no saturar
        task.wait(TIEMPO_ENTRE_BUSQUEDAS)
        
        -- Verificar que el personaje existe
        local character = getCharacter()
        if not character then
            warn("[Recolector] Personaje no encontrado, esperando...")
            task.wait(2)
            goto continuar
        end
        
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if not rootPart then
            goto continuar
        end
        
        -- Buscar bolas naranjas
        local bolas = buscarBolasNaranjas()
        
        if #bolas == 0 then
            print("[Recolector] No se encontraron bolas naranjas en el mapa")
            goto continuar
        end
        
        -- Procesar cada bola encontrada
        for _, bola in ipairs(bolas) do
            -- Calcular distancia
            local distancia = (rootPart.Position - bola.Position).Magnitude
            
            if distancia <= RADIO_BUSQUEDA then
                -- Cerca: recoger
                recogerBola(bola)
                task.wait(0.3)  -- Pequeña pausa entre recolecciones
            else
                -- Lejos: moverse hacia ella
                moverHacia(bola.Position)
                task.wait(0.5)
            end
        end
        
        ::continuar::
    end
end

-- ===== EJECUCIÓN =====
print("========================================")
print("   RECOLECTOR DE BOLAS NARANJAS")
print("   VERSIÓN EDUCATIVA - SOLO SIMULACIÓN")
print("========================================")
print("⚠️ Este script NO funciona realmente.")
print("⚠️ Es solo una plantilla para entender la lógica.")
print("")

-- Descomentar la línea de abajo para ejecutar (solo simulación)
-- iniciarRecolector()
