
return
{
    name = 'Стройка4',
    icon = 'TRUCK',
    hint = [[Цемент]],
    func =
    function()
        NoKick()
        handler('dialog', {t = 'Нащальника'})
        handler('dialog', {t = 'Стройка'})
        SendSync{pos = cfg['Пикапы']['-45.27'].pos, pick = cfg['Пикапы']['-45.27'].id}
        job(function()
            local id, x, y, z = InCar(524)
            SendSync{ pos = {583, 1274, 13}, manual = "vehicle", id = id}
            SendSync{ pos = {-2389.5078125 , 2360.1401367188 , 4.3702354431152}, manual = "vehicle", id = id}
        end)

        BlockSyncJob = false
    end
}