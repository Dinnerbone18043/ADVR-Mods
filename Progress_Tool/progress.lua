local TMPui = 1
local moneyuiTemplate = 1
local moneyui = 1
local moneygui = 1
local playerhand = 1
local xValue = 1
local GreenUi = 1
local TMPgui = 1

function onLoad()
    callFunctionIn("QueueOnLoadFunctions", 0.2)
end

function QueueOnLoadFunctions()
    if game.initialized == true then
        if loadValue("q-money", -100) == -100 then
            saveInt("q-money", 0)
            debugLog(loadValue("q-money", -100))
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
        moneyui.transform.position = playerhand.transform.position + vector3.__new(0, -0.25, 0)
    
        moneygui = moneyui
        TMPui = getComponent(moneygui.transform.Find("Canvas/Text (TMP)").gameObject, "TextMeshProUGUI")
        TMPui.SetText(tostring(loadValue("q-money", -200)))

        quotauiTemplate = base.GetObjectFromAssetBundle("quota","UnityEngine.GameObject")
        quotaui = game.SpawnObject(quotauiTemplate, playerhand.transform.position)
        GreenUi = getComponent(quotaui.transform.Find("Canvas/Image").gameObject,"RectTransform")
        xValue = 10 / loadValue("q-totaldays") * loadValue("q-daysspent")
        GreenUi.localScale = vector3.__new(xValue,1,1)
        TMPgui = getComponent(moneygui.transform.Find("Canvas/days").gameObject, "TextMeshProUGUI")
    else
      callFunctionIn("QueueOnLoadFunctions", 0.2)
    end
end

function onGlobalTick()
    if game.initialized == true then
        if loadValue("q-money", -100) ~= -100 then
            TMPui.SetText(tostring(loadValue("q-money", -100)))
        end
        if loadValue("q-totaldays", -100) ~= -100 then
            TMPgui.SetText(tostring(loadValue("q-totaldays", -100)))
        end
    end
end

function newquota()
    saveInt("q-money", loadValue("q-money", 0) - loadValue("q-cost", 0))
    saveInt("q-totaldays", math.random(5, 14))
    saveInt("q-daysspent", loadValue("q-totaldays", -100))
    saveInt("q-streak", loadValue("q-streak", -1) + 1)
    saveInt("q-quotaamount", math.random(125, 455))
    xValue = 10 / loadValue("q-totaldays") * loadValue("q-daysspent")
    GreenUi.localScale = vector3.__new(xValue,1,1)
end

function onPlayerDeath()
    if game.isSinglePlayer() then
        xValue = 10 / loadValue("q-totaldays") * loadValue("q-daysspent")
        GreenUi.localScale = vector3.__new(xValue,1,1)
        saveInt("q-daysspent", loadValue("q-daysspent", -100) + 1)

        if loadValue("q-daysspent", -100) == loadValue("q-totaldays", -100) then
            if loadValue("q-money") >= loadValue("q-quotaamount", -100) then
                callFunctionIn("newquota", 0.2)
            else
                saveInt("q-streak", 0)
                callFunctionIn("newquota", 0.2)
            end
        else 
            return
        end   
    end
end

function onPartyDeath()
    xValue = 10 / loadValue("q-totaldays") * loadValue("q-daysspent")
    GreenUi.localScale = vector3.__new(xValue,1,1)
    saveInt("q-daysspent", loadValue("q-daysspent", -100) + 1)
    
    if loadValue("q-daysspent", -100) == loadValue("q-totaldays", -100) then
        if loadValue("q-money") >= loadValue("q-quotaamount", -100) then
            callFunctionIn("newquota", 0.2)
        else
            saveInt("q-streak", 0)
            callFunctionIn("newquota", 0.2)
        end
    else 
        return
    end   
end

function onRunComplete()
    xValue = 10 / loadValue("q-totaldays") * loadValue("q-daysspent")
    GreenUi.localScale = vector3.__new(xValue,1,1)
    saveInt("q-daysspent", loadValue("q-daysspent", -100) + 1)
    
    if loadValue("q-daysspent", -100) == loadValue("q-totaldays", -100) then
        if loadValue("q-money") >= loadValue("q-quotaamount", -100) then
            callFunctionIn("newquota", 0.2)
        else
            saveInt("q-streak", 0)
            callFunctionIn("newquota", 0.2)
        end
    else 
        return
    end   
end