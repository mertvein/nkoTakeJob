local QBCore = exports["qb-core"]:GetCoreObject()
local pedSpawned = false
local JobPed = {}

CreateThread(function()
    for k, v in pairs(Config.Peds) do
        if v.showBlip then
            blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
            SetBlipSprite(blip, v.blipSprite)
            SetBlipDisplay(blip, 4) 
            SetBlipScale(blip, v.blipScale)
            SetBlipColour(blip, v.blipColor)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.blipName)
            EndTextCommandSetBlipName(blip)
        end
    end
end)

local function createPeds()
    if pedSpawned then return end
    for k, v in pairs(Config.Peds) do
        if not JobPed[k] then JobPed[k] = {} end
        local current = v.ped
        current = type(current) == 'string' and GetHashKey(current) or current
        RequestModel(current)

        while not HasModelLoaded(current) do Wait(0) end

        JobPed[k] = CreatePed(0, current, v.coords.x, v.coords.y, v.coords.z - 1, v.coords.w, false, false)
        TaskStartScenarioInPlace(JobPed[k], v.scenario, true)
        FreezeEntityPosition(JobPed[k], true)
        SetEntityInvincible(JobPed[k], true)
        SetBlockingOfNonTemporaryEvents(JobPed[k], true)

        exports['qb-target']:AddTargetEntity(JobPed[k], {
            options = {
                {
                    label = v.targetLabel,
                    icon = v.targetIcon,
                    type = 'client',
                    event = 'nkoTakeJob:menu'
                }
            },
            distance = 2.0
        })
    end
    pedSpawned = true
end

RegisterNetEvent('nkoTakeJob:menu')
AddEventHandler('nkoTakeJob:menu', function()
    QBCore.Functions.Notify(Config.Text['notify'], 'error', 10000)
    for k, v in pairs(Config.Peds) do
        local menu = {
            {
                header = Config.Text['header'],
                txt = '<span style="color:#be7e42e6; font-weight: bold;">'..v.jobName..'</span>',
                icon = "fa-solid fa-briefcase",
                isMenuHeader = true,
            },
            {
                header = Config.Text['takeJob_h'],
                txt = Config.Text['takeJob_t']..v.jobName..'.',
                icon = "fa-solid fa-check",
                params = {
                    event = 'nkoTakeJob:cl:job',
                    args = v.job
                }
            },
            {
                header = Config.Text['leaveJob_h'],
                txt = Config.Text['leaveJob_t'],
                icon = "fa-solid fa-times",
                params = {
                    event = 'nkoTakeJob:cl:unemployed'
                }
            },
        }
        exports['qb-menu']:openMenu(menu)
    end
end)

RegisterNetEvent('nkoTakeJob:cl:unemployed', function()
    TriggerServerEvent('nkoTakeJob:unemployed')
end)

RegisterNetEvent('nkoTakeJob:cl:job', function(job)
    TriggerServerEvent('nkoTakeJob:job', job)
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    createPeds()
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        createPeds()
    end
end)