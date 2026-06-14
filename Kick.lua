--[[
Script hecho para: Kick a Lucky Block
Creado por: JoseAngel_Blox
Fecha: 14/06/2026
]]

-- Servicios
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Hum = Character:WaitForChild("Humanoid")
local HRP = Character:WaitForChild("HumanoidRootPart")

--===== CONFIGURACION =====--
local Settings = {
    AutoPatear = true,
    PateadaPerfecta = true,
    AutoFarm = true,
    AntiTsunami = true
}

--===== FUNCIONES =====--

local function EncontrarBloque()
    return workspace:FindFirstChild("LuckyBlock")
end

local function Patear()
    local Bloque = EncontrarBloque()
    if Bloque and Settings.PateadaPerfecta then
        HRP.CFrame = Bloque.CFrame * CFrame.new(0, 1, -2)
        wait(0.1)
        fireclickdetector(Bloque:FindFirstChildOfClass("ClickDetector"))
    end
end

local function Subir()
    if Settings.AntiTsunami then
        HRP.CFrame = CFrame.new(HRP.Position.X, 100, HRP.Position.Z)
    end
end

--===== BUCLE PRINCIPAL =====--
spawn(function()
    while wait(1) do
        if Settings.AutoPatear then
            Patear()
        end
        Subir()
    end
end)

--===== INTERFAZ HECHA A MANO =====--

local Gui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Titulo = Instance.new("TextLabel")
local Esquinas = Instance.new("UICorner")  -- <<<< Esquinas Curveadas

-- Propiedades del GUI
Gui.Name = "MenuJoseAngel"
Gui.Parent = Player.PlayerGui

-- Marco Principal (Cuadrado con esquinas suaves)
Main.Size = UDim2.new(0, 220, 0, 280)
Main.Position = UDim2.new(0.02, 0, 0.15, 0)
Main.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Main.BorderSizePixel = 2
Main.BorderColor3 = Color3.fromRGB(255, 215, 0)
Main.Parent = Gui

-- Esto hace que las esquinas no sean puntiagudas
Esquinas.CornerRadius = UDim.new(0, 12)
Esquinas.Parent = Main

-- Titulo
Titulo.Size = UDim2.new(1, 0, 0, 40)
Titulo.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
Titulo.TextColor3 = Color3.fromRGB(30, 30, 30)
Titulo.Font = Enum.Font.GothamBold
Titulo.TextSize = 16
Titulo.Text = "JoseAngel_Blox kick"
Titulo.Parent = Main

-- Mensaje en consola
print("====================================")
print("Script cargado - JoseAngel_Blox kick")
print("====================================")
