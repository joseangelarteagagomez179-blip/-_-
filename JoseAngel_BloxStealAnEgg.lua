-- Interfaz nativa nativa en CoreGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KickLuckyBlockPerfect"
ScreenGui.Parent = game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, 180)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -90)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.Text = "KICK LUCKY BLOCK - PERFECT HUB"
Title.TextColor3 = Color3.fromRGB(0, 255, 127)
Title.TextSize = 13
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = Title

-- Botón Toggle de Auto Kick Perfecto
local AutoKickBtn = Instance.new("TextButton")
AutoKickBtn.Size = UDim2.new(0.85, 0, 0, 40)
AutoKickBtn.Position = UDim2.new(0.075, 0, 0, 50)
AutoKickBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
AutoKickBtn.Text = "Auto Perfect Kick: OFF"
AutoKickBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoKickBtn.Font = Enum.Font.SourceSansBold
AutoKickBtn.TextSize = 14
AutoKickBtn.Parent = MainFrame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 6)
BtnCorner.Parent = AutoKickBtn

-- Lógica del Auto Perfect Kick
local autoKickActive = false
local KickEvent = game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Packages"):WaitForChild("Network"):WaitForChild("ref_KickEvent")

AutoKickBtn.MouseButton1Click:Connect(function()
    autoKickActive = not autoKickActive
    if autoKickActive then
        AutoKickBtn.Text = "Auto Perfect Kick: ON"
        AutoKickBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    else
        AutoKickBtn.Text = "Auto Perfect Kick: OFF"
        AutoKickBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end
end)

-- Bucle de pateo continuo
task.spawn(function()
    while true do
        task.wait(0.1) -- Ajusta el tiempo si quieres que patee más rápido o más lento
        if autoKickActive then
            pcall(function()
                -- Fuerza/Precisión en 1 para garantizar el tiro perfecto
                local args = {
                    1, 
                    1, 
                    tick() -- Timestamp dinámico para evitar que el servidor lo rechace
                }
                KickEvent:InvokeServer(unpack(args))
            end)
        end
    end
end)

-- Botón Cerrar
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0.85, 0, 0, 35)
CloseBtn.Position = UDim2.new(0.075, 0, 0, 105)
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
CloseBtn.Text = "Cerrar Script"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 14
CloseBtn.Parent = MainFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    autoKickActive = false
    ScreenGui:Destroy()
end)
