
return
{
    name = 'Травка',
    icon = 'JOINT',
    hint = [[Масла масла для учёных масла,не кикает, варнит]],
    func =
    function()
        NoKick()
        handler('dialog', {t = 'Малина'})
        handler('dialog', {t = 'Малина', button = 0})
        SendSync{ pos = {-794, 2445, 1064}, pick = cfg['Пикапы']['2715.59'].id, force = true}
        Задержка(3.5)
        handler('dialog', {t = 'Бандиты'})
        SendSync{ pos = {-793, 2439, 1064}, pick = cfg['Пикапы']['2710.49'].id, force = true}
        Задержка(3.5)
        for i=1,6 do
            SendSync{ pos = {-1016, -1231, 130}, pick = cfg['Пикапы']['-2116.79'].id, force = true}
        end
        SendSync{ pos = {-226, 1407, 70}, pick = cfg['Пикапы']['1251.87'].id, force = true}
        handler('dialog', {t = 'Чёрный рынок', s = 1, i = 'Сдать травку'})
        SendSync{ pos = {-782, 2438, 1064}, pick = cfg['Пикапы']['2720.55'].id, force = true}
    end
}