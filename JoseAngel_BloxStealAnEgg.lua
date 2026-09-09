-- =================================================================
-- SCRIPT: JoseAngel_Blox Steal An Egg
-- Creado por: JoseAngel_Blox
-- Fecha: 08/09/2026 | Versión: 1.1
-- =================================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

-- Eliminar versión previa si existía en pantalla
if CoreGui:FindFirstChild("JoseAngel_StealAnEgg") then
    CoreGui:FindFirstChild("JoseAngel_StealAnEgg"):Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_StealAnEgg"
ScreenGui.ResetOnSpawn = false

pcall(function()
    ScreenGui.Parent = CoreGui
end)
if not ScreenGui.Parent then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

--------------------------------------------------------------------
-- 1. PANTALLA DE CARGA (LOADING SCREEN)
--------------------------------------------------------------------
local LoadingFrame = Instance.new("Frame")
LoadingFrame.Name = "LoadingFrame"
LoadingFrame.Size = UDim2.new(0, 380, 0, 180)
LoadingFrame.Position = UDim2.new(0.5, -190, 0.5, -90)
LoadingFrame.BackgroundColor3 = Color3.fromRGB(10, 16, 32)
LoadingFrame.BorderSizePixel = 0
LoadingFrame.Parent = ScreenGui

local LoadingCorner = Instance.new("UICorner")
LoadingCorner.CornerRadius = UDim.new(0, 14)
LoadingCorner.Parent = LoadingFrame

local LoadingStroke = Instance.new("UIStroke")
LoadingStroke.Color = Color3.fromRGB(0, 140, 255)
LoadingStroke.Thickness = 1.5
LoadingStroke.Parent = LoadingFrame

local WelcomeLabel = Instance.new("TextLabel")
WelcomeLabel.Size = UDim2.new(1, -20, 0, 40)
WelcomeLabel.Position = UDim2.new(0, 10, 0, 20)
WelcomeLabel.BackgroundTransparency = 1
WelcomeLabel.Text = "Bienvenidos a Script JoseAngel_Blox"
WelcomeLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
WelcomeLabel.TextSize = 18
WelcomeLabel.Font = Enum.Font.GothamBold
WelcomeLabel.TextWrapped = true
WelcomeLabel.Parent = LoadingFrame

local ProgressBarBG = Instance.new("Frame")
ProgressBarBG.Size = UDim2.new(0.85, 0, 0, 18)
ProgressBarBG.Position = UDim2.new(0.075, 0, 0.55, 0)
ProgressBarBG.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
ProgressBarBG.BorderSizePixel = 0
ProgressBarBG.Parent = LoadingFrame

local BarCorner = Instance.new("UICorner")
BarCorner.CornerRadius = UDim.new(0, 9)
BarCorner.Parent = ProgressBarBG

local ProgressBarFill = Instance.new("Frame")
ProgressBarFill.Size = UDim2.new(0, 0, 1, 0)
ProgressBarFill.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
ProgressBarFill.BorderSizePixel = 0
ProgressBarFill.Parent = ProgressBarBG

local FillCorner = Instance.new("UICorner")
FillCorner.CornerRadius = UDim.new(0, 9)
FillCorner.Parent = ProgressBarFill

local ProgressText = Instance.new("TextLabel")
ProgressText.Size = UDim2.new(1, 0, 0, 20)
ProgressText.Position = UDim2.new(0, 0, 0.78, 0)
ProgressText.BackgroundTransparency = 1
ProgressText.Text = "0%"
ProgressText.TextColor3 = Color3.fromRGB(200, 220, 255)
ProgressText.TextSize = 14
ProgressText.Font = Enum.Font.GothamMedium
ProgressText.Parent = LoadingFrame

--------------------------------------------------------------------
-- 2. MARCO PRINCIPAL DE LA VENTANA (MAIN GUI)
--------------------------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 560, 0, 360)
MainFrame.Position = UDim2.new(0.5, -280, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 16, 32) -- Fondo Azul Marino
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 14)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(0, 120, 230)
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

-- TÍTULO CON EFECTO ANIMADO DE MOVIMIENTO EN LETRAS AZULES
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, -20, 0, 30)
TitleLabel.Position = UDim2.new(0, 15, 0, 10)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "JoseAngel_Blox Steal An Egg"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 22
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = MainFrame

local TitleGradient = Instance.new("UIGradient")
TitleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 170, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(120, 230, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 100, 255))
})
TitleGradient.Parent = TitleLabel

local rot = 0
RunService.RenderStepped:Connect(function(dt)
    rot = (rot + dt * 120) % 360
    TitleGradient.Rotation = rot
end)

