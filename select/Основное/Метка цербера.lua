
return
{
    name = 'Метка цербера',
    icon = 'MAGNIFYING_GLASS',
    hint = [[Обязательно нужен разлом]],
    func =
    function()
        local _, oX, oY, oZ = getObjectCoordinatesByModelID(1550)
        if not _  or oX == 0 then return error('Нет тайника', 3) end
        placeWaypoint(oX, oY, oZ)
        msg("Метка устаовлена", 3)
    end
}