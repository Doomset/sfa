
return
{
    name = '�������5',
    icon = 'TRUCK_PICKUP',
    hint = [[������]],
    func =
    function()
        NoKick()
        handler('dialog', {t = '����������'})
        SendSync{pos = cfg['������']['-45.27'].pos, pick = cfg['������']['-45.27'].id}
        local id, x, y, z = InCar(543)
        SendSync{ pos = {-2389.5192871094, 2360.2790527344, 4.181459903717}, manual = "vehicle", id = id}
        handler('dialog', {t = 'Hardy'})
        handler('dialog', {t = 'Hardy', s = 1, i = '�������� ������ 5.000$'})
        SendSync{ pos = {273.64016723633, 1418.4503173828, 10.285536766052}, manual = "vehicle", id = id, key = 2}
        ��������(1)
        SendSync{ pos = {273.64016723633, 1418.4503173828, 10.285536766052}, manual = "vehicle", id = id, key = 2}
        ��������(1)

        SendSync{ pos = {-2389.5192871094, 2360.2790527344, 4.181459903717}, manual = "vehicle", id = id}
    --	SendSync{ pos = {273.64016723633, 1418.4503173828, 10.285536766052}, manual = "vehicle", id = id, key = 2}
    end
}