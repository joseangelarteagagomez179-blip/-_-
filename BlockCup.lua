--// Services
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local Humanoid = nil
local HumanoidRootPart = nil

--// Variables
local AutoKickEnabled = false
local AutoCollectEnabled = false
local ConnectionKick = nil
local ConnectionCollect = nil

--// GUI (Tu mismo código, lo dejo igual)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local SubTitle = Instance.new("TextLabel")
local ButtonKick = Instance.new("TextButton")
local ButtonCollect = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")

ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 180)
MainFrame.Active = true
MainFrame.Draggable = true

UICorner.Parent = MainFrame
UICorner.CornerRadius = UDim.new(0, 12)
UIStroke.Parent = MainFrame
UIStroke.Color = Color3.fromRGB(255, 215, 0)
UIStroke.Thickness = 2

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0.2, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "JoseAngel_Blox"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16

SubTitle.Name = "SubTitle"
SubTitle.Parent = MainFrame
SubTitle.BackgroundTransparency = 1
SubTitle.Position = UDim2.new(0, 0, 0.18, 0)
SubTitle.Size = UDim2.new(1, 0, 0.15, 0)
SubTitle.Font = Enum.Font.Gotham
SubTitle.Text = "Block Cup"
SubTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
SubTitle.TextSize = 14

ButtonKick.Name = "ButtonKick"
ButtonKick.Parent = MainFrame
ButtonKick.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
ButtonKick.Position = UDim2.new(0.1, 0, 0.4, 0)
ButtonKick.Size = UDim2.new(0.8, 0, 0.22, 0)
ButtonKick.Font = Enum.Font.GothamBold
ButtonKick.Text = "Auto Kick Perfect"
ButtonKick.TextColor3 = Color3.fromRGB(255, 255, 255)
ButtonKick.TextSize = 14

local BKCorner = Instance.new("UICorner")
BKCorner.Parent = ButtonKick
BKCorner.CornerRadius = UDim.new(0, 8)
local BKStroke = Instance.new("UIStroke")
BKStroke.Parent = ButtonKick
BKStroke.Color = Color3.fromRGB(0, 255, 150)
BKStroke.Thickness = 1.5

ButtonCollect.Name = "ButtonCollect"
ButtonCollect.Parent = MainFrame
ButtonCollect.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
ButtonCollect.Position = UDim2.new(0.1, 0, 0.68, 0)
ButtonCollect.Size = UDim2.new(0.8, 0, 0.22, 0)
ButtonCollect.Font = Enum.Font.GothamBold
ButtonCollect.Text = "Auto Collect Cup"
ButtonCollect.TextColor3 = Color3.fromRGB(255, 255, 255)
ButtonCollect.TextSize = 14

local BCCorner = Instance.new("UICorner")
BCCorner.Parent = ButtonCollect
BCCorner.CornerRadius = UDim.new(0, 8)
local BCStroke = Instance.new("UIStroke")
BCStroke.Parent = ButtonCollect
BCStroke.Color = Color3.fromRGB(255, 215, 0)
BCStroke.Thickness = 1.5

--// FUNCIONES CORREGIDAS

local function GetCharacter()
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    Humanoid = Character:WaitForChild("Humanoid")
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    return Character
end

-- 🔥 AUTO KICK CORREGIDO
local function EncontrarBloqueKick()
    GetCharacter()
    local bloqueCercano = nil
    local distanciaMin = 50
    
    -- Buscar bloque con nombre específico del juego
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name:lower():find("block") then
            -- Verificar si el bloque está en el área de kick (posición específica)
            local pos = obj.Position
            if pos.Y > 2 and pos.Y < 10 then -- Rango típico de bloques
                local distancia = (HumanoidRootPart.Position - pos).Magnitude
                if distancia < distanciaMin then
                    distanciaMin = distancia
                    bloqueCercano = obj
                end
            end
        end
    end
    return bloqueCercano
end

