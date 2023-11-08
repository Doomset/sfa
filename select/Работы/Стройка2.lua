
return
{
    name = 'Стройка2',
    icon = 'BRUSH',
    hint = [[Маляр, запускать можно хоть с конца карты]],
    func =
    function()
        NoKick()

        handler('dialog', {t = 'Нащальника'})
        SendSync{pos = cfg['Пикапы']['-45.27'].pos, pick = cfg['Пикапы']['-45.27'].id}


        job(function()
            for i = 1, 101 do
                SendSync{pos = {-2058.6716308594, 306.81567382813, 1005.0213012695}, key = 4, weapon = 41}
                SendSync{pos = {-2058.6716308594, 306.81567382813, 1005.0213012695}, key = 0, weapon = 0}
                SendSync{pos = {-2054.7211914063, 304.29876708984, 1005.0213012695}, key = 4, weapon = 41}
                SendSync{pos = {-2054.7211914063, 304.29876708984, 1005.0213012695}, key = 0, weapon = 0}
                SendSync{pos = {-2050.4577636719, 308.15893554688, 1005.0213012695}, key = 4, weapon = 41}
                SendSync{pos = {-2050.4577636719, 308.15893554688, 1005.0213012695}, key = 0, weapon = 0}
                SendSync{pos = {-2054.0185546875, 311.34295654297, 1005.0213012695}, key = 4, weapon = 41}
                SendSync{pos = {-2050.4577636719, 308.15893554688, 1005.0213012695}, key = 0, weapon = 0}
            end
        end)
    end
}