
return
{
    name = 'Спиздить залп',
    icon = 'ROCKET',
    hint = [[Варнит и пишет админам что ты взял залп, нужно быть дома, не кикает]],
    func =
    function()
        SendSync{pos = cfg['Пикапы']['6292.5'].pos, pick = cfg['Пикапы']['6292.5'].id}
        SendSync{pos = cfg['Пикапы']['4868.25'].pos, pick = cfg['Пикапы']['4868.25'].id}
    end
}