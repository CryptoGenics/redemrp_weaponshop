local data = {}
TriggerEvent("redemrp_inventory:getData",function(call)
    data = call
end)

RegisterServerEvent('redemrp_gunshop:buygun')
AddEventHandler("redemrp_gunshop:buygun", function(name, price, weapon, lvl)
    local _source = tonumber(source)
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        local identifier = user.getIdentifier()
		local level = user.getLevel()
        if user.getMoney() >= price then
            if level >= lvl then
                user.removeMoney(price)
                data.addItem(_source, name, 100, GetHashKey(weapon))
                TriggerClientEvent("redemrp_notification:start", source, "Bought Weapon!", 3, "success")
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
            data.addItem(source, item, 1)
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
    data.delItem(source,"pistol_ammo", 1)
end)
-------- 22 Ammo
RegisterServerEvent("RegisterUsableItem:22_ammo")
AddEventHandler("RegisterUsableItem:22_ammo", function(source)
    TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_RIFLE_VARMINT")
    data.delItem(source,"22_ammo", 1)
end)
-------- Rifle
RegisterServerEvent("RegisterUsableItem:rifle_ammo")
AddEventHandler("RegisterUsableItem:rifle_ammo", function(source)
    TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_RIFLE_BOLTACTION")
    data.delItem(source,"rifle_ammo", 1)
end)
-------- Shotgun Shells
RegisterServerEvent("RegisterUsableItem:shotgun_ammo")
AddEventHandler("RegisterUsableItem:shotgun_ammo", function(source)
    TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_SHOTGUN_DOUBLEBARREL")
    data.delItem(source,"shotgun_ammo", 1)
end)

-------- Repeater
RegisterServerEvent("RegisterUsableItem:repeator_ammo")
AddEventHandler("RegisterUsableItem:repeator_ammo", function(source)
    TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_REPEATER_EVANS")
    data.delItem(source,"repeator_ammo", 1)
end)
-------- Sniper
RegisterServerEvent("RegisterUsableItem:snipe_ammo")
AddEventHandler("RegisterUsableItem:snipe_ammo", function(source)
    TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_SNIPERRIFLE_CARCANO")
    data.delItem(source,"snipe_ammo", 1)
end)
-------- Arrows
RegisterServerEvent("RegisterUsableItem:arrows")
AddEventHandler("RegisterUsableItem:arrows", function(source)
    TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_BOW")
    data.delItem(source,"arrows", 1)
end)
-------- Knives
RegisterServerEvent("RegisterUsableItem:knives")
AddEventHandler("RegisterUsableItem:knives", function(source)
    TriggerClientEvent('redemrp_gunshop:giveammo', source, "WEAPON_THROWN_THROWING_KNIVES")
    data.delItem(source,"knives", 1)
end)
