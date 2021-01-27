local data = {}
TriggerEvent("redemrp_inventory:getData",function(call)
    data = call
end)

RegisterServerEvent('redemrp_gunshop:buygun')
AddEventHandler("redemrp_gunshop:buygun", function(name, price, weapon, lvl)
    local _source = tonumber(source)
    print(price)
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        local identifier = user.getIdentifier()
		local level = user.getLevel()
        if user.getMoney() >= price then
            if level >= lvl then
                user.removeMoney(price)
                if Config.RedemrpInventory2 == false then
                    data.addItem(_source, name, 100, GetHashKey(weapon))
                    TriggerClientEvent("redemrp_notification:start", _source, "Bought a weapon!", 3, "success")
                elseif Config.RedemrpInventory2 == true then
                    local ItemData = data.getItem(_source, weapon)
                    local ItemInfo = data.getItemData(weapon)
                    local label = ItemInfo.label
                    ItemData.AddItem(100)
                    TriggerClientEvent("redemrp_notification:start", _source, "Bought a"..label.." !", 3, "success")
                end
            else 
                TriggerClientEvent('redemrp_gunshop:alert', source, "You are not a high enough level!")
            end
        else
            TriggerClientEvent('redemrp_gunshop:alert', source, "You dont have enough money!")
        end
    end)
end)

RegisterServerEvent('redemrp_gunshop:buyammo')
AddEventHandler('redemrp_gunshop:buyammo', function(price, item)
local _source = source
	TriggerEvent('redemrp:getPlayerFromId', _source, function(user) 
        if user.getMoney() >= price then
            if Config.RedemrpInventory2 == false then
                local ItemData = data.getItem(_source, item)
                local label = ItemInfo.label
                ItemData.AddItem(1)
                user.removeMoney(price)
                TriggerClientEvent("redemrp_notification:start", _source, "Bought "..label.." !", 3, "success")
            elseif Config.RedemrpInventory2 == true then
                user.removeMoney(price)
                data.addItem(source, item, 1)
                TriggerClientEvent("redemrp_notification:start", _source, "Bought ammo!", 3, "success")
            end
        else
            TriggerClientEvent('redemrp_gunshop:alert', _source, "You dont have enough money!")
        end
	end)
end)

--
-- Usable Ammos
--
-------- Revolver
RegisterServerEvent("RegisterUsableItem:revolver_ammo")
AddEventHandler("RegisterUsableItem:revolver_ammo", function(source)
    if Config.RedemrpInventory2 == false then
        TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_REVOLVER_CATTLEMAN")
        data.delItem(source,"revolver_ammo", 1)
    elseif Config.RedemrpInventory2 == true then
        TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_REVOLVER_CATTLEMAN")
        local ItemData = data.getItem(source, 'revolver_ammo')
        ItemData.RemoveItem(1)
    end
end)
-------- Pistol
RegisterServerEvent("RegisterUsableItem:pistol_ammo")
AddEventHandler("RegisterUsableItem:pistol_ammo", function(source)
    if Config.RedemrpInventory2 == false then
        TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_PISTOL_MAUSER")
        data.delItem(source,"pistol_ammo", 1)
    elseif Config.RedemrpInventory2 == true then
        TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_PISTOL_MAUSER")
        local ItemData = data.getItem(source, 'pistol_ammo')
        ItemData.RemoveItem(1)
    end
end)
-------- 22 Ammo
RegisterServerEvent("RegisterUsableItem:22_ammo")
AddEventHandler("RegisterUsableItem:22_ammo", function(source)
    if Config.RedemrpInventory2 == false then
        TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_RIFLE_VARMINT")
        data.delItem(source,"22_ammo", 1)
    elseif Config.RedemrpInventory2 == true then
        TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_RIFLE_VARMINT")
        local ItemData = data.getItem(source, '22_ammo')
        ItemData.RemoveItem(1)
    end
end)
-------- Rifle
RegisterServerEvent("RegisterUsableItem:rifle_ammo")
AddEventHandler("RegisterUsableItem:rifle_ammo", function(source)
    if Config.RedemrpInventory2 == false then
        TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_RIFLE_BOLTACTION")
        data.delItem(source,"rifle_ammo", 1)
    elseif Config.RedemrpInventory2 == true then
        TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_RIFLE_BOLTACTION")
        local ItemData = data.getItem(source, 'rifle_ammo')
        ItemData.RemoveItem(1)
    end
end)
-------- Shotgun Shells
RegisterServerEvent("RegisterUsableItem:shotgun_ammo")
AddEventHandler("RegisterUsableItem:shotgun_ammo", function(source)
    if Config.RedemrpInventory2 == false then
        TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_SHOTGUN_DOUBLEBARREL")
        data.delItem(source,"shotgun_ammo", 1)
    elseif Config.RedemrpInventory2 == true then
        TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_SHOTGUN_DOUBLEBARREL")
        local ItemData = data.getItem(source, 'shotgun_ammo')
        ItemData.RemoveItem(1)
    end
end)

-------- Repeater
RegisterServerEvent("RegisterUsableItem:repeator_ammo")
AddEventHandler("RegisterUsableItem:repeator_ammo", function(source)
    if Config.RedemrpInventory2 == false then
        TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_REPEATER_EVANS")
        data.delItem(source,"repeator_ammo", 1)
    elseif Config.RedemrpInventory2 == true then
        TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_REPEATER_EVANS")
        local ItemData = data.getItem(source, 'repeator_ammo')
        ItemData.RemoveItem(1)
    end
end)
-------- Sniper
RegisterServerEvent("RegisterUsableItem:snipe_ammo")
AddEventHandler("RegisterUsableItem:snipe_ammo", function(source)
    if Config.RedemrpInventory2 == false then
        TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_SNIPERRIFLE_CARCANO")
        data.delItem(source,"snipe_ammo", 1)
    elseif Config.RedemrpInventory2 == true then
        TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_SNIPERRIFLE_CARCANO")
        local ItemData = data.getItem(source, 'snipe_ammo')
        ItemData.RemoveItem(1)
    end
end)
-------- Arrows
RegisterServerEvent("RegisterUsableItem:arrows")
AddEventHandler("RegisterUsableItem:arrows", function(source)
    if Config.RedemrpInventory2 == false then
        TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_BOW")
        data.delItem(source,"arrows", 1)
    elseif Config.RedemrpInventory2 == true then
        TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_BOW")
        local ItemData = data.getItem(source, 'arrows')
        ItemData.RemoveItem(1)
    end
end)
-------- Knives
RegisterServerEvent("RegisterUsableItem:knives")
AddEventHandler("RegisterUsableItem:knives", function(source)
    if Config.RedemrpInventory2 == false then
        TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_THROWN_THROWING_KNIVES")
        data.delItem(source,"knives", 1)
    elseif Config.RedemrpInventory2 == true then
        TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_THROWN_THROWING_KNIVES")
        local ItemData = data.getItem(source, 'knives')
        ItemData.RemoveItem(1)
    end
end)