-- SUBTÍTULO EN LETRAS TRANSPARENTES
local SubtitleLabel = Instance.new("TextLabel")
SubtitleLabel.Size = UDim2.new(1, -20, 0, 18)
SubtitleLabel.Position = UDim2.new(0, 15, 0, 38)
SubtitleLabel.BackgroundTransparency = 1
SubtitleLabel.Text = "creado por JoseAngel_Blox"
SubtitleLabel.TextColor3 = Color3.fromRGB(150, 180, 220)
SubtitleLabel.TextTransparency = 0.45
SubtitleLabel.TextSize = 13
SubtitleLabel.Font = Enum.Font.Gotham
SubtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
SubtitleLabel.Parent = MainFrame

local Line = Instance.new("Frame")
Line.Size = UDim2.new(1, -30, 0, 1)
Line.Position = UDim2.new(0, 15, 0, 62)
Line.BackgroundColor3 = Color3.fromRGB(25, 40, 70)
Line.BorderSizePixel = 0
Line.Parent = MainFrame

-- CONTENEDOR DE PESTAÑAS (IZQUIERDA)
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 130, 1, -75)
Sidebar.Position = UDim2.new(0, 15, 0, 68)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 23, 44)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 10)
SidebarCorner.Parent = Sidebar

local SidebarList = Instance.new("UIListLayout")
SidebarList.Padding = UDim.new(0, 8)
SidebarList.HorizontalAlignment = Enum.HorizontalAlignment.Center
SidebarList.SortOrder = Enum.SortOrder.LayoutOrder
SidebarList.Parent = Sidebar

local SidebarPadding = Instance.new("UIPadding")
SidebarPadding.PaddingTop = UDim.new(0, 10)
SidebarPadding.Parent = Sidebar

-- CONTENEDOR DE FUNCIONES (DERECHA)
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -170, 1, -75)
ContentFrame.Position = UDim2.new(0, 155, 0, 68)
ContentFrame.BackgroundColor3 = Color3.fromRGB(15, 23, 44)
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = MainFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 10)
ContentCorner.Parent = ContentFrame

--------------------------------------------------------------------
-- SISTEMA DE PESTAÑAS (TABS)
--------------------------------------------------------------------
local tabs = {}
local tabButtons = {}

local function CreateTab(name)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(0.9, 0, 0, 35)
    TabButton.BackgroundColor3 = Color3.fromRGB(22, 33, 60)
    TabButton.BorderSizePixel = 0
    TabButton.Text = name
    TabButton.TextColor3 = Color3.fromRGB(180, 200, 230)
    TabButton.Font = Enum.Font.GothamMedium
    TabButton.TextSize = 14
    TabButton.Parent = Sidebar

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 8)
    BtnCorner.Parent = TabButton

    local TabPage = Instance.new("ScrollingFrame")
    TabPage.Name = name .. "Page"
    TabPage.Size = UDim2.new(1, -16, 1, -16)
    TabPage.Position = UDim2.new(0, 8, 0, 8)
    TabPage.BackgroundTransparency = 1
    TabPage.BorderSizePixel = 0
    TabPage.ScrollBarThickness = 4
    TabPage.ScrollBarImageColor3 = Color3.fromRGB(0, 140, 255)
    TabPage.Visible = false
    TabPage.Parent = ContentFrame

    local PageList = Instance.new("UIListLayout")
    PageList.Padding = UDim.new(0, 8)
    PageList.SortOrder = Enum.SortOrder.LayoutOrder
    PageList.Parent = TabPage

    tabs[name] = TabPage
    tabButtons[name] = TabButton

    TabButton.MouseButton1Click:Connect(function()
        for tName, page in pairs(tabs) do
            page.Visible = (tName == name)
            tabButtons[tName].BackgroundColor3 = (tName == name) and Color3.fromRGB(0, 120, 230) or Color3.fromRGB(22, 33, 60)
            tabButtons[tName].TextColor3 = (tName == name) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 200, 230)
        end
    end)

    return TabPage
end

local InfoPage = CreateTab("Info")
local MainPage = CreateTab("Main")

tabs["Info"].Visible = true
tabButtons["Info"].BackgroundColor3 = Color3.fromRGB(0, 120, 230)
tabButtons["Info"].TextColor3 = Color3.fromRGB(255, 255, 255)

