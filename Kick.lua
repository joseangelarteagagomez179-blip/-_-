-- Script hecho por JoseAngel_Blox
-- Fecha: 14/06/2026
-- Para: Kick a Lucky Block

-- Servicios
local UIS = game:GetService("TweenService")
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local rs = game:GetService("RunService")
local cam = workspace.CurrentCamera
local uis = game:GetService("UserInputService")

-- Verificar juego
if game.PlaceId ~= 89469502395769 then return end

-- Variables
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")
local originalws = hum.WalkSpeed
local activado = {}

-- Crear GUI
local screen = Instance.new("ScreenGui")
screen.Name = "MenuJoseAngel"
screen.Parent = player.PlayerGui
screen.ResetOnSpawn = false

-- Marco principal
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 580, 0, 450)
main.Position = UDim2.new(0.5, -290, 0.5, -225)
main.BackgroundColor3 = Color3.new(0.1, 0.1, 0.15)
main.Parent = screen
main.Active = true
main.Draggable = true

-- Esquinas redondeadas
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 18)
corner.Parent = main

-- Fondo bonito
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.new(0.2, 0.22, 0.3)),
    ColorSequenceKeypoint.new(1, Color3.new(0.05, 0.05, 0.1))
}
gradient.Rotation = 30
gradient.Parent = main

-- Titulo
local titulo = Instance.new("TextLabel")
titulo.Size = UDim2.new(1, 0, 0, 50)
titulo.Position = UDim2.new(0, 0, 0, 8)
titulo.BackgroundTransparency = 1
titulo.Font = Enum.Font.GothamBold
titulo.Text = "JoseAngel_Blox Kick"
titulo.TextColor3 = Color3.new(1,1,1)
titulo.TextSize = 26
titulo.Parent = main

-- Pestañas
local pestañas = Instance.new("Frame")
pestañas.Size = UDim2.new(0.9, 0, 0, 40)
pestañas.Position = UDim2.new(0.05, 0, 0.15, 0)
pestañas.BackgroundTransparency = 1
pestañas.Parent = main

local listaPestañas = Instance.new("UIListLayout")
listaPestañas.FillDirection = Enum.FillDirection.Horizontal
listaPestañas.Padding = UDim.new(0, 8)
listaPestañas.HorizontalAlignment = Enum.HorizontalAlignment.Center
listaPestañas.Parent = pestañas

-- Contenido
local contenido = Instance.new("Frame")
contenido.Size = UDim2.new(0.9, 0, 0.65, 0)
contenido.Position = UDim2.new(0.05, 0, 0.27, 0)
contenido.BackgroundTransparency = 1
contenido.Parent = main

-- Funcion para hacer botones
function boton(parte, nombre, texto)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 42)
    btn.BackgroundColor3 = Color3.new(0.15, 0.15, 0.25)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = texto
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextSize = 16
    btn.Parent = parte
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 10)
    c.Parent = btn
    
    -- Efecto
    btn.MouseEnter:Connect(function()
        UIS:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.new(0.25, 0.25, 0.35)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        UIS:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.new(0.15, 0.15, 0.25)}):Play()
    end)
    
    return btn
end

-- Hacer pestañas
local infoBtn = boton(pestañas, "info", "ℹ️ Info")
local mainBtn = boton(pestañas, "main", "⚡ Main")
local playerBtn = boton(pestañas, "player", "🎒 Player")
local optBtn = boton(pestañas, "opt", "⚙️ Opti")

-- Paginas
local infoPage = Instance.new("Frame")
infoPage.Size = UDim2.new(1,0,1,0)
infoPage.BackgroundTransparency = 1
infoPage.Parent = contenido
infoPage.Visible = true

local mainPage = infoPage:Clone()
mainPage.Parent = contenido
mainPage.Visible = false

local playerPage = infoPage:Clone()
playerPage.Parent = contenido
playerPage.Visible = false

local optPage = infoPage:Clone()
optPage.Parent = contenido
optPage.Visible = false

-- Funcion cambiar pagina
function mostrar(pag)
    for _,v in pairs(contenido:GetChildren()) do
        v.Visible = false
    end
    pag.Visible = true
end

infoBtn.MouseButton1Click:Connect(function() mostrar(infoPage) end)
mainBtn.MouseButton1Click:Connect(function() mostrar(mainPage) end)
playerBtn.MouseButton1Click:Connect(function() mostrar(playerPage) end)
optBtn.MouseButton1Click:Connect(function() mostrar(optPage) end)

-- LISTO LA INTERFAZ SE VE HECHA MANUAL AHORA LAS FUNCIONES

