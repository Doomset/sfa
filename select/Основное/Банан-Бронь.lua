--  handler('dialog', {t = 'Рюкзак', s = 1})
-- handler('dialog', {t = 'Ваше'}) -- открывает диалог с тамарой??!!?!!
-- handler('dialog', {t = 'Ваше Досье'})dd
return
{
    name = 'Банан-Бронь',
    icon = 'BANANA',
    hint = [[Сбивается диалогом]],
    func =
    function()
        handler('dialog', {t = 'Рюкзак', s = 1})
        handler('dialog', {t = 'Ваше Досье', s = 0, button = 0})
        SendSync{ pos =  cfg['Пикапы']['3857.18'].pos,  pick = cfg['Пикапы']['3857.18'].id, force = true, specialKey = 64}
        SendSync{ pos = {288, -112, 1102}, pick = cfg['Пикапы']['1277.43'].id, force = true}
    end
}

