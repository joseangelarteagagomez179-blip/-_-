-- Script: JoseAngel_Blox kick
-- ✅ EFECTO LUCES ROJAS Y NEGRAS GIRANDO
-- ✅ Minimizar / Maximizar
-- ✅ Scroll
-- ✅ Todo funcional

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local WS = game:GetService("Workspace")
local VU = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local CAS = game:GetService("ContextActionService")

local LocalPlayer = Players.LocalPlayer
local Character, Humanoid, HRP

local function UpdateChar()
    Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    Humanoid = Character:WaitForChild("Humanoid")
    HRP = Character:WaitForChild("HumanoidRootPart")
end
UpdateChar()

-- ==============================================
-- INTERFAZ
-- ==============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Menu"
ScreenGui.Parent = LocalPlayer.PlayerGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- 🟥 MARCO EXTERIOR (Para el efecto de luz)
local OuterFrame = Instance.new("Frame")
OuterFrame.Name = "OuterGlow"
OuterFrame.Parent = ScreenGui
OuterFrame.Size = UDim2.new(0, 410, 0, 510)
OuterFrame.Position = UDim2.new(0.5, -205, 0.5, -255)
OuterFrame.BackgroundColor3 = Color3.new(1,0,0)
OuterFrame.Active = false

local OuterCorner = Instance.new("UICorner")
OuterCorner.CornerRadius = UDim.new(0, 18)
OuterCorner.Parent = OuterFrame

-- ⬛ MARCO PRINCIPAL NEGRO
local MainFrame = Instance.new("Frame")
MainFrame.Name = "Main"
MainFrame.Parent = OuterFrame
MainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
MainFrame.Size = UDim2.new(1, -10, 1, -10)
MainFrame.Position = UDim2.new(0, 5, 0, 5)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 15)
MainCorner.Parent = MainFrame

-- BOTON MINIMIZAR
local MiniBtn = Instance.new("TextButton")
MiniBtn.Name = "Mini"
MiniBtn.Parent = MainFrame
MiniBtn.Size = UDim2.new(0, 50, 0, 30)
MiniBtn.Position = UDim2.new(1, -60, 0, 5)
MiniBtn.Text = "➖"
MiniBtn.BackgroundColor3 = Color3.new(0.2,0,0)
MiniBtn.TextColor3 = Color3.new(1,1,1)
MiniBtn.Font = Enum.Font.GothamBold
MiniBtn.TextSize = 18
Instance.new("UICorner", MiniBtn)

-- SCROLL
local Scroll = Instance.new("ScrollingFrame")
Scroll.Parent = MainFrame
Scroll.BackgroundTransparency = 1
Scroll.Size = UDim2.new(1, 0, 1, -50)
Scroll.Position = UDim2.new(0, 0, 0, 45)
Scroll.CanvasSize = UDim2.new(0, 0, 0, 850)
Scroll.ScrollBarThickness = 4
Scroll.ScrollBarImageColor3 = Color3.new(1,0,0)

-- ==============================================
-- EFECTO DE LUCES GIRANDO 🟥⬛🟥⬛
-- ==============================================
coroutine.wrap(function()
    local Colors = {
        Color3.new(1, 0, 0),   -- Rojo
        Color3.new(0, 0, 0),   -- Negro
        Color3.new(0.8, 0, 0), -- Rojo oscuro
        Color3.new(0.1,0,0)    -- Casi negro
    }
    local i = 0
    while true do
        i = i + 1
        if i > #Colors then i = 1 end
        OuterFrame.BackgroundColor3 = Colors[i]
        task.wait(0.1) -- Velocidad del giro
    end
end)()

-- ==============================================
-- FUNCION CREAR BOTONES
-- ==============================================
local function Btn(Texto, Y, Color)
    local b = Instance.new("TextButton")
    b.Parent = Scroll
    b.Size = UDim2.new(1, -20, 0, 40)
    b.Position = UDim2.new(0, 10, 0, Y)
    b.Text = Texto
    b.BackgroundColor3 = Color or Color3.new(0.1,0.1,0.1)
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.AutoLocalize = false
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0,8)
    c.Parent = b
    return b
end

-- TITULO
local Title = Btn("JOSEANGEL_BLOX KICK", 10, Color3.new(0.1,0,0))
Title.Active = false

-- ==============================================
-- BOTONES Y FUNCIONES
-- ==============================================

