
return
{
    name = 'тпчек',
    icon = 'LOCATION_DOT',
    hint = [[Тпнуться на любой чекпоинт]],
    func =
    function()
        local _, x, y, z, type  = isAnyCheckpointExist()
        if not _ then return error("Нет чекпоинта",2) end
        NoKick()
        setCharCoordinates(PLAYER_PED, x, y, z)
    end
}