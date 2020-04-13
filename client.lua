local gunsmiths = {
    { x = -282.28, y = 780.59, z = 118.53 }, --val
    { x = 2715.9, y = -1285.04, z = 49.63 },  --saint
    { x = -856.95, y = -1391.59, z = 43.49 }, --blackwater
    { x = 1323.01, y = -1321.53, z = 77.89 }, --Rhodes
}

local active = false
local ShopPrompt
local hasAlreadyEnteredMarker, lastZone
local currentZone = nil

function SetupShopPrompt()
    Citizen.CreateThread(function()
        local str = 'Open Shop'
        ShopPrompt = PromptRegisterBegin()
        PromptSetControlAction(ShopPrompt, 0xE8342FF2)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(ShopPrompt, str)
        PromptSetEnabled(ShopPrompt, false)
        PromptSetVisible(ShopPrompt, false)
        PromptSetHoldMode(ShopPrompt, true)
        PromptRegisterEnd(ShopPrompt)

    end)
end

AddEventHandler('redemrp_gunshop:hasEnteredMarker', function(zone)
    currentZone     = zone
end)

AddEventHandler('redemrp_gunshop:hasExitedMarker', function(zone)
    if active == true then
        PromptSetEnabled(ShopPrompt, false)
        PromptSetVisible(ShopPrompt, false)
        active = false
    end
    WarMenu.CloseMenu()
	currentZone = nil
end)

Citizen.CreateThread(function()
    SetupShopPrompt()
    while true do
        Citizen.Wait(0)
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        local isInMarker, currentZone = false

        for k,v in ipairs(gunsmiths) do
            if (Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z) < 1.5) then
                isInMarker  = true
                currentZone = 'gunsmiths'
                lastZone    = 'gunsmiths'
            end
        end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			TriggerEvent('redemrp_gunshop:hasEnteredMarker', currentZone)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('redemrp_gunshop:hasExitedMarker', lastZone)
		end

    end
