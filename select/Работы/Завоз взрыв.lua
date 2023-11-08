
return
{
    name = 'Завоз взрыв',
    icon = 'BOMB',
    hint = [[Нужно быть на литейном заводе, аккуратней с людьми рядом]],
    func =
    function()
        BlockSyncJob = true
        handler('dialog', {t = 'Литейный завод', s = 2, i = 'Привезти взрычатку'})
        SendSync{ pos= {-1889.25, -1628.625, 17.875}, pick = cfg['Пикапы']['-3500.02'].id}
        Задержка(0.1)
        local id, x, y, z = InCar(428)
        Задержка(0.1)
        SendSync{pos = {-991.33636474609 , -697.14733886719 , 32.133438110352}, manual = "vehicle", id = id}
        Задержка(0.1)
        SendSync{pos = {-1876.2556152344 , -1630.1643066406 , 21.75}, manual = "vehicle", id = id}
    end
}