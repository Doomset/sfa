
return
{
    name = 'Завоз метал',
    icon = 'TRUCK_RAMP_BOX',
    hint = [[Нужно быть на литейном заводе, аккуратней с людьми рядом]],
    func =
    function()
        handler('dialog', {t = 'Литейный завод', s = 3, i = 'Привезти металлолом'})
        SendSync{ pos= {-1889.25, -1628.625, 17.875}, pick = cfg['Пикапы']['-3500.02'].id}
        handler('dialog', {t = 'Ломовоз'})
        Задержка(0.1)
        local id, x, y, z = InCar(443) -- get job

        Задержка(0.1)
        SendSync { pos = {182.09590148926,1351.2012939453,10.585900306702}, manual = "vehicle", id = id}
        Задержка(0.1)
        SendSync { pos = {-1857.2010498047,-1681.3620605469,22.3892993927}, manual = "vehicle", id = id}
    end
}