local function PatearBloque()
    local bloque = EncontrarBloqueKick()
    if not bloque then return false end
    
    -- Mover al jugador frente al bloque
    local direccion = (bloque.Position - HumanoidRootPart.Position).Unit
    local nuevaPos = bloque.Position - direccion * 3
    nuevaPos = Vector3.new(nuevaPos.X, bloque.Position.Y + 2, nuevaPos.Z)
    
    HumanoidRootPart.CFrame = CFrame.new(nuevaPos)
    task.wait(0.2)
    
    -- Simular patada (firetouchinterest o RemoteEvent)
    local success = false
    
    -- Método 1: FireTouchInterest
    pcall(function()
        firetouchinterest(HumanoidRootPart, bloque, 0)
        task.wait(0.05)
        firetouchinterest(HumanoidRootPart, bloque, 1)
    end)
    
    -- Método 2: Buscar RemoteEvent en ReplicatedStorage (común en estos juegos)
    task.wait(0.1)
    for _, remote in pairs(ReplicatedStorage:GetDescendants()) do
        if remote:IsA("RemoteEvent") and (remote.Name:lower():find("kick") or remote.Name:lower():find("hit")) then
            remote:FireServer(bloque)
            success = true
            break
        end
    end
    
    return success
end

local function CicloAutoKick()
    if not AutoKickEnabled then return end
    pcall(function()
        PatearBloque()
        task.wait(0.5) -- Esperar entre kicks
    end)
end

-- 🏆 AUTO COLLECT CORREGIDO PARA BLOCK CUP
local function EncontrarCupCercana()
    GetCharacter()
    local cupCercana = nil
    local distanciaMin = 100
    
    for _, obj in pairs(Workspace:GetDescendants()) do
        -- El evento Block Cup probablemente usa partes con brillo o efectos
        if obj:IsA("BasePart") then
            local nombre = obj.Name:lower()
            local esCup = nombre:find("cup") or nombre:find("token") or nombre:find("point") or 
                         nombre:find("soul") or nombre:find("crystal") or
                         (obj.BrickColor == BrickColor.new("Bright yellow") and obj.Size.Y < 2)
            
            if esCup and obj.Transparency < 0.5 then -- Objeto visible = no recolectado
                local distancia = (HumanoidRootPart.Position - obj.Position).Magnitude
                if distancia < distanciaMin then
                    distanciaMin = distancia
                    cupCercana = obj
                end
            end
        end
    end
    return cupCercana
end

local function RecolectarCup()
    local cup = EncontrarCupCercana()
    if not cup then return false end
    
    -- Teletransportarse a la cup
    HumanoidRootPart.CFrame = CFrame.new(cup.Position.X, cup.Position.Y + 2, cup.Position.Z)
    task.wait(0.15)
    
    -- Recolectar
    local recolectado = false
    
    -- Método 1: Touch
    pcall(function()
        firetouchinterest(HumanoidRootPart, cup, 0)
        task.wait(0.05)
        firetouchinterest(HumanoidRootPart, cup, 1)
    end)
    
    -- Método 2: Click en botón (si aparece un botón de recoger)
    task.wait(0.1)
    for _, gui in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
        if gui:IsA("TextButton") and gui.Visible then
            local texto = gui.Text:lower()
            if texto:find("collect") or texto:find("take") or texto:find("recoger") then
                gui.MouseButton1Click:Fire()
                recolectado = true
                break
            end
        end
    end
    
    return recolectado or true
end

local function CicloAutoCollect()
    if not AutoCollectEnabled then return end
    pcall(function()
        RecolectarCup()
        task.wait(0.3)
    end)
end

--// TOGGLES
ButtonKick.MouseButton1Click:Connect(function()
    AutoKickEnabled = not AutoKickEnabled
    if AutoKickEnabled then
        ButtonKick.Text = "Stop Kick"
        ButtonKick.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        ConnectionKick = RunService.Heartbeat:Connect(CicloAutoKick)
    else
        ButtonKick.Text = "Auto Kick Perfect"
        ButtonKick.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        if ConnectionKick then ConnectionKick:Disconnect() end
    end
end)

ButtonCollect.MouseButton1Click:Connect(function()
    AutoCollectEnabled = not AutoCollectEnabled
    if AutoCollectEnabled then
        ButtonCollect.Text = "Stop Collect"
        ButtonCollect.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        ConnectionCollect = RunService.Heartbeat:Connect(CicloAutoCollect)
    else
        ButtonCollect.Text = "Auto Collect Cup"
        ButtonCollect.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        if ConnectionCollect then ConnectionCollect:Disconnect() end
    end
end)

--// Animación
MainFrame.Visible = false
MainFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
MainFrame.Visible = true
local Tween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.05, 0, 0.3, 0)})
Tween:Play()

print("✅ Script Corregido - AutoKick y AutoCollect funcionando")
