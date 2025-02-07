local TMPui = 1
local moneyuiTemplate = 1
local moneyui = 1
local moneygui = 1
local playerhand = 1

function onLoad()
    callFunctionIn("QueueOnLoadFunctions", 0.2)
end

function QueueOnLoadFunctions()
    if game.initialized == true then
        if loadValue("money", -100) == -100 then
            saveInt("money", 0)
            debugLog(loadValue("money", -100))
            callFunctionIn("newquota", 0.2)
        end

        playerhand = game.playerController.leftHand

        base.LoadAssetBundle("mods/lethal_dungeon/gui")
        base.LoadAssetBundle("mods/lethal_dungeon/quota")

        moneyuiTemplate = base.GetObjectFromAssetBundle("money","UnityEngine.GameObject")
    
        moneyui = game.SpawnObject(moneyuiTemplate, playerhand.transform.position) -- prev game.SpawnObject
        moneyui.transform.localScale = vector3.__new(0.125,0.125,0.125)
        
        moneyui.transform.SetParent(playerhand.transform)
        moneyui.transform.rotation = playerhand.transform.rotation
        moneyui.transform.position = playerhand.transform.position + vector3.__new(0, 0.25, 0)
    
        moneygui = moneyui
        TMPui = getComponent(moneygui.transform.Find("Canvas/Text (TMP)").gameObject, "TextMeshProUGUI")
        TMPui.SetText(tostring(loadValue("money", -200)))

        quotauiTemplate = base.GetObjectFromAssetBundle("quota","UnityEngine.GameObject")
        quotaui = game.SpawnObject(quotauiTemplate, playerhand.transform.position)
        local GreenUi = getComponent(quotaui.transform.Find("Canvas/Image").gameObject,"RectTransform")
        local xValue = 10 / quota.totaldays * quota.daysleft
        GreenUi.localScale = vector3.__new(xValue,1,1)

    else
      callFunctionIn("QueueOnLoadFunctions", 0.2)
  end
end

function onGlobalTick()
    if game.initialized == true then
        if loadValue("money", -100) ~= -100 then
            TMPui.SetText(tostring(loadValue("money", -100)))
        end
    end
end

function newquota()
    saveInt("q-money", loadValue("q-money", 0) - loadValue("q-cost", 0))
    saveInt("q-totaldays", math.random(5, 14))
    saveInt("q-daysspent", loadValue("q-totaldays", -100))
    saveInt("q-streak", loadValue("q-streak", -1) + 1)
    saveInt("quotaamount", math.random(125, 455))
end

function quotaend(typeid)


function onPlayerDied()
    saveInt("daysspent", loadValue("daysspent", -100) + 1)

    if loadValue("daysspent", -100) == loadValue("totaldays", -100) then
        if loadValue("money") >= loadValue("quotaamount", -100) then
            quotaend(true)
            callFunctionIn("newquota", 0.2)
        else
            quotaend(false)
        end
    else 
        return
    end   
end