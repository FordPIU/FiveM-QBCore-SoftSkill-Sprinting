local QBCore = exports['qb-core']:GetCoreObject()
local IsSprint = false
local PlayerData = nil

Citizen.CreateThread(function()
    repeat
        Wait(100)
    until QBCore.Functions.GetPlayerData() ~= nil

    PlayerData = QBCore.Functions.GetPlayerData()

    while true do
        Wait(0)

        local PlayerPed = PlayerPedId()
	    local PlrId = PlayerId()

        if PlayerData == nil or PlayerData.metadata == nil then
            PlayerData = QBCore.Functions.GetPlayerData()
        else
            if DoesEntityExist(PlayerPed) and IsPedSprinting(PlayerPed) and not IsEntityDead(PlayerPed) then
                local speed = PlayerData.metadata.softskill_sprinting

                if speed < 0.08 then speed = 0.08 end

                SetPedMoveRateOverride(PlayerPed, speed)
		        SetPlayerMaxStamina(PlrId, 1000 * (2 * speed))

                IsSprint = true
            else
                IsSprint = false
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(2000)

        if IsSprint then
            TriggerServerEvent("CR.Skill.Sprint:Update")
        end

        if PlayerData ~= nil then
            PlayerData = QBCore.Functions.GetPlayerData()
        end
    end
end)