--------------------------------------------------------------------
-- PESTAÑA 1: INFO
--------------------------------------------------------------------
local function AddInfoLabel(title, text)
    local Card = Instance.new("Frame")
    Card.Size = UDim2.new(1, -10, 0, 45)
    Card.BackgroundColor3 = Color3.fromRGB(20, 30, 55)
    Card.BorderSizePixel = 0
    Card.Parent = InfoPage

    local CardCorner = Instance.new("UICorner")
    CardCorner.CornerRadius = UDim.new(0, 8)
    CardCorner.Parent = Card

    local TitleL = Instance.new("TextLabel")
    TitleL.Size = UDim2.new(1, -16, 0, 18)
    TitleL.Position = UDim2.new(0, 8, 0, 4)
    TitleL.BackgroundTransparency = 1
    TitleL.Text = title
    TitleL.TextColor3 = Color3.fromRGB(0, 170, 255)
    TitleL.Font = Enum.Font.GothamBold
    TitleL.TextSize = 13
    TitleL.TextXAlignment = Enum.TextXAlignment.Left
    TitleL.Parent = Card

    local TextL = Instance.new("TextLabel")
    TextL.Size = UDim2.new(1, -16, 0, 18)
    TextL.Position = UDim2.new(0, 8, 0, 22)
    TextL.BackgroundTransparency = 1
    TextL.Text = text
    TextL.TextColor3 = Color3.fromRGB(220, 230, 250)
    TextL.Font = Enum.Font.Gotham
    TextL.TextSize = 12
    TextL.TextXAlignment = Enum.TextXAlignment.Left
    TextL.Parent = Card
end

AddInfoLabel("Nombre del Creador:", "JoseAngel_Blox")
AddInfoLabel("Fecha de lanzamiento:", "08/09/2026")
AddInfoLabel("Versión:", "1.1")

local UpdateCard = Instance.new("Frame")
UpdateCard.Size = UDim2.new(1, -10, 0, 95)
UpdateCard.BackgroundColor3 = Color3.fromRGB(20, 30, 55)
UpdateCard.BorderSizePixel = 0
UpdateCard.Parent = InfoPage

local UpCorner = Instance.new("UICorner")
UpCorner.CornerRadius = UDim.new(0, 8)
UpCorner.Parent = UpdateCard

local UpTitle = Instance.new("TextLabel")
UpTitle.Size = UDim2.new(1, -16, 0, 20)
UpTitle.Position = UDim2.new(0, 8, 0, 4)
UpTitle.BackgroundTransparency = 1
UpTitle.Text = "UPDATE:"
UpTitle.TextColor3 = Color3.fromRGB(0, 170, 255)
UpTitle.Font = Enum.Font.GothamBold
UpTitle.TextSize = 13
UpTitle.TextXAlignment = Enum.TextXAlignment.Left
UpTitle.Parent = UpdateCard

local UpText = Instance.new("TextLabel")
UpText.Size = UDim2.new(1, -16, 0, 65)
UpText.Position = UDim2.new(0, 8, 0, 24)
UpText.BackgroundTransparency = 1
UpText.Text = "Nuevo script para Steal An Egg este es un script básico para aprender a usar un script para este juego espero y lo disfrutes mucho.."
UpText.TextColor3 = Color3.fromRGB(220, 230, 250)
UpText.Font = Enum.Font.Gotham
UpText.TextSize = 11
UpText.TextWrapped = true
UpText.TextXAlignment = Enum.TextXAlignment.Left
UpText.TextYAlignment = Enum.TextYAlignment.Top
UpText.Parent = UpdateCard

--------------------------------------------------------------------
-- PESTAÑA 2: MAIN (TOGGLES Y FUNCIONES)
--------------------------------------------------------------------
local function CreateToggle(parent, name, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -10, 0, 40)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(20, 30, 55)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = parent

    local TCorner = Instance.new("UICorner")
    TCorner.CornerRadius = UDim.new(0, 8)
    TCorner.Parent = ToggleFrame

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(230, 240, 255)
    Label.Font = Enum.Font.GothamMedium
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 48, 0, 24)
    Button.Position = UDim2.new(1, -58, 0.5, -12)
    Button.BackgroundColor3 = Color3.fromRGB(40, 50, 75)
    Button.BorderSizePixel = 0
    Button.Text = ""
    Button.Parent = ToggleFrame

    local BCorner = Instance.new("UICorner")
    BCorner.CornerRadius = UDim.new(1, 0)
    BCorner.Parent = Button

    local Circle = Instance.new("Frame")
    Circle.Size = UDim2.new(0, 18, 0, 18)
    Circle.Position = UDim2.new(0, 3, 0.5, -9)
    Circle.BackgroundColor3 = Color3.fromRGB(200, 210, 230)
    Circle.BorderSizePixel = 0
    Circle.Parent = Button

    local CCorner = Instance.new("UICorner")
    CCorner.CornerRadius = UDim.new(1, 0)
    CCorner.Parent = Circle

    local enabled = false
    Button.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 150, 255)}):Play()
            TweenService:Create(Circle, TweenInfo.new(0.2), {Position = UDim2.new(1, -21, 0.5, -9)}):Play()
        else
            TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 50, 75)}):Play()
            TweenService:Create(Circle, TweenInfo.new(0.2), {Position = UDim2.new(0, 3, 0.5, -9)}):Play()
        end
        task.spawn(function()
            callback(enabled)
        end)
    end)
