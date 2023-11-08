
return
{
    name = 'Монолит',
    icon = 'USER',
    hint = [[Активка сталков с ЛВ для сбора артов,не кикает, варнит]],
    func =
    function()
        handler('dialog', {t = 'База Монолита', s = 0, i = 'Искать оружие', button = 0})
        SendSync{ pos = {1054, 1254, 11}, pick = cfg['Пикапы']['2319.21'].id}
    end
}