
return
{
    name = 'Корабль2',
    icon = 'SHIP',
    hint = [[Нужно быть у корабля,не кикает, аккуратней с людьми рядом]],
    func =
    function()
        if isCharInAnyCar(PLAYER_PED) then
            local x, y, z = getCharCoordinates(PLAYER_PED)
            warpCharFromCarToCoord(PLAYER_PED, x, y + 1, z)
        end
        korabl2 = true
        BlockSync = true
        NoKick()
        SendSync{pos = {-2283.2202148438 , 2283.6125488281 , 4.9713096618652}, pick = 562}
        wait(200)
        InCar(530)
        wait(500)
        for i = 0, 20 do
            SendSync{pos = {-2338.2321777344, 2322.4128417969, 4.7524437904358}}
            SendSync{pos = {-2286.9799804688, 2284.2963867188, 4.973482131958}}
        end
        BlockSync = false

    end
}