
return
{
    name = 'Починить шмот',
    icon = 'SUITCASE_ROLLING',
    hint = [[Нужна ткань, её можно собрать вместе с электодеталями]],
    func =
    function()
        handler('dialog', {t = 'Ткань:'})
        SendSync{ pos = {440.22219848633, -88.09935760498, 1499.5537109375}, key = 1024}
    end
}