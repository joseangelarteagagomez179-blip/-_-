--// Services
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

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

local function IrAlAreaYPatear()
    pcall(function()
        GetCharacter()
        
        -- 1. IR HACIA EL BLOQUE / AREA
        for _, Obj in pairs(Workspace:GetDescendants()) do
            -- Buscamos la zona amarilla o el bloque principal
            if Obj.Name:lower():find("kick") or Obj.Name:lower():find("block") or Obj.BrickColor.Name == "New yellow" or Obj.BrickColor.Name == "Bright yellow" then
                if Obj:IsA("Part") then
                    -- Ir suavemente hacia alli
                    local Tween = TweenService:Create(HumanoidRootPart, TweenInfo.new(0.5), {CFrame = Obj.CFrame * CFrame.new(0, 0, -2)})
                    Tween:Play()
                    task.wait(0.6)
                    break
                end
            end
        end
        
        -- 2. BUSCAR LA BARRA Y DAR EN PERFECTO
        local Barra = nil
        for _, Gui in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
            if Gui:IsA("Frame") and (Gui.Name:lower():find("power") or Gui.Name:lower():find("bar") or Gui.Name:lower():find("progress")) then
                Barra = Gui
                break
            end
        end
        
        if Barra and Barra:FindFirstChildOfClass("UIGradient") or Barra:FindFirstChildOfClass("Frame") then
            -- Simular click justo cuando la barra esta al maximo (Perfect)
            fireclickdetector(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants(), 1) -- Truco para activar el click
            
            -- Metodo seguro: Clickear cualquier boton de kick en pantalla
            for _, Boton in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
                if Boton:IsA("TextButton") or Boton:IsA("ImageButton") then
                    if Boton.Visible and (Boton.Name:lower():find("kick") or Boton.Text:lower():find("kick")) then
                        Boton.MouseButton1Click:Fire()
                        task.wait(0.05)
                        Boton.MouseButton1Click:Fire()
                        break
                    end
                end
            end
        end
        
    end)
end

local function CollectCups()
    pcall(function()
        GetCharacter()
        for _, Obj in pairs(Workspace:GetDescendants()) do
            if (Obj:IsA("Part") or Obj:IsA("MeshPart")) and (Obj.Name:lower():find("cup") or Obj.Name:lower():find("trophy") or Obj.Name:lower():find("coin") or Obj.Name:lower():find("token")) then
                if (HumanoidRootPart.Position - Obj.Position).Magnitude < 60 then
                    firetouchinterest(HumanoidRootPart, Obj, 0)
                    firetouchinterest(HumanoidRootPart, Obj, 1)
                end
            end
        end
    end)
end

--// TOGGLES
ButtonKick.MouseButton1Click:Connect(function()
    AutoKickEnabled = not AutoKickEnabled
    if AutoKickEnabled then
        ButtonKick.Text = "Stop Kick"
        ButtonKick.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        ConnectionKick = RunService.Heartbeat:Connect(IrAlAreaYPatear)
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
        ConnectionCollect = RunService.Heartbeat:Connect(CollectCups)
    else
        ButtonCollect.Text = "Auto Collect Cup"
        ButtonCollect.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        if ConnectionCollect then ConnectionCollect:Disconnect() end
    end
end)

--// Animacion
MainFrame.Visible = false
MainFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
MainFrame.Visible = true
local Tween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.05, 0, 0.3, 0)})
Tween:Play()

print("✅ Script Cargado - JoseAngel_Blox")
