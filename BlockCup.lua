--[[
Script Name: JoseAngel_Blox Block Cup
Description: Auto Farm Evento Block Cup
Author: JoseAngel_Blox
Version: 1.0
]]

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- == GUI ==
local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Sub = Instance.new("TextLabel")

ScreenGui.Name = "JoseAngel_Blox"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.new(0.05, 0.05, 0.05)
Main.BorderColor3 = Color3.new(1, 0, 0)
Main.BorderSizePixel = 2
Main.Position = UDim2.new(0.05, 0, 0.2, 0)
Main.Size = UDim2.new(0, 300, 0, 120)

-- Fondo Animado Rojo y Negro
local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.new(0.8, 0, 0)),
    ColorSequenceKeypoint.new(0.5, Color3.new(0.1, 0.1, 0.1)),
    ColorSequenceKeypoint.new(1, Color3.new(0.8, 0, 0))
}
Gradient.Rotation = 45
Gradient.Parent = Main

spawn(function()
    while task.wait(0.05) do
        Gradient.Rotation += 3
    end
end)

-- Texto
Title.Name = "Title"
Title.Parent = Main
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 10, 0, 15)
Title.Size = UDim2.new(0, 280, 0, 40)
Title.Font = Enum.Font.GothamBlack
Title.Text = "JoseAngel_Blox"
Title.TextColor3 = Color3.new(1,1,1)
Title.TextSize = 26
Title.TextStrokeTransparency = 0
Title.TextStrokeColor3 = Color3.new(1,0,0)

Sub.Name = "Sub"
Sub.Parent = Main
Sub.BackgroundTransparency = 1
Sub.Position = UDim2.new(0, 10, 0, 60)
Sub.Size = UDim2.new(0, 280, 0, 30)
Sub.Font = Enum.Font.GothamBold
Sub.Text = "⚽ BLOCK CUP FARM ⚽"
Sub.TextColor3 = Color3.new(1, 0.4, 0.4)
Sub.TextSize = 18

-- == FUNCION FARMEO ==
spawn(function()
    while task.wait() do
        VirtualUser:Click()
        task.wait(1.5)
        Humanoid:MoveTo(Vector3.new(-45, 0, 0))
        task.wait(4)
    end
end)
