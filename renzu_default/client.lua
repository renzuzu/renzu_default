-- CREDITS https://github.com/OfficialDarkzy/DRP-Core/blob/master/drp_core/client.lua
Citizen.CreateThread(function()
    SetNuiFocus(false, false)
    DisableVehicleDistantlights(true)
    SwitchTrainTrack(0, true)   
    SwitchTrainTrack(3, true)   
    SetRandomTrains(1)
    SetOverrideWeather("CLEAR")
    StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE") -- disable shity ambience
    --CancelCurrentPoliceReport(1)
    DistantCopCarSirens(false)
end)
---------------------------------------------------------------------------
--- You Can Edit The Below To Your Requirements, 
--  only touch if you know what you are doing,
--  Darkzy will not help you if you break it
---------------------------------------------------------------------------
AddEventHandler("playerSpawned", function()
    Citizen.Wait(1000)
    Citizen.CreateThread(function()
        local ped = PlayerPedId()
        NetworkSetFriendlyFireOption(true) -- Enable Friendly Fire
        SetCanAttackFriendly(ped, true, true) -- Enable Friendly Fire
        SetMaxWantedLevel(0) -- Set Max Wanted Level to 0
        SetCreateRandomCops(0) -- Prevent AI Cop Creation
        SetCreateRandomCopsNotOnScenarios(0) -- Prevent AI Cop Creation
        SetCreateRandomCopsOnScenarios(0) -- Prevent AI Cop Creation
        SetPlayerHealthRechargeLimit(PlayerId(), 0) -- Disable Health Recharge
        SetPedMinGroundTimeForStungun(ped, 6000) -- Time spent on ground after being tased (in ms)
        SetPedConfigFlag(ped, 184, true) -- Disable Seat Shuffle
        SetPedConfigFlag(ped, 35, false) -- Disable Automatic Bike Helmet
        SwitchTrainTrack(0, true)   
        SwitchTrainTrack(3, true)   
        SetRandomTrains(1)
        StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE") -- disable shity ambience
        SetOverrideWeather("CLEAR")
    end)
end)
---------------------------------------------------------------------------
--- Core Thread
---------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
----------------------Remove Police Audio----------------------------------	
        DistantCopCarSirens(false)
----------------------Hiding Hud Components--------------------------------
      	if IsHudComponentActive(1) then 
            HideHudComponentThisFrame(1)  -- Wanted Stars
        end
			
        if IsHudComponentActive(2) then 
            HideHudComponentThisFrame(2) -- Weapon icon
        end
			
        if IsHudComponentActive(3) then 
            HideHudComponentThisFrame(3) -- Cash
        end
			
        if IsHudComponentActive(4) then
            HideHudComponentThisFrame(4) -- MP CASH
        end

		if IsHudComponentActive(14) then
			HideHudComponentThisFrame(14) -- Cross Hair
		end
		if IsHudComponentActive(9) then
			HideHudComponentThisFrame(9) -- STREET NAME
		end
		if IsHudComponentActive(7) then
			HideHudComponentThisFrame(7) -- Area NAME
		end
		if IsHudComponentActive(8) then
			HideHudComponentThisFrame(8) -- Vehicle Class
		end
		if IsHudComponentActive(6) then
			HideHudComponentThisFrame(6) -- Vehicle Name
		end
		DisablePlayerVehicleRewards(PlayerId())
        SetPedConfigFlag(PlayerPedId(), 35, false) --To prevent auto-motorcycle helmet
---------------------------------------------------------------------------
        Citizen.Wait(5)
    end