end

-- 1. Auto Robar Huevos
local autoRobEnabled = false
CreateToggle(MainPage, "Auto Robar Huevos", function(state)
    autoRobEnabled = state
    while autoRobEnabled do
        pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if not autoRobEnabled then break end
                    if obj:IsA("ProximityPrompt") and (obj.Parent.Name:lower():find("egg") or obj.Parent.Name:lower():find("huevo")) then
                        char.HumanoidRootPart.CFrame = obj.Parent:GetPivot()
                        fireproximityprompt(obj)
                        task.wait(0.3)
                    end
                end
            end
        end)
        task.wait(0.5)
    end
end)

-- 2. Auto Eclosionar
local autoHatchEnabled = false
CreateToggle(MainPage, "Auto Eclosionar", function(state)
    autoHatchEnabled = state
    while autoHatchEnabled do
        pcall(function()
            for _, obj in pairs(Workspace:GetDescendants()) do
                if not autoHatchEnabled then break end
                if obj:IsA("ProximityPrompt") and (obj.Parent.Name:lower():find("hatch") or obj.Parent.Name:lower():find("incub")) then
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = obj.Parent:GetPivot()
                        fireproximityprompt(obj)
                    end
                end
            end
        end)
        task.wait(1)
    end
end)

-- 3. Velocidad x3
local normalSpeed = 16
CreateToggle(MainPage, "Velocidad x3", function(state)
    if state then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 48
        end
    else
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = normalSpeed
        end
    end
end)

-- 4. ESP Huevos
local espHighlights = {}
CreateToggle(MainPage, "ESP Huevos", function(state)
    if state then
        pcall(function()
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("Model") and (obj.Name:lower():find("egg") or obj.Name:lower():find("huevo")) then
                    if not obj:FindFirstChild("EggHighlight") then
                        local hl = Instance.new("Highlight")
                        hl.Name = "EggHighlight"
                        hl.FillColor = Color3.fromRGB(0, 180, 255)
                        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                        hl.FillTransparency = 0.4
                        hl.Parent = obj
                        table.insert(espHighlights, hl)
                    end
                end
            end
        end)
    else
        for _, hl in pairs(espHighlights) do
            if hl then hl:Destroy() end
        end
        espHighlights = {}
    end
end)

-- 5. Auto Vender Mascotas
local autoSellEnabled = false
CreateToggle(MainPage, "Auto Vender Mascotas", function(state)
    autoSellEnabled = state
    while autoSellEnabled do
        print("[JoseAngel_Blox] Buscando mascotas para vender...")
        task.wait(2)
    end
end)

-- 6. Auto Cinta de Correr
local autoTreadmillEnabled = false
CreateToggle(MainPage, "Auto Cinta de Correr", function(state)
    autoTreadmillEnabled = state
    while autoTreadmillEnabled do
        pcall(function()
            for _, obj in pairs(Workspace:GetDescendants()) do
                if not autoTreadmillEnabled then break end
                if obj.Name:lower():find("treadmill") or obj.Name:lower():find("cinta") then
                    if obj:IsA("ProximityPrompt") then
                        fireproximityprompt(obj)
                    elseif obj:IsA("BasePart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame + Vector3.new(0, 3, 0)
                    end
                end
            end
        end)
        task.wait(1)
    end
end)

--------------------------------------------------------------------
-- ANIMACIÓN DE CARGA (1% -> 100%) Y APERTURA
--------------------------------------------------------------------
task.spawn(function()
    for i = 1, 100 do
        ProgressBarFill.Size = UDim2.new(i / 100, 0, 1, 0)
        ProgressText.Text = i .. "%"
        task.wait(0.025)
    end

    TweenService:Create(LoadingFrame, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
    task.wait(0.4)
    LoadingFrame:Destroy()

    MainFrame.Visible = true
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 560, 0, 360),
        Position = UDim2.new(0.5, -280, 0.5, -180)
    }):Play()
end)
