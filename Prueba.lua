-- Script de prueba ultra básico en Lua para verificar compatibilidad
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Cambiar la velocidad de forma directa a 50
if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
    LocalPlayer.Character.Humanoid.WalkSpeed = 50
end

-- Enviar un mensaje de confirmación al chat del juego (Solo lo ves tú)
game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
    Text = "[JoseAngel_Blox]: ¡El inyector Lua está funcionando perfectamente!";
    Color = Color3.fromRGB(255, 0, 0);
    Font = Enum.Font.SourceSansBold;
})
