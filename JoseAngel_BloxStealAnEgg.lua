-- Script Path: game:GetService("ReplicatedStorage").Client.AdminPanelEntry
-- Took 0.01s to decompile.
-- Executor: Delta (1.1.736.1408)

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("UserInputService")
local v_u_3 = require(v1.Shared.Modules.Environment)
local v4 = require(v1.Packages.Signal)
local v_u_5 = Enum.KeyCode.F8
local v6 = v2.KeyboardEnabled
local v_u_7 = v2.TouchEnabled
local v_u_8
if v6 then
    v_u_8 = not v_u_7
else
    v_u_8 = v6
end
if v_u_7 then
    v_u_7 = not v6
end
local v_u_9 = {
    ["Changed"] = v4.new()
}
local v_u_10 = false
local v_u_11 = false
local function v17(p12, p13) -- name: onInputBegan
    -- upvalues: (copy) v_u_8, (copy) v_u_5, (ref) v_u_10, (copy) v_u_9, (ref) v_u_11, (copy) v_u_3, (copy) v_u_7
    local v14 = v_u_8 and not p13
    if v14 then
        v14 = p12.KeyCode == v_u_5
    end
    if v14 then
        v_u_10 = not v_u_10
        local v15 = v_u_9.Changed
        local v16 = not v_u_11 and (not (v_u_3.IsDevPlace() or v_u_3.IsTestPlace()) and (not v_u_7 and v_u_8))
        if v16 then
            v16 = v_u_10
        end
        v15:Fire(v16)
    end
end
function v_u_9.CanShowPanel() -- name: CanShowPanel
    -- upvalues: (ref) v_u_11, (copy) v_u_3, (copy) v_u_7, (copy) v_u_8, (ref) v_u_10
    local v18 = not v_u_11 and (not (v_u_3.IsDevPlace() or v_u_3.IsTestPlace()) and (not v_u_7 and v_u_8))
    if v18 then
        v18 = v_u_10
    end
    return v18
end
function v_u_9.SetAdminStatus(p19) -- name: SetAdminStatus
    -- upvalues: (ref) v_u_11, (copy) v_u_9, (copy) v_u_3, (copy) v_u_7, (copy) v_u_8, (ref) v_u_10
    if v_u_11 ~= p19 then
        v_u_11 = p19
        local v20 = v_u_9.Changed
        local v21 = not v_u_11 and (not (v_u_3.IsDevPlace() or v_u_3.IsTestPlace()) and (not v_u_7 and v_u_8))
        if v21 then
            v21 = v_u_10
        end
        v20:Fire(v21)
    end
end
v2.InputBegan:Connect(v17)
return v_u_9
