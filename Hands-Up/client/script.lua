Citizen.CreateThread(function()
    local dict = "missminuteman_1ig_2"
    
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
    local handsup = false
    local timeout = false
    
    local function keybind(name, key, cb)
        RegisterCommand("+" .. name, function()
            cb()
        end)
        RegisterCommand("-" .. name, function()
            cb()
        end)
        RegisterKeyMapping("+" .. name, name, 'keyboard', key)
    end

    keybind("handsupX", "x", function()
        if IsControlJustPressed(1, 323) then 
            if not handsup then
                handsup = true
                Citizen.CreateThread(function()
                    while handsup do 
                        Citizen.Wait(4)
                        if not timeout and not IsEntityPlayingAnim(PlayerPedId(), dict, "handsup_enter", 17) then                      
                            timeout = true
                            TaskPlayAnim(PlayerPedId(), dict, "handsup_enter", 8.0, 8.0, -1, 50, 0, false, false, false)
                            Citizen.CreateThread(function()
                                Citizen.Wait(1000)
                                timeout = false
                            end)
                        end
                        SetPlayerCanDoDriveBy(PlayerId(), false)
                        DisablePlayerFiring(PlayerId(), true)
                        DisableControlAction(0, 140) 
                        DisableControlAction(0, 25) 
                        SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
                    end
                    SetPlayerCanDoDriveBy(PlayerId(), true)
                    DisablePlayerFiring(PlayerId(), false)
                    EnableControlAction(0, 140) 
                    EnableControlAction(0, 25) 
                    ClearPedTasks(PlayerPedId())
                end)
            else
                handsup = false
            end
        end
    end)
    return collectgarbage()
end)

Citizen.CreateThread( function()
while true do
Citizen.Wait(500)
ResetPlayerStamina(PlayerId())
end
end)