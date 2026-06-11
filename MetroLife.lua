-- 🔓 SCRIPT DESBLOQUEAR GAMEPASSES - METRO LIFE CITY RP
-- ✍️ SOLO CAMBIA LOS NÚMEROS DE ABAJO POR LOS IDs REALES
local IDS_DE_PASES = {
    123456789,  -- ID PASE 1
    987654321,  -- ID PASE 2
    1122334455  -- ID PASE 3
}

-- ⚠️ NO TOCAR NADA DE AQUÍ PARA ABAJO ⚠️
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local player = Players.LocalPlayer

-- Función para simular que tienes el pase
pcall(function()
    local originalFunc = MarketplaceService.UserOwnsGamePassAsync
    
    MarketplaceService.UserOwnsGamePassAsync = function(self, userId, passId)
        if table.find(IDS_DE_PASES, passId) then
            return true
        end
        return originalFunc(self, userId, passId)
    end
end)

-- Mensaje de confirmación
game.StarterGui:SetCore("ChatMakeSystemMessage", {
    Text = "✅ TODOS LOS PASES DESBLOQUEADOS!",
    Color = Color3.new(0, 1, 0),
    Font = Enum.Font.GothamBold,
    TextSize = 18
})

print("-----------------------------------")
print("✅ LISTO! Pases activados: ")
for _, id in pairs(IDS_DE_PASES) do
    print("🔓 ID: " .. id)
end
print("-----------------------------------")
