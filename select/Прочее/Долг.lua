
return
{
    name = 'Долг',
    icon = 'USER',
    hint = [[Активка сталков с ЛВ для сбора артов,не кикает, варнит]],
    func =
    function()
        handler('dialog', {t = 'База Долга', s = 0, i = 'Искать оружие', button = 0})
        SendSync{ pos = {1065, 1768, 2522}, pick = cfg['Пикапы']['5354.76'].id, force = true}
    end
}