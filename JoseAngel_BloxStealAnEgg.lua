--==============================================================
-- SCRIPT: JoseAngel_Blox Steal An Huevo v1.4
-- Creado por JoseAngel_Blox
--==============================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local oldGui = PlayerGui:FindFirstChild("JoseAngel_Blox_StealAnEgg")
if oldGui then oldGui:Destroy() end

--==============================================================
-- INTERFAZ
--==============================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JoseAngel_Blox_StealAnEgg"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 380, 0, 260)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -130)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local mc = Instance.new("UICorner"); mc.CornerRadius = UDim.new(0, 12); mc.Parent = MainFrame
local ms = Instance.new("UIStroke"); ms.Color = Color3.fromRGB(0, 150, 255); ms.Thickness = 2; ms.Parent = MainFrame

-- TÍTULO
local TitleFrame = Instance.new("Frame")
TitleFrame.Size = UDim2.new(1, 0, 0, 42)
TitleFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
TitleFrame.BorderSizePixel = 0
TitleFrame.Parent = MainFrame
local tc = Instance.new("UICorner"); tc.CornerRadius = UDim.new(0, 12); tc.Parent = TitleFrame
local tp = Instance.new("Frame"); tp.Size = UDim2.new(1, 0, 0, 12); tp.Position = UDim2.new(0, 0, 1, -12); tp.BackgroundColor3 = Color3.fromRGB(15, 15, 25); tp.BorderSizePixel = 0; tp.Parent = TitleFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "JoseAngel_Blox Steal An Huevo"
TitleLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextScaled = true
TitleLabel.Parent = TitleFrame

task.spawn(function()
    local h = 0
    while ScreenGui.Parent do
        h = (h + 0.005) % 1
        TitleLabel.TextColor3 = Color3.fromHSV(h * 0.15 + 0.55, 1, 1)
        TitleLabel.Position = UDim2.new(0, math.sin(tick() * 2) * 2, 0, 0)
        task.wait(0.05)
    end
end)

local SubtitleLabel = Instance.new("TextLabel")
SubtitleLabel.Size = UDim2.new(1, 0, 0, 14)
SubtitleLabel.Position = UDim2.new(0, 0, 0, 40)
SubtitleLabel.BackgroundTransparency = 1
SubtitleLabel.Text = "Creado por JoseAngel_Blox"
SubtitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SubtitleLabel.TextTransparency = 0.5
SubtitleLabel.Font = Enum.Font.Gotham
SubtitleLabel.TextSize = 11
SubtitleLabel.Parent = MainFrame

-- PANEL IZQUIERDO
local TabPanel = Instance.new("Frame")
TabPanel.Size = UDim2.new(0, 100, 1, -75)
TabPanel.Position = UDim2.new(0, 8, 0, 58)
TabPanel.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
TabPanel.BorderSizePixel = 0
TabPanel.Parent = MainFrame
local tpc = Instance.new("UICorner"); tpc.CornerRadius = UDim.new(0, 8); tpc.Parent = TabPanel
local tl = Instance.new("UIListLayout"); tl.Padding = UDim.new(0, 4); tl.Parent = TabPanel
local tpad = Instance.new("UIPadding"); tpad.PaddingTop = UDim.new(0, 6); tpad.PaddingLeft = UDim.new(0, 4); tpad.PaddingRight = UDim.new(0, 4); tpad.Parent = TabPanel

-- PANEL DERECHO
local ContentPanel = Instance.new("Frame")
ContentPanel.Size = UDim2.new(1, -120, 1, -75)
ContentPanel.Position = UDim2.new(0, 112, 0, 58)
ContentPanel.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
ContentPanel.BorderSizePixel = 0
ContentPanel.Parent = MainFrame
local cpc = Instance.new("UICorner"); cpc.CornerRadius = UDim.new(0, 8); cpc.Parent = ContentPanel
local cpad = Instance.new("UIPadding"); cpad.PaddingTop = UDim.new(0, 6); cpad.PaddingLeft = UDim.new(0, 6); cpad.PaddingRight = UDim.new(0, 6); cpad.PaddingBottom = UDim.new(0, 6); cpad.Parent = ContentPanel

