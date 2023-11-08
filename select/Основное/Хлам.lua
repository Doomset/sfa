

return
{
    name = 'Хлам',
    icon = 'DUMPSTER',
    hint = [[cборка фейковой синхрой всех пикапов хлама в зоне.
upd: обновлено, добавлена возможность выставлять задержку между этапами, возможность отключить спавн, ПКМ для настройки]],
    func =
    function()
        NoKick()
        handler('dialog', {t = 'Рабочее место'})
        SendSync{ pos = {211, 2610, 17}, pick = cfg['Пикапы']['2837.88'].id, force = true}
        SendSync{ pos = {159, 2412, 18}, pick = cfg['Пикапы']['2588.92'].id, force = true}
        SendSync{ pos = {623, 2205, 24}, pick = cfg['Пикапы']['2851.63'].id, force = true}
        SendSync{ pos = {698, 1293, 15}, pick = cfg['Пикапы']['2006.33'].id, force = true}
        SendSync{ pos = {185, 1345, 11}, pick = cfg['Пикапы']['1540.85'].id, force = true}
        SendSync{ pos = {-126, 1126, 20}, pick = cfg['Пикапы']['1020.55'].id, force = true}
        SendSync{ pos = {615, -72, 1498}, pick = cfg['Пикапы']['2040.68'].id, force = true}
    end
}
