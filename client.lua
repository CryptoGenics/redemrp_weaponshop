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

MenuData = {}
TriggerEvent("redemrp_menu_base:getData",function(call)
    MenuData = call
end)

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
	MenuData.CloseAll()
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
                ShopMenu()
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

function ShopMenu()
    MenuData.CloseAll()
    local elements = {
            {label = "Pistols", value = 'pistols'},
            {label = "Long Guns", value = 'longguns'},
            {label = "Melee Weapons", value = 'handguns'},
            {label = "Ammo", value = 'ammo'}
    }
    MenuData.Open('default', GetCurrentResourceName(), 'weaponshop_main', {
        title    = 'Weapon Shop',
        subtext    = 'choose a category',
        align    = 'top-left',
        elements = elements,
    }, function(data, menu)
        local elements2 = {}
        local OpenSub = false
        local category = data.current.value
        if category == 'pistols' then
            elements2 = {
                {label = "Cattleman Revolver", value = 'cattleman_w', weapon = 'WEAPON_REVOLVER_CATTLEMAN', price = 10, lvl = 1, subtext = '$10 LvL 1'},
                {label = "Double Action Revolver", value = 'doubleaction_w', weapon = 'WEAPON_REVOLVER_DOUBLEACTION', price = 12, lvl = 5, subtext = '$12 LvL 5'},
                {label = "Volcanic", value = 'volcanic_w', weapon = 'WEAPON_PISTOL_VOLCANIC', price = 20, lvl = 10, subtext = '$20 LvL 10'},
                {label = "Semi-auto Pistol", value = 'semiauto-p_w', weapon = 'WEAPON_PISTOL_SEMIAUTO', price = 22, lvl = 15, subtext = '$22 LvL 15'},
                {label = "Mauser", value = 'mauser_w', weapon = 'WEAPON_PISTOL_MAUSER', price = 30, lvl = 20, subtext = '$30 LvL 20'},
                {label = "M 1899", value = 'm1899_w', weapon = 'WEAPON_PISTOL_M1899', price = 40, lvl = 30, subtext = '$40 LvL 30'},
                {label = "Lemat Revolver", value = 'lemat_w', weapon = 'WEAPON_REVOLVER_LEMAT', price = 50, lvl = 40, subtext = "$50 LvL 40"}
            }
            OpenSub = true
        elseif category == 'longguns' then
            elements2 = {
                {label = "Carbine Repeator", value = 'carbine_w', weapon = 'WEAPON_REPEATER_CARBINE', price = 20, lvl = 1, subtext = '$20 LvL 1'},
                {label = "Varmint Rifle", value = 'varmint_w', weapon = 'WEAPON_RIFLE_VARMINT', price = 15, lvl = 1, subtext = "$15 LvL 1"},
                {label = "Evans Repeater", value = 'evans_w', weapon = 'WEAPON_REPEATER_EVANS', price = 30, lvl = 5, subtext = "$30 LvL 5"},
                {label = "Bolt Action Rifle", value = 'bolt_w', weapon = 'WEAPON_RIFLE_BOLTACTION', price = 40, lvl = 10, subtext = "$40 LvL 10"},
                {label = "Carcano Rifle", value = 'carcano_w', weapon = 'WEAPON_SNIPERRIFLE_CARCANO', price = 70, lvl = 30, subtext = "$70 LvL 30"},
                {label = "Rolling Block Rifle", value = 'rolling_w', weapon = 'WEAPON_SNIPERRIFLE_ROLLINGBLOCK', price = 100, lvl = 50, subtext = "$100 LvL 50"},
                {label = "Pump Shotgun", value = 'pump_w', weapon = 'WEAPON_SHOTGUN_PUMP', price = 25, lvl = 10, subtext = "$25 LvL 10"},
                {label = "Repeating Shotgun", value = 'repeating_w', weapon = 'WEAPON_SHOTGUN_REPEATING', price = 40, lvl = 20, subtext = "$40 LvL 20"},
                {label = "Semi-auto Shotgun", value = 'semiauto-s_w', weapon = 'WEAPON_SHOTGUN_SEMIAUTO', price = 55, lvl = 30, subtext = "$55 LvL 30"},
                {label = "Sawed-off Shotgun", value = 'sawedoff_w', weapon = 'WEAPON_SHOTGUN_SAWEDOFF', price = 70, lvl = 50, subtext = "$70 LvL 50"}
            }
            OpenSub = true
        elseif category == 'handguns' then
            elements2 = {
                {label = "Knife", value = 'knife_w', weapon = 'WEAPON_MELEE_KNIFE', price = 2, lvl = 1, subtext = '$2 LvL 1'},
                {label = "Lantern", value = 'lantern_r_w', weapon = 'WEAPON_MELEE_DAVY_LANTERN', price = 10, lvl = 1, subtext = "$10 LvL 1"},
                {label = "Bow", value = 'bow_w', weapon = 'WEAPON_BOW', price = 10, lvl = 5, subtext = "$10 LvL 5"},
                {label = "Lasso", value = 'lasso_w', weapon = 'WEAPON_LASSO', price = 10, lvl = 10, subtext = "$10 LvL 10"},
                {label = "Hatchet", value = 'hatchet_w', weapon = 'WEAPON_MELEE_HATCHET', price = 10, lvl = 15, subtext = "$10 LvL 15"},
                {label = "Throwing knives", value = 'throwing_w', weapon = 'WEAPON_THROWN_THROWING_KNIVES', price = 25, lvl = 25, subtext = "$25 LvL 25"},
                {label = "Electric Lantern", value = 'lantern_w', weapon = 'WEAPON_MELEE_LANTERN_ELECTRIC', price = 30, lvl = 25, subtext = "$30 LvL 25"},
                {label = "Tomahawk", value = 'tomahawk_w', weapon = 'WEAPON_THROWN_TOMAHAWK', price = 25, lvl = 30, subtext = "$25 LvL 30"}
            }
            OpenSub = true
        elseif category == 'ammo' then
            local options = {
                {label = 'Pistols', value = 'pistols'},
                {label = 'Long Guns', value = 'longgunsammo'},
                {label = 'Melee Weapons', value = 'handgunsammo'},
            }
            MenuData.Open('default', GetCurrentResourceName(), 'weaponshop_ammo', {
                title    = 'Ammo Shop',
                align    = 'top-left',
                elements = options,
            }, function(data2, menu2)
                local choice = data2.current.value
                local ammochoices = {}

                if choice == 'pistols' then
                    ammochoices = {
                        {label = "Revolver", value = 'revolver_ammo', price = 3, subtext = '$3'}, 
                        {label = "Pistol", value = 'pistol_ammo', price = 4, subtext = '$4'}
                    }
                elseif choice == 'longgunsammo' then
                    ammochoices = {
                        {label = "Repeator", value = 'repeator_ammo', price = 2, subtext = '$2'},
                        {label = "22 Rifle", value = '22_ammo', price = 2, subtext = '$2'},
                        {label = "Rifle", value = 'rifle_ammo', price = 3, subtext = '$3'},
                        {label = "Sniper Rifle", value = 'snipe_ammo', price = 4, subtext = '$4'},
                        {label = "Shotgun Shells", value = 'shotgun_ammo', price = 3, subtext = '$3'}
                    }
                elseif choice == 'handgunsammo' then
                    ammochoices = {
                        {label = "Arrows", value = 'arrows', price = 5, subtext = '$5'}, 
                        {label = "Throwing knives", value = 'knives', price = 5, subtext = '$5'}, 
                    }
                end

                MenuData.Open('default', GetCurrentResourceName(), 'weaponshop_'..category, {
                    title    = category..' Shop',
                    align    = 'top-left',
                    elements = ammochoices,
                }, function(data3, menu3)
                    local item = data3.current.value
                    local price = data3.current.price
                    TriggerServerEvent("redemrp_gunshop:buyammo", tonumber(price), item)
                end, function(data3, menu3)
                    menu3.close()
                end)
            end, function(data3, menu3)
                menu3.close()
            end) 
        end

        if OpenSub == true then
            OpenSub = false
            MenuData.Open('default', GetCurrentResourceName(), 'weaponshop_'..category, {
                title    = category..' Shop',
                align    = 'top-left',
                elements = elements2,
            }, function(data2, menu2)
                local weapon = data2.current.weapon
                local item = data2.current.value
                local price = data2.current.price
                local lvl = data2.current.lvl
                TriggerServerEvent("redemrp_gunshop:buygun", item, tonumber(price), weapon,  tonumber(lvl))
            end, function(data2, menu2)
                menu2.close()
            end) 
        end
    end, function(data, menu)
        menu.close()
    end) 
end

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

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        PromptSetEnabled(ShopPrompt, false)
        PromptSetVisible(ShopPrompt, false)
    end
end)
