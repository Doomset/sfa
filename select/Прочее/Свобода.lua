
return
{
    name = 'Свобода',
    icon = 'USER',
    hint = [[Активка сталков с ЛВ для сбора артов,не кикает, варнит]],
    func =
    function()
        handler('dialog', {t = 'База Свободы', s = 0, i = 'Искать оружие'})
        SendSync{ pos = {1090, 2099, -5}, pick = cfg['Пикапы']['3184.17'].id}
    end
}