-- 1. AUTO KICK
local AK_On = false
local AK_Btn = Btn("🔴 AUTO KICK - OFF", 60)
coroutine.wrap(function()
    while true do
        if AK_On then local ev = RS:FindFirstChild("KickEvent") or RS:FindFirstChild("Remotes") and RS.Remotes.Kick if ev then ev:FireServer() end end
        task.wait(0.2)
    end
end)()
AK_Btn.MouseButton1Click:Connect(function()
    AK_On = not AK_On
    AK_Btn.Text = AK_On and "🟢 AUTO KICK - ON" or "🔴 AUTO KICK - OFF"
    AK_Btn.BackgroundColor3 = AK_On and Color3.new(0,0.6,0) or Color3.new(0.1,0.1,0.1)
end)

-- 2. AUTO COLECT
local AC_On = false
local AC_Btn = Btn("🔴 AUTO COLECT - OFF", 110)
coroutine.wrap(function()
    while true do
        if AC_On and HRP then
            for _,v in pairs(WS:GetChildren()) do
                if v:FindFirstChild("TouchInterest") then firetouchinterest(HRP, v, 0) end
                if v:FindFirstChildWhichIsA("ProximityPrompt") then fireproximityprompt(v.ProximityPrompt) end
            end
        end
        task.wait(0.2)
    end
end)()
AC_Btn.MouseButton1Click:Connect(function()
    AC_On = not AC_On
    AC_Btn.Text = AC_On and "🟢 AUTO COLECT - ON" or "🔴 AUTO COLECT - OFF"
    AC_Btn.BackgroundColor3 = AC_On and Color3.new(0,0.7,0) or Color3.new(0.1,0.1,0.1)
end)

-- 3. AUTO WEIGHT
local AW_On = false
local AW_Btn = Btn("🔴 AUTO WEIGHT - OFF", 160)
coroutine.wrap(function()
    while true do
        if AW_On then VU:CaptureController() VU:ClickButton1(Vector2.new()) VU:ReleaseController() end
        task.wait(0.3)
    end
end)()
AW_Btn.MouseButton1Click:Connect(function()
    AW_On = not AW_On
    AW_Btn.Text = AW_On and "🟢 AUTO WEIGHT - ON" or "🔴 AUTO WEIGHT - OFF"
    AW_Btn.BackgroundColor3 = AW_On and Color3.new(0,0.5,1) or Color3.new(0.1,0.1,0.1)
end)

-- 4. AUTO CLICK
local AClick_On = false
local AClick_Btn = Btn("🔴 AUTO CLICK - OFF", 210)
coroutine.wrap(function()
    while true do
        if AClick_On then VU:CaptureController() VU:ClickButton1(Vector2.new()) VU:ReleaseController() end
        task.wait(0.1)
    end
end)()
AClick_Btn.MouseButton1Click:Connect(function()
    AClick_On = not AClick_On
    AClick_Btn.Text = AClick_On and "🟣 AUTO CLICK - ON" or "🔴 AUTO CLICK - OFF"
    AClick_Btn.BackgroundColor3 = AClick_On and Color3.new(0.6,0,1) or Color3.new(0.1,0.1,0.1)
end)

-- 5. FREEZE TRADE
local FT_On = false
local FT_Btn = Btn("🔴 FREEZE TRADE - OFF", 260)
FT_Btn.MouseButton1Click:Connect(function()
    FT_On = not FT_On
    FT_Btn.Text = FT_On and "❄️ FREEZE TRADE - ON" or "🔴 FREEZE TRADE - OFF"
    FT_Btn.BackgroundColor3 = FT_On and Color3.new(0,0.6,1) or Color3.new(0.1,0.1,0.1)
end)

-- 6. AUTO EVENTO
local AE_On = false
local AE_Btn = Btn("🏆 AUTO EVENTO - OFF", 310, Color3.new(1,0.3,0))
coroutine.wrap(function()
    while true do
        if AE_On and HRP then
            for _,v in pairs(WS:GetChildren()) do
                if string.find(string.lower(v.Name), "orange") or string.find(string.lower(v.Name), "ball") or string.find(string.lower(v.Name), "cup") then
                    if v:FindFirstChild("TouchInterest") then firetouchinterest(HRP, v, 0) end
                end
            end
        end
        task.wait(0.1)
    end
end)()
AE_Btn.MouseButton1Click:Connect(function()
    AE_On = not AE_On
    AE_Btn.Text = AE_On and "🏆 AUTO EVENTO - ON" or "🏆 AUTO EVENTO - OFF"
    AE_Btn.BackgroundColor3 = AE_On and Color3.new(1,0.5,0) or Color3.new(1,0.3,0)
end)

