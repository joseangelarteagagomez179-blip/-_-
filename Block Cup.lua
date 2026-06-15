--// Services
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")

local LocalPlayer = Players.LocalPlayer
local Humanoid = nil
local HumanoidRootPart = nil

--// Variables
local AutoKickEnabled = false
local AutoCollectEnabled = false
local ConnectionKick = nil
local ConnectionCollect = nil

--// GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local SubTitle = Instance.new("TextLabel")
local ButtonKick = Instance.new("TextButton")
local ButtonCollect = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")

--// Properties
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

--// Title
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

--// Button Kick
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

--// Button Collect
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

--// FUNCTIONS

local function GetCharacter()
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    Humanoid = Character:WaitForChild("Humanoid")
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    return Character
end

local function IrAlBloque()
    GetCharacter()
    local BlockPos = nil
    
    -- BUSCAR EL BLOQUE O ZONA AMARILLA
    for _, Obj in pairs(Workspace:GetDescendants()) do
        if Obj:IsA("Part") then
            if Obj.Name:lower():find("kick") or Obj.Name:lower():find("block") or Obj.BrickColor == BrickColor.new("New yellow") or Obj.BrickColor == BrickColor.new("Bright yellow") then
                BlockPos = Obj.Position
                break
            end
        end
    end
    
    if BlockPos then
        -- MÉTODO 1: TELETRANSPORTE SUAVE (FUNCIONA DONDE MoveTo FALLA)
        HumanoidRootPart.CFrame = CFrame.new(BlockPos.X, BlockPos.Y + 3, BlockPos.Z - 2.5)
        return true
    end
    return false
end

local function PatearPerfecto()
    -- MÉTODO DIRECTO: BUSCAR EL BOTON Y DARLE CLICK
    for _, GuiObj in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
        if GuiObj:IsA("TextButton") or GuiObj:IsA("ImageButton") then
            if GuiObj.Visible and (GuiObj.Name:lower():find("kick") or GuiObj.Text:lower():find("kick") or GuiObj.Name:lower():find("power")) then
                -- Click rapido para dar en el momento justo
                GuiObj.MouseButton1Click:Fire()
                task.wait(0.05)
                GuiObj.MouseButton1Click:Fire()
                break
            end
        end
    end
end

local function CicloDeKick()
    sp(function()
        if IrAlBloque() then
            task.wait(0.3) -- Esperar a llegar
            PatearPerfecto()
        end
    end)
end

-- ==============================================
-- 🆕 FUNCIÓN NUEVA: IR Y RECOGER BLOCK CUPS
-- ==============================================
local function IrYRecogerCups()
    pcall(function()
        GetCharacter()
        local MasCercana = nil
        local DistanciaMinima = math.huge -- Infinito
        
        -- 1. BUSCAR TODAS LAS COPAS Y VER CUAL ESTA MAS CERCA
        for _, Obj in pairs(Workspace:GetDescendants()) do
            if (Obj:IsA("Part") or Obj:IsA("MeshPart")) and (Obj.Name:lower():find("cup") or Obj.Name:lower():find("trophy") or Obj.Name:lower():find("coin") or Obj.Name:lower():find("token")) then
                
                local Distancia = (HumanoidRootPart.Position - Obj.Position).Magnitude
                
                -- Si esta copa esta mas cerca que la anterior, la guardamos
                if Distancia < DistanciaMinima then
                    DistanciaMinima = Distancia
                    MasCercana = Obj
                end
            end
        end
        
        -- 2. SI ENCONTRAMOS UNA, NOS MOVEMOS HACIA ELLA
        if MasCercana and DistanciaMinima < 100 then -- Rango maximo
            -- Teletransportarse suavemente hacia la copa
            HumanoidRootPart.CFrame = CFrame.new(MasCercana.Position.X, MasCercana.Position.Y + 2, MasCercana.Position.Z)
            
            task.wait(0.2) -- Esperar a llegar
            
            -- 3. RECOGER LA COPA
            firetouchinterest(HumanoidRootPart, MasCercana, 0)
            firetouchinterest(HumanoidRootPart, MasCercana, 1)
        end
        
    end)
end

--// TOGGLES
ButtonKick.MouseButton1Click:Connect(function()
    AutoKickEnabled = not AutoKickEnabled
    if AutoKickEnabled then
        ButtonKick.Text = "Stop Kick"
        ButtonKick.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        ConnectionKick = RunService.Heartbeat:Connect(CicloDeKick)
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
        ConnectionCollect = RunService.Heartbeat:Connect(IrYRecogerCups)
    else
        ButtonCollect.Text = "Auto Collect Cup"
        ButtonCollect.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        if ConnectionCollect then ConnectionCollect:Disconnect() end
    end
end)

--// Animacion de entrada
MainFrame.Visible = false
MainFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
MainFrame.Visible = true
local Tween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.05, 0, 0.3, 0)})
Tween:Play()

print("✅ Script Cargado - JoseAngel_Blox | FUNCIONANDO")
