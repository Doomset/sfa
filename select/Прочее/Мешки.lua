
return
{
    name = 'Мешки',
    icon = 'SACK',
    hint = [[Масла масла для учёных масла,не кикает, варнит]],
    func =
    function()
        NoKick()
        SendSync{pos = {282, 1793, 18}, key = 1024}
        Задержка(1)
        SendSync{pos = {-448, 2065, 61}, key = 1024}
        Задержка(1)
        SendSync{pos = {-379, 2713, 63}, key = 1024}
        Задержка(1)
        SendSync{pos = {-1498, 2515, 56}, key = 1024}
        Задержка(1)
        SendSync{pos = {-864, 1426, 14}, key = 1024}
    end
}