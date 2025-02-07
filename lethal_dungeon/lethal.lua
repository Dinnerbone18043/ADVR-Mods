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
        end
        playerhand = game.playerController.leftHand
        base.LoadAssetBundle("mods/lethal_dungeon/gui")

        moneyuiTemplate = base.GetObjectFromAssetBundle("money","UnityEngine.GameObject")
    
        moneyui = game.SpawnObject(moneyuiTemplate, playerhand.transform.position) -- prev game.SpawnObject
        moneyui.transform.localScale = vector3.__new(0.125,0.125,0.125)
        
        moneyui.transform.SetParent(playerhand.transform)
        moneyui.transform.rotation = playerhand.transform.rotation
        moneyui.transform.position = playerhand.transform.position + vector3.__new(0, 0.25, 0)
    
        moneygui = moneyui
        TMPui = getComponent(moneygui.transform.Find("Canvas/Text (TMP)").gameObject, "TextMeshProUGUI")
        TMPui.SetText(tostring(loadValue("money", -200)))
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
