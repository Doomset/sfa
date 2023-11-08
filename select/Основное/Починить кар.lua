
return
{
    name = 'Починить кар',
    icon = 'SCREWDRIVER_WRENCH',
    hint = [[Починка тачки обычной функой, ремнаборы никак не задействуются, не варнит.]],
    func =
    function()
        if not isCharInAnyCar(PLAYER_PED) then return error('Нужно быть в машине', 3) end
        setCarHealth(storeCarCharIsInNoSave(PLAYER_PED), 1000)
        addOneOffSound(0.0, 0.0, 0.0, 1133)
    end
}