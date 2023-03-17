local QBCore = exports['qb-core']:GetCoreObject()

local MinMax = {0.8, 1.3}
local SkillIncrease = 0.0001

local function house(inNum)
    if inNum < MinMax[1] then
        return MinMax[1]
    elseif inNum > MinMax[2] then
        return MinMax[2]
    else
        return inNum
    end
end

RegisterNetEvent("CR.Skill.Sprint:Update", function()
    local Plr = QBCore.Functions.GetPlayer(source)
    local PlayerData = Plr.PlayerData

    if Plr ~= nil then
        local NewValue = house(PlayerData.metadata.softskill_sprinting + SkillIncrease)
        Plr.Functions.SetMetaData("softskill_sprinting",  NewValue)
        print("Updated Sprinting to " .. NewValue)
    end
end)