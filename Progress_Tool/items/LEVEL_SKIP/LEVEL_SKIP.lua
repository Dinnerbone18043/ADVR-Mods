function onLoad()
	pickup.name = "Dead Flashlight"
	pickup.desc = "gain 125 money \n<color=#FFFF00><i>LETHAL</i></color>"
	pickup.probability = 1.0
	pickup.maxAmount = 1
	pickup.tier = 2
	pickup.amountUses = -1
	pickup.price = 145
	pickup.spawnsIn = {"podest", "secret", "goldenChest", "chest"}
	pickup.supportedInMultiplayer = true
	pickup.isSharedItem = true
end

function onPickup()
	pickup.registerItem()
	saveInt("q-money", loadValue("q-money" + 10))
end

function onPickupProxies(originalPlayerRef)

end