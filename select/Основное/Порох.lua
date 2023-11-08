
return
{
    name = 'Порох',
    icon = 'FIRE',
    hint = [[Заспавнит соберёт всякую хуйню и сделает порох 5 - 1 шт]],
    func =
    function()
        for i = 1, 3 do
            SendSync{pos = {2147 , -2255 , 13}, pick = 714}

            SendSync{pos = {2147, -2255, 13}, pick = 713}
            SendSync{pos = {2147 , -2255 , 13}, pick = 712}
            SendSync{pos = {2147 , -2255 , 13}, pick = 715}
            SendSync{ pos = {1619, 2209, 11}, pick = cfg['Пикапы']['3839'].id, force = true} -- сера

            SendSync{pos = {1782.5705566406, 2115.5239257813, 3.90625}, key = 1024}
        end
    end
}