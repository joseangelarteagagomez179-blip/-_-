--// Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

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

--// Functions
local function AutoKickPerfect()
    pcall(function()
        -- Buscar la barra de poder o el boton de patear
        for _, v in pairs(getgc(true)) do
            if type(v) == "function" and debug.info(v, 'n'):find("Kick") or debug.info(v, 's'):find("Kick") then
                -- Simular click en el momento justo (perfect)
                v()
                break
            end
        end
        
        -- Metodo alternativo: Clickear el boton de la UI del juego
        local PlayerGui = LocalPlayer.PlayerGui
        if PlayerGui then
            for _, Gui in pairs(PlayerGui:GetDescendants()) do
                if Gui:IsA("TextButton") or Gui:IsA("ImageButton") then
                    if Gui.Name:lower():find("kick") or Gui.Text:lower():find("kick") then
                        Gui.MouseButton1Click:Fire()
                        task.wait(0.1)
                        Gui.MouseButton1Click:Fire() -- Doble click para asegurar el perfect
                        break
                    end
                end
            end
        end
    end)
end

local function CollectCups()
    pcall(function()
        Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
        
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

--// Toggle Events
ButtonKick.MouseButton1Click:Connect(function()
    AutoKickEnabled = not AutoKickEnabled
    if AutoKickEnabled then
        ButtonKick.Text = "Stop Kick"
        ButtonKick.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        ConnectionKick = RunService.Heartbeat:Connect(AutoKickPerfect)
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

--// Animacion de entrada
MainFrame.Visible = false
MainFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
MainFrame.Visible = true
local Tween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.05, 0, 0.3, 0)})
Tween:Play()

print("✅ Script Cargado - JoseAngel_Blox | Block Cup")