-- SISTEMA DE PESTAÑAS
local tabs = {}
local function createTab(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 12
    btn.BorderSizePixel = 0
    btn.Parent = TabPanel
    local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 6); c.Parent = btn

    local page = Instance.new("Frame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Parent = ContentPanel

    tabs[name] = { Button = btn, Page = page }
    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do
            t.Page.Visible = false
            t.Button.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
            t.Button.TextColor3 = Color3.fromRGB(200, 200, 200)
        end
        page.Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    return page
end

-- INFO
local infoPage = createTab("Info")
local iscroll = Instance.new("ScrollingFrame")
iscroll.Size = UDim2.new(1, 0, 1, 0); iscroll.BackgroundTransparency = 1; iscroll.BorderSizePixel = 0
iscroll.ScrollBarThickness = 4; iscroll.CanvasSize = UDim2.new(0, 0, 0, 300); iscroll.Parent = infoPage
local il = Instance.new("UIListLayout"); il.Padding = UDim.new(0, 4); il.Parent = iscroll

local function mkInfo(t, c, s)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -8, 0, s or 18)
    l.BackgroundTransparency = 1; l.Text = t
    l.TextColor3 = c or Color3.fromRGB(220, 220, 220)
    l.Font = Enum.Font.Gotham; l.TextSize = 11
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.TextWrapped = true; l.Parent = iscroll
end
mkInfo("Nombre: JoseAngel_Blox", Color3.fromRGB(0, 170, 255), 18)
mkInfo("Fecha: 09/09/2026")
mkInfo("Versión: 1.4")
mkInfo("")
mkInfo("UPDATE:", Color3.fromRGB(0, 255, 150), 16)
mkInfo("Script con detección de ProximityPrompt para eclosionar. - JoseAngel_Blox", Color3.fromRGB(200, 200, 200), 60)

-- MAIN
local mainPage = createTab("Main")
local mscroll = Instance.new("ScrollingFrame")
mscroll.Size = UDim2.new(1, 0, 1, 0); mscroll.BackgroundTransparency = 1; mscroll.BorderSizePixel = 0
mscroll.ScrollBarThickness = 4; mscroll.CanvasSize = UDim2.new(0, 0, 0, 400); mscroll.Parent = mainPage
local ml = Instance.new("UIListLayout"); ml.Padding = UDim.new(0, 5); ml.Parent = mscroll

local function createToggle(text, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -6, 0, 32)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    frame.BorderSizePixel = 0; frame.Parent = mscroll
    local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 6); c.Parent = frame

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -55, 1, 0); lbl.Position = UDim2.new(0, 8, 0, 0)
    lbl.BackgroundTransparency = 1; lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(230, 230, 230); lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 11; lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame

    local tbtn = Instance.new("TextButton")
    tbtn.Size = UDim2.new(0, 42, 0, 20); tbtn.Position = UDim2.new(1, -48, 0.5, -10)
    tbtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80); tbtn.Text = "OFF"
    tbtn.TextColor3 = Color3.fromRGB(255, 255, 255); tbtn.Font = Enum.Font.GothamBold
    tbtn.TextSize = 10; tbtn.BorderSizePixel = 0; tbtn.Parent = frame
    local bc = Instance.new("UICorner"); bc.CornerRadius = UDim.new(0, 5); bc.Parent = tbtn

    local state = false
    tbtn.MouseButton1Click:Connect(function()
        state = not state
        tbtn.Text = state and "ON" or "OFF"
        tbtn.BackgroundColor3 = state and Color3.fromRGB(0, 170, 255) or Color3.fromRGB(60, 60, 80)
        callback(state)
    end)
end

