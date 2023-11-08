
return
{
    name = '/cклад в ЛВ',
    icon = 'GEARS',
    hint = [[Просто нажать]],
    func =
    function()
        handler('dialog', {t = 'База'})
        SendSync{pos = {1056.125 , 2087.125, -9}, pic = 681}
        SendSync{pos = {1089.875, 2098.875, -4.625}, pic = 435}
    end
}