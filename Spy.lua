-- Muestra el nombre de la herramienta que tienes en la mano
local player = game.Players.LocalPlayer
player.Character.ChildAdded:Connect(function(child)
    if child:IsA("Tool") then
        print("💡 LA HERRAMIENTA SE LLAMA: " .. child.Name)
    end
end)

-- Muestra el nombre de las cosas que tocas (Útil para saber el nombre del Tsunami o del Dinero)
player.Character.HumanoidRootPart.Touched:Connect(function(hit)
    print("🔍 ACABAS DE TOCAR: " .. hit.Name .. " (Padre: " .. hit.Parent.Name .. ")")
end)
