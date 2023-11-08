
return
{
    name = 'Метка луна',
    icon = 'MOON',
    hint = [[Обязательно нужен разлом]],
    func =
    function()
        local _, oX, oY, oZ = getObjectCoordinatesByModelID(19299)
        if not _ then return error('Нет луны', 3) end
        placeWaypoint(oX, oY, oZ)
        msg("Метка установлена", 3)
    end
}