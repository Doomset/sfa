
return
{
    name = 'Стройка3',
    icon = 'SNOWPLOW',
    hint = [[Бульдозер]],
    func =
    function()
        NoKick()
        handler('dialog', {t = 'Нащальника'})
        SendSync{pos = cfg['Пикапы']['-45.27'].pos, pick = cfg['Пикапы']['-45.27'].id}
        job(function()
            local id, x, y, z = InCar(486)
            for i = 1, 20 do
                SendSync{ pos = {-2396.3903808594 , 2369.6166992188 , 4.8384461402893}, manual = "vehicle", id = id}
                SendSync{ pos = {-2389.1042480469 , 2383.0881347656 , 8.8554458618164}, manual = "vehicle", id = id}
                SendSync{ pos = {-2401.9743652344 , 2378.4541015625 , 7.2699084281921}, manual = "vehicle", id = id}
                SendSync{ pos = {-2404.1513671875 , 2385.9267578125 , 8.2823190689087}, manual = "vehicle", id = id}
            end
        end)
        BlockSyncJob = false
    end
}