
return
{
    name = 'Стройка',
    icon = 'SACK',
    hint = [[Запускать можно откуда угодно и где угодно]],
    func =
    function()
        NoKick()

        handler('dialog', {t = 'Нащальника'})
        SendSync{pos = cfg['Пикапы']['-45.27'].pos, pick = cfg['Пикапы']['-45.27'].id}

        job(function()
            for i = 1, 12 do
                SendSync{pos = {-2387.1374511719 , 2365.0344238281 , 3.8995151519775}}
                SendSync{pos = {-2060.998046875 , 316.69290161133 , 1009.2188110352}}
            end
        end)
    end
}