local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local function collectOrangeBalls()
    -- 1. Buscar el personaje del jugador
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    local hrp = character.HumanoidRootPart
    
    -- 2. Buscar todas las 'orange balls' en el mapa
    local orangeBalls = workspace:GetDescendants()
    local nearestBall = nil
    local shortestDistance = 30 -- Radio de recolección en studs
    
    for _, obj in ipairs(orangeBalls) do
        -- 3. Identificar las pelotas (usa el nombre o clase correcta)
        if (obj.Name:lower():find("orange") or obj.Name:lower():find("ball")) and obj:IsA("BasePart") then
            local distance = (hrp.Position - obj.Position).Magnitude
            if distance < shortestDistance then
                nearestBall = obj
                shortestDistance = distance
            end
        end
    end
    
    -- 4. Moverse hacia la pelota más cercana
    if nearestBall then
        -- Teletransportarse directamente (puede ser detectado)
        -- hrp.CFrame = nearestBall.CFrame
        
        -- Opción más segura: mover al jugador hacia el objeto
        local direction = (nearestBall.Position - hrp.Position).Unit
        hrp.Velocity = direction * 50 -- Ajusta la velocidad
    end
end

-- Bucle de recolección
RunService.Heartbeat:Connect(function()
    collectOrangeBalls()
end)