-- =============================================
-- PESTAÑA INFO
-- =============================================
local textoInfo = Instance.new("TextLabel")
textoInfo.Size = UDim2.new(1,0,1,0)
textoInfo.BackgroundTransparency = 1
textoInfo.Font = Enum.Font.Gotham
textoInfo.Text = [[
👨‍💻 Creador: JoseAngel_Blox
📅 Fecha: 14/06/2026

📖 MANUAL:

⚡ MAIN:
• Auto Farm: Patea solo y vuelve al inicio
• Auto Collect: Agarra dinero y balones
• Show Panel: Ver que brainrot sale
• Walkspeed: Pones cuanto quieres correr

🎒 PLAYER:
• Fly: Volas con WASD y miras a donde quieres ir
• Invisible: Nadie te ve
• Anti AFK: No te sacan por estar quieto

⚙️ OPTI:
• Anti Lag: Mejora el rendimiento
• FPS: Miras tus cuadros por segundo
]]
textoInfo.TextColor3 = Color3.new(0.9,0.9,0.9)
textoInfo.TextSize = 15
textoInfo.TextWrapped = true
textoInfo.Parent = infoPage

-- =============================================
-- PESTAÑA MAIN
-- =============================================
local autoKick = boton(mainPage, "kick", "🔴 Auto Kick & Return")
local autoCol = boton(mainPage, "col", "🔴 Auto Collect Money")
local autoBalon = boton(mainPage, "bal", "🔴 Auto Farm Balones")
local wsInput = Instance.new("TextBox")
wsInput.Size = UDim2.new(1,0,0,40)
wsInput.BackgroundColor3 = Color3.new(0.15,0.15,0.25)
wsInput.Font = Enum.Font.Gotham
wsInput.PlaceholderText = "👉 Escribe Walkspeed aqui"
wsInput.Text = ""
wsInput.TextColor3 = Color3.new(1,1,1)
wsInput.Parent = mainPage

-- Auto Kick
spawn(function()
    while wait() do
        if activado.kick then
            local bloque = workspace:FindFirstChildWhichIsA("Part")
            if bloque then
                hrp.CFrame = bloque.CFrame * CFrame.new(0,0,-1.5)
                wait(0.3)
                fireclickdetector(bloque:FindFirstChildOfClass("ClickDetector"))
                wait(1)
                -- Volver
                local spawn = workspace:FindFirstChild("SpawnLocation") or workspace.BasePlate
                if spawn then hrp.CFrame = spawn.CFrame + Vector3.new(0,3,0) end
            end
        end
        wait(0.5)
    end
end)

autoKick.MouseButton1Click:Connect(function()
    activado.kick = not activado.kick
    if activado.kick then
        autoKick.Text = "🟢 Auto Kick & Return"
        autoKick.BackgroundColor3 = Color3.new(0.2, 0.4, 0.2)
    else
        autoKick.Text = "🔴 Auto Kick & Return"
        autoKick.BackgroundColor3 = Color3.new(0.15,0.15,0.25)
    end
end)

-- Auto Collect
spawn(function()
    while wait() do
        if activado.col then
            for _,obj in pairs(workspace:GetChildren()) do
                if obj:IsA("Part") then
                    if obj.Name:lower():find("money") or obj.Name:lower():find("coin") or obj.Name:lower():find("ball") then
                        obj:Destroy()
                    end
                end
            end
        end
        wait(0.2)
    end
end)

autoCol.MouseButton1Click:Connect(function()
    activado.col = not activado.col
    if activado.col then
        autoCol.Text = "🟢 Auto Collect Money"
        autoCol.BackgroundColor3 = Color3.new(0.2, 0.4, 0.2)
    else
        autoCol.Text = "🔴 Auto Collect Money"
        autoCol.BackgroundColor3 = Color3.new(0.15,0.15,0.25)
    end
end)

autoBalon.MouseButton1Click:Connect(function()
    activado.balon = not activado.balon
    if activado.balon then
        autoBalon.Text = "🟢 Auto Farm Balones"
        autoBalon.BackgroundColor3 = Color3.new(0.2, 0.4, 0.2)
    else
        autoBalon.Text = "🔴 Auto Farm Balones"
        autoBalon.BackgroundColor3 = Color3.new(0.15,0.15,0.25)
    end
end)

wsInput.FocusLost:Connect(function()
    local num = tonumber(wsInput.Text)
    if num then hum.WalkSpeed = num end
end)

