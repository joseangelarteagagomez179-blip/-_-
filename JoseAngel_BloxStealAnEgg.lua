for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("BasePart") and (v.Name:lower():find("egg") or v.Name:lower():find("huevo") or v.Name:lower():find("tread") or v.Name:lower():find("start") or v.Name:lower():find("hatch")) then
        print(v.Name, v:GetFullName())
    end
end
