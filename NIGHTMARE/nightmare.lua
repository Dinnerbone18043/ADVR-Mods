function onLoad()
    base.loadAssetBundle("mods/NIGHTMARE/flashlight")
end

function onPlayerHit(damage)
    return damage * 2
end

function onDungeonGenerated(worldGenerator)
    debugLog("dungeon generated!")
    if helperMethods.isInFirstDungeon(worldGenerator) == true then
        debugLog("in first dungeon")
        game.SetAmbientLight(col(0, 0, 0, 1))
        debugLog("color set")
        local flashlightTemplate = base.GetObjectFromAssetBundle("flashlight","UnityEngine.GameObject")
        debugLog("template loaded")
	    local flashlight = game.SpawnObject(flashlightTemplate, game.playerController.leftHand.transform.position)
        debugLog("spawned...???")
	    flashlight.transform.SetParent(game.playerController.leftHand.transform)
        debugLog("parent set")
        flashlight.transform.rotation = game.playerController.leftHand.transform.rotation
        debugLog("rotation set")
    end
end