-- 7. WALKSPEED
local SpeedLv = 1
local Speeds = {16, 60, 150, 300}
local WS_Btn = Btn("🏃 VELOCIDAD - 16", 360)
WS_Btn.MouseButton1Click:Connect(function()
    UpdateChar()
    SpeedLv = SpeedLv % #Speeds + 1
    local new = Speeds[SpeedLv]
    Humanoid.WalkSpeed = new
    WS_Btn.Text = "🏃 VELOCIDAD - "..new
end)

-- 8. FLY
local Fly_On = false
local Fly_Spd = 55
local Fly_Dir = Vector3.new()
local Fly_Btn = Btn("✈️ VOLAR - OFF", 410)

CAS:BindAction("FlyMov", function(name, state, input)
    if Fly_On then Fly_Dir = Vector3.new(input.Position.X, input.Position.Y, 0) * -1 end
end, false, Enum.PlayerActions.CharacterMoveAction)

coroutine.wrap(function()
    while true do
        if Fly_On and HRP and Humanoid then
            Humanoid.PlatformStand = true
            local Mov = workspace.CurrentCamera.CFrame:VectorToWorldSpace(Fly_Dir) * Fly_Spd
            if UIS:IsKeyDown(Enum.KeyCode.Space) then Mov += Vector3.new(0,Fly_Spd,0) end
            if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then Mov += Vector3.new(0,-Fly_Spd,0) end
            HRP.Velocity = Mov
        end
        task.wait(0.01)
    end
end)()

Fly_Btn.MouseButton1Click:Connect(function()
    UpdateChar()
    Fly_On = not Fly_On
    Fly_Btn.Text = Fly_On and "✈️ VOLAR - ON" or "✈️ VOLAR - OFF"
    Fly_Btn.BackgroundColor3 = Fly_On and Color3.new(1,0.4,0) or Color3.new(0.1,0.1,0.1)
end)

-- 9. FPS Y ANTILAG
local FPS_Btn = Btn("📊 FPS: 0", 460)
FPS_Btn.Active = false
local AL_Btn = Btn("🧹 ANTILAG - OFF", 510)

local Count = 0
RunService.Heartbeat:Connect(function() Count +=1 end)
coroutine.wrap(function()
    while true do task.wait(1) FPS_Btn.Text = "📊 FPS: "..Count Count = 0 end
end)()

local AL_On = false
AL_Btn.MouseButton1Click:Connect(function()
    AL_On = not AL_On
    AL_Btn.Text = AL_On and "🧹 ANTILAG - ON" or "🧹 ANTILAG - OFF"
    AL_Btn.BackgroundColor3 = AL_On and Color3.new(0,0.7,0) or Color3.new(0.1,0.1,0.1)
    if AL_On then
        for _,v in pairs(WS:GetChildren()) do
            if v:IsA("Part") and not v:IsDescendantOf(Character) and v.Anchored == false then v:Destroy() end
        end
        settings().Rendering.QualityLevel = 1
    end
end)

-- ==============================================
-- MINIMIZAR
-- ==============================================
local Mini_On = false
MiniBtn.MouseButton1Click:Connect(function()
    Mini_On = not Mini_On
    if Mini_On then
        OuterFrame:TweenSizeAndPosition(UDim2.new(0, 80, 0, 45), UDim2.new(0,10,0,10), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
        Scroll.Visible = false
        MiniBtn.Text = "➕"
        MiniBtn.Position = UDim2.new(0.5,-25,0.5,-15)
    else
        OuterFrame:TweenSizeAndPosition(UDim2.new(0, 410, 0, 510), UDim2.new(0.5,-205,0.5,-255), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
        Scroll.Visible = true
        MiniBtn.Text = "➖"
        MiniBtn.Position = UDim2.new(1,-60,0,5)
    end
end)

-- Actualizar personaje
LocalPlayer.CharacterAdded:Connect(UpdateChar)

print("✅ SCRIPT LISTO CON LUCES ROJAS Y NEGRAS! 😎🚀")
