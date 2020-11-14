# redemrp_weaponshop
RedM weaponshop made for redem_roleplay and redemrp_inventory V2

# Installation
1. Clone this repository.
2. Extract the zip.
3. Put redemrp_weaponshop to your resource folder.
4. Add "start redemrp_weaponshop" in your "server.cfg".
5. In redemrp_inventory/Config.lua under Config.Items add 

Like this with the names below for weapons :

```["WEAPON_REVOLVER_CATTLEMAN"] =
	{
		label = "Cattleman",
		description = "",
		weight = 0.9,
		canBeDropped = true,
		requireLvl = 0,
		weaponHash = GetHashKey("WEAPON_REVOLVER_CATTLEMAN"),
		imgsrc = "items/Cattleman.png",
		type = "item_weapon",
	},

--
    --weapons
    ["cattleman_w"] = "Cattleman",
    ["doubleaction_w"] = "DoubleAction",
    ["volcanic_w"] = "Volcanic",
    ["semiauto-p_w"] = "SemiAuto",
    ["mauser_w"] = "Mauser",
    ["m1899_w"] = "M1899",
    ["lemat_w"] = "Lemat",
    ["carbine_w"] = "Repeater",
    ["varmint_w"] = "Varmint",
    ["evans_w"] = "Evans",
    ["bolt_w"] = "Bolt",
    ["carcano_w"] = "Carcano", 
    ["rolling_w"] = "Rolling BL", 
    ["pump_w"] = "Pump",
    ["repeating_w"] = "Repeating",
    ["semiauto_w"] = "SemiAuto", 
    ["sawedoff_w"] = "SawedOff", 
    ["knife_w"] = "Knife",
    ["lantern_w"] = "E-Lantern",
    ["bow_w"] = "Bow",
    ["lasso_w"] = "Lasso",
    ["hatchet_w"] = "Hatchet",
    ["throwing_w"] = "Throwing",
    ["tomahawk_w"] = "Tomahawk",
    ["lantern_r_w"] = "Lantern",
```

Then like this example with ammunition:
```
["revolver_ammo"] =
    {
        label = "Ammo Revolver",
        description = "",
        weight = 0.02,
        canBeDropped = true,
        canBeUsed = false,
        requireLvl = 0,
        limit = 64,
        imgsrc = "items/ammo.png",
        type = "item_standard",
    },

With the names below 
    -- ammos
    ["22_ammo"] = "22 Ammo",
    ["rifle_ammo"] = "Rifle Ammo",
    ["shotgun_ammo"] = "Shotgun Ammo",
    ["revolver_ammo"] = "Revolver Ammo",
    ["pistol_ammo"] = "Pistol Ammo",
    ["repeator_ammo"] = "Repeator Ammo",
    ["snipe_ammo"] = "Sniper Ammo",
    ["arrows"] = "Arrows",
    ["knives"] = "Knife Reload",
 ```

5. Profit

# Required resource
- redem_roleplay
- redemrp_inventory
- redemrp_notification

# Made by
- CryptoGenics
