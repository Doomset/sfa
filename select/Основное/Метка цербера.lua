
return
{
    name = '����� �������',
    icon = 'MAGNIFYING_GLASS',
    hint = [[����������� ����� ������]],
    func =
    function()
        local _, oX, oY, oZ = getObjectCoordinatesByModelID(1550)
        if not _  or oX == 0 then return error('��� �������', 3) end
        placeWaypoint(oX, oY, oZ)
        msg("����� ������������", 3)
    end
}