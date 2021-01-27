local data = {}
TriggerEvent("redemrp_inventory:getData",function(call)
    data = call
end)

RegisterServerEvent('redemrp_gunshop:buygun')
AddEventHandler("redemrp_gunshop:buygun", function(name, price, weapon, lvl)
    local _source = tonumber(source)
    local ItemData = data.getItem(_source, weapon)
    local ItemInfo = data.getItemData(weapon)
    local label = ItemInfo.label
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        local identifier = user.getIdentifier()
		local level = user.getLevel()
        if user.getMoney() >= price then
            if level >= lvl then
                user.removeMoney(price)
                ItemData.AddItem(50)
                TriggerClientEvent("redemrp_notification:start", source, "Bought Weapon "..label.."!", 3, "success")
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
            user.removeMoney(price)
            local ItemData = data.getItem(_source, item)
            ItemData.AddItem(1)
            TriggerClientEvent("redemrp_notification:start", source, "Bought ammo!", 3, "success")
        else
            TriggerClientEvent('redemrp_gunshop:alert', source, "You dont have enough money!")
        end
	end)
end)

--
-- Usable Ammos
--
-------- Revolver
RegisterServerEvent("RegisterUsableItem:revolver_ammo")
AddEventHandler("RegisterUsableItem:revolver_ammo", function(source)
    TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_REVOLVER_CATTLEMAN")
    data.delItem(source,"revolver_ammo", 1)
end)
-------- Pistol
RegisterServerEvent("RegisterUsableItem:pistol_ammo")
AddEventHandler("RegisterUsableItem:pistol_ammo", function(source)
    TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_PISTOL_MAUSER")
    local ItemData = data.getItem(source, 'pistol_ammo')
    ItemData.RemoveItem(1)
end)
-------- 22 Ammo
RegisterServerEvent("RegisterUsableItem:22_ammo")
AddEventHandler("RegisterUsableItem:22_ammo", function(source)
    TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_RIFLE_VARMINT")
    local ItemData = data.getItem(source, '22_ammo')
    ItemData.RemoveItem(1)
end)
-------- Rifle
RegisterServerEvent("RegisterUsableItem:rifle_ammo")
AddEventHandler("RegisterUsableItem:rifle_ammo", function(source)
    TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_RIFLE_BOLTACTION")
    local ItemData = data.getItem(source, 'rifle_ammo')
    ItemData.RemoveItem(1)
end)
-------- Shotgun Shells
RegisterServerEvent("RegisterUsableItem:shotgun_ammo")
AddEventHandler("RegisterUsableItem:shotgun_ammo", function(source)
    TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_SHOTGUN_DOUBLEBARREL")
    local ItemData = data.getItem(source, 'shotgun_ammo')
    ItemData.RemoveItem(1)
end)

-------- Repeater
RegisterServerEvent("RegisterUsableItem:repeator_ammo")
AddEventHandler("RegisterUsableItem:repeator_ammo", function(source)
    TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_REPEATER_EVANS")
    local ItemData = data.getItem(source, 'repeator_ammo')
    ItemData.RemoveItem(1)
end)
-------- Sniper
RegisterServerEvent("RegisterUsableItem:snipe_ammo")
AddEventHandler("RegisterUsableItem:snipe_ammo", function(source)
    TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_SNIPERRIFLE_CARCANO")
    local ItemData = data.getItem(source, 'snipe_ammo')
    ItemData.RemoveItem(1)
end)
-------- Arrows
RegisterServerEvent("RegisterUsableItem:arrows")
AddEventHandler("RegisterUsableItem:arrows", function(source)
    TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_BOW")
    local ItemData = data.getItem(source, 'arrows')
    ItemData.RemoveItem(1)
end)
-------- Knives
RegisterServerEvent("RegisterUsableItem:knives")
AddEventHandler("RegisterUsableItem:knives", function(source)
    TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_THROWN_THROWING_KNIVES")
    local ItemData = data.getItem(source, 'knives')
    ItemData.RemoveItem(1)
end)
