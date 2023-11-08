
return
{
    name = 'Постирать шмот',
    icon = 'SUITCASE_ROLLING',
    hint = [[Вероятно варнит]],
    func =
    function()
        handler('dialog', {t = 'Прачечная', s = -1, i = ''})
        SendSync{ pos = {1498.0112304688, 1306.1448974609, 1593.2890625}, key = 1024}
    end
}