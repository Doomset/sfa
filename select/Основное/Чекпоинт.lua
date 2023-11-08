
return
{
    name = 'Чекпоинт',
    icon = 'LOCATION_DOT',
    hint = [[Если есть любой из чекпоинтов будет послана синхра к нему(визуально ты стоишь на месте, у других нет)]],
    func =
    function()
        local _, x, y, z, type  = isAnyCheckpointExist()
        if not _ then return error("Нет чекпоинта",2) end
        NoKick()
        SendSync{ pos = {x, y, z}}
    end
}