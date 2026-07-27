-- ==========================================
-- SISTEMA DE BÚSQUEDA AUTOMÁTICA
-- ==========================================

local function FindGameFunctions()
    print("=== 🔍 BUSCANDO FUNCIONES DEL JUEGO ===")
    print("")
    
    local found = {
        Kick = {},
        Rebirth = {},
        Train = {},
        Buy = {},
        Collect = {}
    }
    
    -- 1. BUSCAR EN REPLICATEDSTORAGE
    local RS = game:GetService("ReplicatedStorage")
    print("📁 Buscando en ReplicatedStorage...")
    
    for i, child in pairs(RS:GetDescendants()) do
        -- Buscar RemoteEvents/RemoteFunctions
        if child:IsA("RemoteEvent") or child:IsA("RemoteFunction") then
            local name = child.Name
            if string.find(string.lower(name), "kick") then
                table.insert(found.Kick, "Remote: " .. child:GetFullName())
            elseif string.find(string.lower(name), "rebirth") then
                table.insert(found.Rebirth, "Remote: " .. child:GetFullName())
            elseif string.find(string.lower(name), "train") or string.find(string.lower(name), "weight") then
                table.insert(found.Train, "Remote: " .. child:GetFullName())
            elseif string.find(string.lower(name), "buy") or string.find(string.lower(name), "purchase") then
                table.insert(found.Buy, "Remote: " .. child:GetFullName())
            end
        end
        
        -- Buscar ModuleScripts
        if child:IsA("ModuleScript") then
            local success, module = pcall(function()
                return require(child)
            end)
            
            if success and type(module) == "table" then
                for key, value in pairs(module) do
                    if type(value) == "function" then
                        local lowerKey = string.lower(key)
                        if string.find(lowerKey, "kick") then
                            table.insert(found.Kick, "Module " .. child.Name .. "." .. key .. " (en " .. child.Parent.Name .. ")")
                        elseif string.find(lowerKey, "rebirth") then
                            table.insert(found.Rebirth, "Module " .. child.Name .. "." .. key .. " (en " .. child.Parent.Name .. ")")
                        elseif string.find(lowerKey, "train") or string.find(lowerKey, "weight") then
                            table.insert(found.Train, "Module " .. child.Name .. "." .. key .. " (en " .. child.Parent.Name .. ")")
                        elseif string.find(lowerKey, "buy") or string.find(lowerKey, "purchase") then
                            table.insert(found.Buy, "Module " .. child.Name .. "." .. key .. " (en " .. child.Parent.Name .. ")")
                        end
                    end
                end
            end
        end
    end
    
    -- 2. BUSCAR EN WORKSPACE
    print("📁 Buscando en Workspace...")
    for i, child in pairs(workspace:GetDescendants()) do
        if child:IsA("BasePart") and string.find(string.lower(child.Name), "button") then
            print("  🟢 Botón físico:", child.Name, "en", child.Parent.Name)
        end
        if child:IsA("ProximityPrompt") then
            print("  🟢 Prompt:", child.ActionText, "en", child.Parent.Name)
        end
    end
    
    -- 3. BUSCAR EN PLAYERGUI
    print("📁 Buscando en PlayerGui...")
    local player = game.Players.LocalPlayer
    if player and player.PlayerGui then
        for i, child in pairs(player.PlayerGui:GetDescendants()) do
            if child:IsA("TextButton") or child:IsA("ImageButton") then
                if string.find(string.lower(child.Text or ""), "kick") then
                    print("  🟢 Botón GUI:", child.Text, "en", child.Parent.Name)
                end
            end
        end
    end
    
    -- 4. MOSTRAR RESULTADOS
    print("")
    print("=== 📊 RESULTADOS DE LA BÚSQUEDA ===")
    
    for category, items in pairs(found) do
        print("")
        print("🔹 " .. category .. ":")
        if #items > 0 then
            for _, item in pairs(items) do
                print("  ✅ " .. item)
            end
        else
            print("  ❌ No encontrado")
        end
    end
    
    -- 5. RECOMENDACIONES
    print("")
    print("=== 💡 RECOMENDACIONES ===")
    if #found.Kick > 0 then
        print("✅ Para KICK usa: " .. found.Kick[1])
    else
        print("❌ No encontré funciones de Kick. Busca manualmente en Dark Explorer.")
    end
    
    if #found.Rebirth > 0 then
        print("✅ Para REBIRTH usa: " .. found.Rebirth[1])
    else
        print("❌ No encontré funciones de Rebirth. Busca manualmente en Dark Explorer.")
    end
end

-- EJECUTAR LA BÚSQUEDA
FindGameFunctions()