--==============================================================
-- UTILIDADES
--==============================================================
local function getHRP()
    local c = LocalPlayer.Character
    return c and c:FindFirstChild("HumanoidRootPart")
end
local function getHum()
    local c = LocalPlayer.Character
    return c and c:FindFirstChildOfClass("Humanoid")
end

-- Detectar mi plot
local myPlot = nil
local function findMyPlot()
    if myPlot and myPlot.Parent then return myPlot end
    for _, plot in pairs(workspace:GetChildren()) do
        if plot.Name == "Plots" then
            for _, p in pairs(plot:GetChildren()) do
                for _, obj in pairs(p:GetDescendants()) do
                    if (obj:IsA("ObjectValue") and obj.Value == LocalPlayer) or
                       (obj:IsA("StringValue") and obj.Value == LocalPlayer.Name) then
                        myPlot = p
                        return p
                    end
                end
            end
        end
    end
    return nil
end

--==============================================================
-- 1. AUTO FARM - Correr a StartArea
--==============================================================
local autoFarm = false
local farmConn = nil
local function startFarm()
    if farmConn then farmConn:Disconnect() end
    farmConn = RunService.Heartbeat:Connect(function()
        if not autoFarm then return end
        local hrp = getHRP(); local hum = getHum()
        if not hrp or not hum then return end
        local target = workspace:FindFirstChild("__OBJECTS", true)
        target = target and target:FindFirstChild("Areas", true)
        target = target and target:FindFirstChild("StartArea", true)
        if target then
            local dir = target.Position - hrp.Position
            if dir.Magnitude > 6 then
                hum.WalkSpeed = 120
                hum:Move(dir.Unit, false)
                hrp.CFrame = CFrame.new(hrp.Position, Vector3.new(target.Position.X, hrp.Position.Y, target.Position.Z))
            else
                hum:Move(Vector3.new(0, 0, 0), false)
            end
        end
    end)
end

createToggle("Auto Farm (ir a StartArea)", function(s)
    autoFarm = s
    if s then startFarm()
    else
        if farmConn then farmConn:Disconnect(); farmConn = nil end
        local h = getHum(); if h then h.WalkSpeed = 16 end
    end
end)

--==============================================================
-- 2. AUTO-COLLECT HUEVOS
--==============================================================
local autoCollect = false
local collectConn = nil
local function startCollect()
    if collectConn then collectConn:Disconnect() end
    collectConn = RunService.Heartbeat:Connect(function()
        if not autoCollect then return end
        local hrp = getHRP(); local hum = getHum()
        if not hrp or not hum then return end

        local closest = nil; local cd = 80
        local eggFolder = workspace:FindFirstChild("PlacedEggRenders")
        if eggFolder then
            for _, egg in pairs(eggFolder:GetDescendants()) do
                if egg:IsA("BasePart") then
                    local d = (egg.Position - hrp.Position).Magnitude
                    if d < cd then cd = d; closest = egg end
                end
            end
        end
        if closest then
            local dir = closest.Position - hrp.Position
            if dir.Magnitude > 4 then
                hum.WalkSpeed = 100
                hum:Move(dir.Unit, false)
            else
                local p = closest:FindFirstChildOfClass("ProximityPrompt")
                if p then pcall(function() fireproximityprompt(p) end) end
            end
        end
    end)
end

createToggle("Auto-Collect Huevos", function(s)
    autoCollect = s
    if s then startCollect()
    else if collectConn then collectConn:Disconnect(); collectConn = nil end end
end)

--==============================================================
-- 3. AUTO TREADMILL
--==============================================================
local autoTread = false
local treadConn = nil
local function startTread()
    if treadConn then treadConn:Disconnect() end
    treadConn = RunService.Heartbeat:Connect(function()
        if not autoTread then return end
        local hrp = getHRP(); local hum = getHum()
        if not hrp or not hum then return end

        local plot = findMyPlot()
        local target = nil
        if plot then
            target = plot:FindFirstChild("TreadmillBottom", true)
        end
        if target then
            local dir = target.Position - hrp.Position
            if dir.Magnitude > 3 then
                hum.WalkSpeed = 100
                hum:Move(dir.Unit, false)
            else
                hum:Move(Vector3.new(0, 0, 0), false)
            end
        end
    end)