end)
Citizen.CreateThread(function() -- no idle
    while true do
		Citizen.Wait(5000)
		N_0x9e4cfff989258472()
		InvalidateIdleCam()
	end
end)
---------------------------------------------------------------------------
--- Prevent NPCs from dropping weapons when dead
---------------------------------------------------------------------------
function RemoveWeaponDrops()
    local pickupList = {`PICKUP_AMMO_BULLET_MP`,`PICKUP_AMMO_FIREWORK`,`PICKUP_AMMO_FLAREGUN`,`PICKUP_AMMO_GRENADELAUNCHER`,`PICKUP_AMMO_GRENADELAUNCHER_MP`,`PICKUP_AMMO_HOMINGLAUNCHER`,`PICKUP_AMMO_MG`,`PICKUP_AMMO_MINIGUN`,`PICKUP_AMMO_MISSILE_MP`,`PICKUP_AMMO_PISTOL`,`PICKUP_AMMO_RIFLE`,`PICKUP_AMMO_RPG`,`PICKUP_AMMO_SHOTGUN`,`PICKUP_AMMO_SMG`,`PICKUP_AMMO_SNIPER`,`PICKUP_ARMOUR_STANDARD`,`PICKUP_CAMERA`,`PICKUP_CUSTOM_SCRIPT`,`PICKUP_GANG_ATTACK_MONEY`,`PICKUP_HEALTH_SNACK`,`PICKUP_HEALTH_STANDARD`,`PICKUP_MONEY_CASE`,`PICKUP_MONEY_DEP_BAG`,`PICKUP_MONEY_MED_BAG`,`PICKUP_MONEY_PAPER_BAG`,`PICKUP_MONEY_PURSE`,`PICKUP_MONEY_SECURITY_CASE`,`PICKUP_MONEY_VARIABLE`,`PICKUP_MONEY_WALLET`,`PICKUP_PARACHUTE`,`PICKUP_PORTABLE_CRATE_FIXED_INCAR`,`PICKUP_PORTABLE_CRATE_UNFIXED`,`PICKUP_PORTABLE_CRATE_UNFIXED_INCAR`,`PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_SMALL`,`PICKUP_PORTABLE_CRATE_UNFIXED_LOW_GLOW`,`PICKUP_PORTABLE_DLC_VEHICLE_PACKAGE`,`PICKUP_PORTABLE_PACKAGE`,`PICKUP_SUBMARINE`,`PICKUP_VEHICLE_ARMOUR_STANDARD`,`PICKUP_VEHICLE_CUSTOM_SCRIPT`,`PICKUP_VEHICLE_CUSTOM_SCRIPT_LOW_GLOW`,`PICKUP_VEHICLE_HEALTH_STANDARD`,`PICKUP_VEHICLE_HEALTH_STANDARD_LOW_GLOW`,`PICKUP_VEHICLE_MONEY_VARIABLE`,`PICKUP_VEHICLE_WEAPON_APPISTOL`,`PICKUP_VEHICLE_WEAPON_ASSAULTSMG`,`PICKUP_VEHICLE_WEAPON_COMBATPISTOL`,`PICKUP_VEHICLE_WEAPON_GRENADE`,`PICKUP_VEHICLE_WEAPON_MICROSMG`,`PICKUP_VEHICLE_WEAPON_MOLOTOV`,`PICKUP_VEHICLE_WEAPON_PISTOL`,`PICKUP_VEHICLE_WEAPON_PISTOL50`,`PICKUP_VEHICLE_WEAPON_SAWNOFF`,`PICKUP_VEHICLE_WEAPON_SMG`,`PICKUP_VEHICLE_WEAPON_SMOKEGRENADE`,`PICKUP_VEHICLE_WEAPON_STICKYBOMB`,`PICKUP_WEAPON_ADVANCEDRIFLE`,`PICKUP_WEAPON_APPISTOL`,`PICKUP_WEAPON_ASSAULTRIFLE`,`PICKUP_WEAPON_ASSAULTSHOTGUN`,`PICKUP_WEAPON_ASSAULTSMG`,`PICKUP_WEAPON_AUTOSHOTGUN`,`PICKUP_WEAPON_BAT`,`PICKUP_WEAPON_BATTLEAXE`,`PICKUP_WEAPON_BOTTLE`,`PICKUP_WEAPON_BULLPUPRIFLE`,`PICKUP_WEAPON_BULLPUPSHOTGUN`,`PICKUP_WEAPON_CARBINERIFLE`,`PICKUP_WEAPON_COMBATMG`,`PICKUP_WEAPON_COMBATPDW`,`PICKUP_WEAPON_COMBATPISTOL`,`PICKUP_WEAPON_COMPACTLAUNCHER`,`PICKUP_WEAPON_COMPACTRIFLE`,`PICKUP_WEAPON_CROWBAR`,`PICKUP_WEAPON_DAGGER`,`PICKUP_WEAPON_DBSHOTGUN`,`PICKUP_WEAPON_FIREWORK`,`PICKUP_WEAPON_FLAREGUN`,`PICKUP_WEAPON_FLASHLIGHT`,`PICKUP_WEAPON_GRENADE`,`PICKUP_WEAPON_GRENADELAUNCHER`,`PICKUP_WEAPON_GUSENBERG`,`PICKUP_WEAPON_GOLFCLUB`,`PICKUP_WEAPON_HAMMER`,`PICKUP_WEAPON_HATCHET`,`PICKUP_WEAPON_HEAVYPISTOL`,`PICKUP_WEAPON_HEAVYSHOTGUN`,`PICKUP_WEAPON_HEAVYSNIPER`,`PICKUP_WEAPON_HOMINGLAUNCHER`,`PICKUP_WEAPON_KNIFE`,`PICKUP_WEAPON_KNUCKLE`,`PICKUP_WEAPON_MACHETE`,`PICKUP_WEAPON_MACHINEPISTOL`,`PICKUP_WEAPON_MARKSMANPISTOL`,`PICKUP_WEAPON_MARKSMANRIFLE`,`PICKUP_WEAPON_MG`,`PICKUP_WEAPON_MICROSMG`,`PICKUP_WEAPON_MINIGUN`,`PICKUP_WEAPON_MINISMG`,`PICKUP_WEAPON_MOLOTOV`,`PICKUP_WEAPON_MUSKET`,`PICKUP_WEAPON_NIGHTSTICK`,`PICKUP_WEAPON_PETROLCAN`,`PICKUP_WEAPON_PIPEBOMB`,`PICKUP_WEAPON_PISTOL`,`PICKUP_WEAPON_PISTOL50`,`PICKUP_WEAPON_POOLCUE`,`PICKUP_WEAPON_PROXMINE`,`PICKUP_WEAPON_PUMPSHOTGUN`,`PICKUP_WEAPON_RAILGUN`,`PICKUP_WEAPON_REVOLVER`,`PICKUP_WEAPON_RPG`,`PICKUP_WEAPON_SAWNOFFSHOTGUN`,`PICKUP_WEAPON_SMG`,`PICKUP_WEAPON_SMOKEGRENADE`,`PICKUP_WEAPON_SNIPERRIFLE`,`PICKUP_WEAPON_SNSPISTOL`,`PICKUP_WEAPON_SPECIALCARBINE`,`PICKUP_WEAPON_STICKYBOMB`,`PICKUP_WEAPON_STUNGUN`,`PICKUP_WEAPON_SWITCHBLADE`,`PICKUP_WEAPON_VINTAGEPISTOL`,`PICKUP_WEAPON_WRENCH`, `PICKUP_WEAPON_RAYCARBINE`}
    local player = PlayerId()
    for a = 1, #pickupList do
		N_0x616093ec6b139dd9(player, pickupList[a], false)
    end
end
---------------------------------------------------------------------------
Citizen.CreateThread(function()     
    RemoveWeaponDrops()
end)