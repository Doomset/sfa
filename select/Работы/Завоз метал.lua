
return
{
    name = '����� �����',
    icon = 'TRUCK_RAMP_BOX',
    hint = [[����� ���� �� �������� ������, ���������� � ������ �����]],
    func =
    function()
        handler('dialog', {t = '�������� �����', s = 3, i = '�������� ����������'})
        SendSync{ pos= {-1889.25, -1628.625, 17.875}, pick = cfg['������']['-3500.02'].id}
        handler('dialog', {t = '�������'})
        ��������(0.1)
        local id, x, y, z = InCar(443) -- get job

        ��������(0.1)
        SendSync { pos = {182.09590148926,1351.2012939453,10.585900306702}, manual = "vehicle", id = id}
        ��������(0.1)
        SendSync { pos = {-1857.2010498047,-1681.3620605469,22.3892993927}, manual = "vehicle", id = id}
    end
}