end

createToggle("Auto Treadmill", function(s)
    autoTread = s
    if s then startTread()
    else if treadConn then treadConn:Disconnect(); treadConn = nil end end
end)

--==============================================================
-- 4. SPEED HACK
--==============================================================
local speedOn = false
local speedConn = nil
local function startSpeed()
    if speedConn then speedConn:Disconnect() end
    speedConn = RunService.Heartbeat:Connect(function()
        if not speedOn then return end
        local h = getHum(); if h then h.WalkSpeed = 120 end
    end)
end

createToggle("Speed Hack", function(s)
    speedOn = s
    if s then startSpeed()
    else
        if speedConn then speedConn:Disconnect(); speedConn = nil end
        local h = getHum(); if h then h.WalkSpeed = 16 end
    end
end)

--==============================================================
-- 5. AUTO HATCH (AUTO ECLOSIONAR)
-- Busca CUALQUIER ProximityPrompt que diga "Eclosionar" o "Hatch"
--==============================================================
local autoHatch = false
local hatchConn = nil

local function startHatch()
    if hatchConn then hatchConn:Disconnect() end
    hatchConn = RunService.Heartbeat:Connect(function()
        if not autoHatch then return end
        local hrp = getHRP(); local hum = getHum()
        if not hrp or not hum then return end

        -- Buscar TODOS los ProximityPrompts del juego que digan eclosionar
        local target = nil
        local targetDist = 9999

        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("ProximityPrompt") then
                local action = obj.ActionText:lower()
                local objectName = obj.ObjectText:lower()
                -- Detectar cualquier prompt que contenga "eclos", "hatch", "abrir", "open", "recoger"
                if action:find("eclos") or action:find("hatch") or action:find("abrir") or
                   action:find("open") or action:find("recoger") or action:find("collect") or
                   objectName:find("huevo") or objectName:find("egg") then
                    local parent = obj.Parent
                    local pos = nil
                    if parent:IsA("BasePart") then
                        pos = parent.Position
                    elseif parent:IsA("Model") and parent.PrimaryPart then
                        pos = parent.PrimaryPart.Position
                    elseif parent:IsA("Attachment") and parent.Parent:IsA("BasePart") then
                        pos = parent.Parent.Position
                    end
                    if pos then
                        local d = (pos - hrp.Position).Magnitude
                        if d < targetDist then
                            targetDist = d
                            target = { prompt = obj, pos = pos }
                        end
                    end
                end
            end
        end

        if target then
            local dir = target.pos - hrp.Position
            if dir.Magnitude > 4 then
                hum.WalkSpeed = 100
                hum:Move(dir.Unit, false)
            else
                hum:Move(Vector3.new(0, 0, 0), false)
                -- Presionar el prompt (equivale a darle a E o clic)
                pcall(function()
                    fireproximityprompt(target.prompt)
                end)
                task.wait(0.5)
            end
        end
    end)
end

createToggle("Auto Hatch Huevos", function(s)
    autoHatch = s
    if s then startHatch()
    else if hatchConn then hatchConn:Disconnect(); hatchConn = nil end end
end)

-- Activar Info por defecto
tabs["Info"].Button.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
tabs["Info"].Button.TextColor3 = Color3.fromRGB(255, 255, 255)
tabs["Info"].Page.Visible = true

pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = "JoseAngel_Blox Steal An Huevo",
        Text = "Versión 1.4 cargada con Auto Hatch",
        Duration = 5,
    })
end)

print("[JoseAngel_Blox] v1.4 cargado - Auto Hatch activado")
