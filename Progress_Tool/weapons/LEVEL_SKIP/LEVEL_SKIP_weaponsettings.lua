function onLoad()
    combo.comboName = "shotgun"
    combo.primaryWeaponName = "shotgun"
    combo.secondaryWeaponName = "(bugged)"
    combo.primaryWeapon = nil
    combo.secondaryWeapon = game.stringToObjectMapper.GetObject("weapon_player_dagger")
    combo.orderInUI = 9999
end

function onWeaponComboSelected()
    -- set the default values of this weapon combo --
    player.PrimaryDamage.ChangeAddend("defaultValue", 15)
    player.SecondaryDamage.ChangeAddend("defaultValue", 3)
end

function isUnlocked()
    return game.IsSinglePlayer()
end