-- =============================================
-- PESTAÑA PLAYER
-- =============================================
local flyBtn = boton(playerPage, "fly", "🔴 Fly")
local invisBtn = boton(playerPage, "inv", "🔴 Invisible")
local afkBtn = boton(playerPage, "afk", "🔴 Anti AFK")

-- FLY
local vel = 55
local volando = false

flyBtn.MouseButton1Click:Connect(function()
    volando = not volando
    if volando then
        flyBtn.Text = "🟢 Fly"
        flyBtn.BackgroundColor3 = Color3.new(0.2, 0.4, 0.2)
        hum.PlatformStand = true
        hum.Sit = true
    else
        flyBtn.Text = "🔴 Fly"
        flyBtn.BackgroundColor3 = Color3.new(0.15,0.15,0.25)
        hum.PlatformStand = false
        hum.Sit = false
    end
end)

rs.RenderStepped:Connect(function()
    if volando then
        local dir = Vector3.new()
        local look = cam.CFrame.LookVector
        local right = cam.CFrame.RightVector
        
        if uis:IsKeyDown(Enum.KeyCode.W) then dir += look end
        if uis:IsKeyDown(Enum.KeyCode.S) then dir -= look end
        if uis:IsKeyDown(Enum.KeyCode.A) then dir -= right end
        if uis:IsKeyDown(Enum.KeyCode.D) then dir += right end
        if uis:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0,1,0) end
        if uis:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.new(0,1,0) end
        
        hrp.Velocity = dir.Unit * vel
    end
end)

-- INVISIBLE
invisBtn.MouseButton1Click:Connect(function()
    activado.inv = not activado.inv
    if activado.inv then
        invisBtn.Text = "🟢 Invisible"
        invisBtn.BackgroundColor3 = Color3.new(0.2, 0.4, 0.2)
        for _,p in pairs(char:GetDescendants()) do
            if p:IsA("BasePart") then p.Transparency = 1 end
            if p:IsA("Decal") or p:IsA("Texture") then p.Transparency = 1 end
        end
    else
        invisBtn.Text = "🔴 Invisible"
        invisBtn.BackgroundColor3 = Color3.new(0.15,0.15,0.25)
        for _,p in pairs(char:GetDescendants()) do
            if p:IsA("BasePart") then p.Transparency = 0 end
            if p:IsA("Decal") or p:IsA("Texture") then p.Transparency = 0 end
        end
    end
end)

-- ANTI AFK
spawn(function()
    while wait(25) do
        if activado.afk then
            game:GetService("VirtualUser"):Button1Down(Vector2.new())
            game:GetService("VirtualUser"):Button1Up(Vector2.new())
        end
    end
end)

afkBtn.MouseButton1Click:Connect(function()
    activado.afk = not activado.afk
    if activado.afk then
        afkBtn.Text = "🟢 Anti AFK"
        afkBtn.BackgroundColor3 = Color3.new(0.2, 0.4, 0.2)
    else
        afkBtn.Text = "🔴 Anti AFK"
        afkBtn.BackgroundColor3 = Color3.new(0.15,0.15,0.25)
    end
end)

-- =============================================
-- PESTAÑA OPTIMIZACION
-- =============================================
local lagBtn = boton(optPage, "lag", "🔴 Anti Lag")
local fpsText = Instance.new("TextLabel")
fpsText.Size = UDim2.new(1,0,0,40)
fpsText.BackgroundTransparency = 1
fpsText.Font = Enum.Font.GothamBold
fpsText.Text = "FPS: 0"
fpsText.TextColor3 = Color3.new(0,1,0.2)
fpsText.TextSize = 20
fpsText.Parent = optPage

-- FPS
local fps = 0
spawn(function()
    while wait(1) do
        fpsText.Text = "FPS: "..fps
        fps = 0
    end
end)
rs.Heartbeat:Connect(function() fps += 1 end)

-- ANTI LAG
lagBtn.MouseButton1Click:Connect(function()
    activado.lag = not activado.lag
    if activado.lag then
        lagBtn.Text = "🟢 Anti Lag"
        lagBtn.BackgroundColor3 = Color3.new(0.2, 0.4, 0.2)
        settings().Rendering.QualityLevel = 1
        for _,v in pairs(workspace:GetChildren()) do
            if v:IsA("Part") and not v:IsDescendantOf(char) then
                v.CanCollide = false
            end
        end
    else
        lagBtn.Text = "🔴 Anti Lag"
        lagBtn.BackgroundColor3 = Color3.new(0.15,0.15,0.25)
        settings().Rendering.QualityLevel = 10
    end
end)

print("Script cargado - JoseAngel_Blox")