end)

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
        if currentZone then
            if active == false then
                PromptSetEnabled(ShopPrompt, true)
                PromptSetVisible(ShopPrompt, true)
                active = true
            end
            if PromptHasHoldModeCompleted(ShopPrompt) then
                WarMenu.OpenMenu('weaponshop')
                WarMenu.Display()
                PromptSetEnabled(ShopPrompt, false)
                PromptSetVisible(ShopPrompt, false)
                active = false

				currentZone = nil
			end
        else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()    

    WarMenu.CreateMenu('weaponshop', 'Weapon Shop')
    WarMenu.CreateSubMenu('pistols', 'weaponshop', 'Pistols')
    WarMenu.CreateSubMenu('longguns', 'weaponshop', 'Long Guns')
    WarMenu.CreateSubMenu('handguns', 'weaponshop', 'Melee Weapons')
    WarMenu.CreateSubMenu('Ammo', 'weaponshop', 'Ammo')
    WarMenu.CreateSubMenu('pistolsammo', 'Ammo', 'Pistols')
    WarMenu.CreateSubMenu('longgunsammo', 'Ammo', 'Long Guns')
    WarMenu.CreateSubMenu('handgunsammo', 'Ammo', 'Melee Weapons')

    while true do
        if WarMenu.IsMenuOpened('weaponshop') then

            if WarMenu.MenuButton('Pistols', 'pistols') then end
            if WarMenu.MenuButton('Long Guns', 'longguns') then end
            if WarMenu.MenuButton('Melee Weapons', 'handguns') then end
            if WarMenu.MenuButton('Ammo', 'Ammo') then end
            WarMenu.Display()
 
        elseif WarMenu.IsMenuOpened('pistols') then

            if WarMenu.Button("         Cattleman Revolver", "$10 LvL 1") then
                TriggerServerEvent("redemrp_gunshop:buygun", "cattleman_w", 10, "WEAPON_REVOLVER_CATTLEMAN", 1)
            elseif WarMenu.Button("         Double Action Revolver", "$12 LvL 5") then
                TriggerServerEvent("redemrp_gunshop:buygun", "doubleaction_w", 12, "WEAPON_REVOLVER_DOUBLEACTION", 5)
            elseif WarMenu.Button("         Volcanic", "$20 LvL 10") then
                TriggerServerEvent("redemrp_gunshop:buygun", "volcanic_w", 20, "WEAPON_PISTOL_VOLCANIC", 10)
            elseif WarMenu.Button("         Semi-auto Pistol", "$22 LvL 15") then
                TriggerServerEvent("redemrp_gunshop:buygun", "semiauto-p_w", 22, "WEAPON_PISTOL_SEMIAUTO", 15)
            elseif WarMenu.Button("         Mauser", "$30 LvL 20") then
                TriggerServerEvent("redemrp_gunshop:buygun", "mauser_w", 30, "WEAPON_PISTOL_MAUSER", 20)
            elseif WarMenu.Button("         M 1899", "$40 LvL 30") then
                TriggerServerEvent("redemrp_gunshop:buygun", "m1899_w", 40, "WEAPON_PISTOL_M1899", 30)
            elseif WarMenu.Button("         Lemat Revolver", "$50 LvL 40") then
                TriggerServerEvent("redemrp_gunshop:buygun", "lemat_w", 50, "WEAPON_REVOLVER_LEMAT", 40)
			end
            WarMenu.Display()

        elseif WarMenu.IsMenuOpened('longguns') then

            if WarMenu.Button("             Carbine Repeator", "$20 LvL 1") then
                TriggerServerEvent("redemrp_gunshop:buygun", "carbine_w", 20, "WEAPON_REPEATER_CARBINE", 1)
            elseif WarMenu.Button("             Varmint Rifle", "$15 LvL 1") then
                TriggerServerEvent("redemrp_gunshop:buygun", "varmint_w", 15, "WEAPON_RIFLE_VARMINT", 1)
            elseif WarMenu.Button("             Evans Repeater", "$30 LvL 5") then
                TriggerServerEvent("redemrp_gunshop:buygun", "evans_w", 30, "WEAPON_REPEATER_EVANS", 5)
            elseif WarMenu.Button("             Bolt Action Rifle", "$40 LvL 10") then
                TriggerServerEvent("redemrp_gunshop:buygun", "bolt_w", 40, "WEAPON_RIFLE_BOLTACTION", 10)
            elseif WarMenu.Button("             Carcano Rifle", "$70 LvL 30") then
                TriggerServerEvent("redemrp_gunshop:buygun", "carcano_w", 70, "WEAPON_SNIPERRIFLE_CARCANO", 30)
            elseif WarMenu.Button("             Rolling Block Rifle", "$100 LvL 50") then
                TriggerServerEvent("redemrp_gunshop:buygun", "rolling_w", 100, "WEAPON_SNIPERRIFLE_ROLLINGBLOCK", 50)
			elseif WarMenu.Button("             Pump Shotgun", "$25 LvL 10") then
                TriggerServerEvent("redemrp_gunshop:buygun", "pump_w", 25, "WEAPON_SHOTGUN_PUMP", 10)
            elseif WarMenu.Button("             Repeating Shotgun", "$40 LvL 20") then
                TriggerServerEvent("redemrp_gunshop:buygun", "repeating_w", 40, "WEAPON_SHOTGUN_REPEATING", 20)
            elseif WarMenu.Button("             Semi-auto Shotgun", "$55 LvL 30") then
                TriggerServerEvent("redemrp_gunshop:buygun", "semiauto-s_w", 55, "WEAPON_SHOTGUN_SEMIAUTO", 30)
            elseif WarMenu.Button("             Sawed-off Shotgun", "$70 LvL 50") then
                TriggerServerEvent("redemrp_gunshop:buygun", 70, "sawedoff_w", "WEAPON_SHOTGUN_SAWEDOFF", 50)
			end
            WarMenu.Display()

        elseif WarMenu.IsMenuOpened('handguns') then

            if WarMenu.Button("             Knife", "$2 LvL 1") then
                TriggerServerEvent("redemrp_gunshop:buygun", "knife_w", 2, "WEAPON_MELEE_KNIFE", 1)
            elseif WarMenu.Button("             Lantern", "$10 LvL 1") then
                TriggerServerEvent("redemrp_gunshop:buygun", "lantern_r_w", 10, "WEAPON_MELEE_DAVY_LANTERN", 1)
            elseif WarMenu.Button("             Bow", "$10 LvL 5") then
                TriggerServerEvent("redemrp_gunshop:buygun", "bow_w", 10, "WEAPON_BOW", 5)
            elseif WarMenu.Button("             Lasso", "$10 LvL 10") then
                TriggerServerEvent("redemrp_gunshop:buygun", "lasso_w", 10, "WEAPON_LASSO", 10)
            elseif WarMenu.Button("             Hatchet", "$10 LvL 15") then
                TriggerServerEvent("redemrp_gunshop:buygun", "hatchet_w", 10, "WEAPON_MELEE_HATCHET", 15)
            elseif WarMenu.Button("             Throwing knives", "$25 LvL 25") then
                TriggerServerEvent("redemrp_gunshop:buygun", "throwing_w", 25, "WEAPON_THROWN_THROWING_KNIVES", 25)
            elseif WarMenu.Button("             Electric Lantern", "$30 LvL 25") then
                TriggerServerEvent("redemrp_gunshop:buygun", "lantern_w", 30, "WEAPON_MELEE_LANTERN_ELECTRIC", 25)
            elseif WarMenu.Button("             Tomahawk", "$25 LvL 30") then
                TriggerServerEvent("redemrp_gunshop:buygun", "tomahawk_w", 25, "WEAPON_THROWN_TOMAHAWK", 30)
			end
            WarMenu.Display()

        elseif WarMenu.IsMenuOpened('Ammo') then

            if WarMenu.MenuButton('Pistols', 'pistolsammo') then end
            if WarMenu.MenuButton('Long Guns', 'longgunsammo') then end
            if WarMenu.MenuButton('Melee Weapons', 'handgunsammo') then end
            WarMenu.Display()

        elseif WarMenu.IsMenuOpened('pistolsammo') then

            if WarMenu.Button("         Revolver", "$3") then
                TriggerServerEvent("redemrp_gunshop:buyammo", 3, "revolver_ammo")
                PlaySoundFrontend("REWARD_NEW_GUN", "HUD_REWARD_SOUNDSET", true, 0)

            elseif WarMenu.Button("         Pistol", "$4") then
                TriggerServerEvent("redemrp_gunshop:buyammo", 4, "pistol_ammo")
                PlaySoundFrontend("REWARD_NEW_GUN", "HUD_REWARD_SOUNDSET", true, 0)

			end
            WarMenu.Display()

        elseif WarMenu.IsMenuOpened('longgunsammo') then

            if WarMenu.Button("             Repeator", "$2") then
                TriggerServerEvent("redemrp_gunshop:buyammo", 2, "repeator_ammo")
                PlaySoundFrontend("REWARD_NEW_GUN", "HUD_REWARD_SOUNDSET", true, 0)
            elseif WarMenu.Button("             22 Rifle", "$2") then
                TriggerServerEvent("redemrp_gunshop:buyammo", 2, "22_ammo")
                PlaySoundFrontend("REWARD_NEW_GUN", "HUD_REWARD_SOUNDSET", true, 0)
            elseif WarMenu.Button("             Rifle", "$3") then
                TriggerServerEvent("redemrp_gunshop:buyammo", 3, "rifle_ammo")
                PlaySoundFrontend("REWARD_NEW_GUN", "HUD_REWARD_SOUNDSET", true, 0)
            elseif WarMenu.Button("             Sniper Rifle", "$4") then
                TriggerServerEvent("redemrp_gunshop:buyammo", 4, "snipe_ammo")
                PlaySoundFrontend("REWARD_NEW_GUN", "HUD_REWARD_SOUNDSET", true, 0)
            elseif WarMenu.Button("             Shotgun Shells", "$3") then
                TriggerServerEvent("redemrp_gunshop:buyammo", 3, "shotgun_ammo")
                PlaySoundFrontend("REWARD_NEW_GUN", "HUD_REWARD_SOUNDSET", true, 0)
			end
            WarMenu.Display()

        elseif WarMenu.IsMenuOpened('handgunsammo') then

            if WarMenu.Button("             Arrows", "$5") then
                TriggerServerEvent("redemrp_gunshop:buyammo", 5, "arrows")
                PlaySoundFrontend("REWARD_NEW_GUN", "HUD_REWARD_SOUNDSET", true, 0)
            elseif WarMenu.Button("             Throwing knives", "$5") then
                TriggerServerEvent("redemrp_gunshop:buyammo", 5, "knives")
                PlaySoundFrontend("REWARD_NEW_GUN", "HUD_REWARD_SOUNDSET", true, 0)
			end
            WarMenu.Display()

        end

        Citizen.Wait(0)
    end
end)

RegisterNetEvent('redemrp_gunshop:alert')	
AddEventHandler('redemrp_gunshop:alert', function(txt)
    SetTextScale(0.5, 0.5)
    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", txt, Citizen.ResultAsLong())
    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)
end)

RegisterNetEvent('redemrp_gunshop:giveammo')
AddEventHandler('redemrp_gunshop:giveammo', function(type)
    local player = GetPlayerPed()
    local ammo = GetHashKey(type)
    SetPedAmmo(player, ammo, 100)
end)
