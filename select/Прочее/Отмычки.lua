
return
{
    name = 'Отмычки',
    icon = 'PAPERCLIP',
    hint = [[Масла масла для учёных масла,не кикает, варнит]],
    func =
    function()
        handler('dialog', {t = 'Гараж', s = 4, i = 'Отмычка (100$)'})
        SendSync{pos = {615.625, -72, 997.875}, pick = cfg['Пикапы']['1541.55'].id, force = true}
    end
}