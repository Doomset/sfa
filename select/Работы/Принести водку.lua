
return
{
    name = 'Принести водку',
    icon = 'WINE_BOTTLE',
    hint = [[Масла масла для учёных масла,не кикает, варнит]],
    func =
    function()
        NoKick()
        handler('dialog', {t = 'Алкозавод'})
        SendSync{ pos = {-68, -255, 994}, pick = cfg['Пикапы']['670.98'].id, force = true}
        Задержка(3.3)


        Взять_Квест(0)
        handler('dialog', {t = 'Работы в Зоне'})
        --handler('dialog', {t = 'Работы в Зоне'})
        --SendSync{pos = {615.625, -72, 997.875}, pick = cfg['Пикапы']['1541.55'].id, force = true}
    end
}