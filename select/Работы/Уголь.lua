
return
{
    name = 'Уголь',
    icon = 'GEM',
    hint = [[Заспавниться, сделать уголь в вирт.мире]],
    func =
    function()
        spawn()
        BlockSync = true
        ygoll = true

        SendSync{pos= {-1889.25, -1628.625, 17.875}, pick = cfg["Пикапы"]['-3500'].id}

        wait(3500)

        SendSync(-1905.625 , -1624.125 , 7.375, key, 439)

        setCharCoordinates(playerPed, -2175.9050292969, -1628.7752685547, 9.5837745666504)
        wait(1200)
        setCharCoordinates(playerPed, -2071.7768554688 , -1632.375 , 9.5705986022949)
        wait(10500)
        setCharCoordinates(playerPed, -2175.9050292969, -1628.7752685547, 9.5837745666504)
        NoKick()
        wait(100)
        for i = 0, 10 do wait(1000)
            SendSync(-2152.75, -1627.375, 13, key, 440)
            NoKick()
        end
        wait(1000)
        spawn()
        restoreCameraJumpcut()

        BlockSync = true
    end
}